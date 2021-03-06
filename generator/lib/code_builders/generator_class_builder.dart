import 'dart:math';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:smartdata/smartdata.dart';

Class buildClass(ClassElement clazz) {
  return Class(
    (b) => b
      ..name = '${clazz.displayName}Generator'
      ..extend = refer('Generator')
      ..methods.add(_buildGenerateMethod(clazz)),
  );
}

Method _buildGenerateMethod(ClassElement clazz) {
  return Method(
    (b) => b
      ..name = 'generateRandom'
      ..annotations.add(CodeExpression(Code('override')))
      ..returns = refer(clazz.displayName)
      ..body = _buildGenerateMethodBody(clazz),
  );
}

Code _buildGenerateMethodBody(ClassElement clazz) {
  final varName = clazz.displayName.toLowerCase();
  final builder = BlockBuilder();
  final constructor =
      clazz.constructors.firstWhere((element) => !element.isFactory);

  final classFields = {for (var f in clazz.fields) f.displayName: f};

  final positionalArgs = <Expression>[];
  final namedArgs = <String, Expression>{};
  for (final param in constructor.parameters) {
    final expression = _buildGenerateExpression(param.type);
    if (param.isNamed) {
      namedArgs.putIfAbsent(param.displayName, () => expression);
    } else {
      positionalArgs.add(expression);
    }

    classFields.remove(param.displayName);
  }
  final newInstance = refer(clazz.displayName)
      .newInstance(positionalArgs, namedArgs)
      .assignFinal(varName);
  builder.addExpression(newInstance);

  // remaining fields which were not in the constructor
  classFields.forEach((fieldName, field) {
    final expression = _buildGenerateExpression(field.type);
    builder
        .addExpression(refer(varName).property(fieldName).assign(expression));
  });

  builder.addExpression(refer(varName).returned);
  return builder.build();
}

Expression _buildGenerateExpression(DartType type) {
  final typeName = type.getDisplayString(withNullability: false);
  var expression = _buildGenerateSingleExpression(typeName);
  if (type.isDartCoreList || type.isDartCoreIterable) {
    final genericType = _getGenericTypes(type).first;
    expression = _buildGenerateMultiExpression(
        genericType.getDisplayString(withNullability: false));
  }
  return expression;
}

Expression _buildGenerateSingleExpression(String forType) {
  return refer('Smartdata')
      .property('I')
      .property('getSingle<$forType>')
      .call([]);
}

Expression _buildGenerateMultiExpression(String forType) {
  return refer('Smartdata')
      .property('I')
      .property('get<$forType>')
      .call([literalNum(10)]);
}

Iterable<DartType> _getGenericTypes(DartType type) {
  return type is ParameterizedType ? type.typeArguments : const [];
}
