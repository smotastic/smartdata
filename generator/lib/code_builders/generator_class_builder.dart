import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';

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

  final positionalArgs = <Expression>[];
  final namedArgs = <String, Expression>{};
  for (final param in constructor.parameters) {
    final typeOfField = param.type.getDisplayString(withNullability: true);
    if (_mapper.containsKey(typeOfField)) {
      final methodCall = _mapper[typeOfField]!;
      if (param.isNamed) {
        namedArgs.putIfAbsent(param.displayName, () => refer(methodCall));
      } else {
        positionalArgs.add(refer(methodCall));
      }
    }
  }

  // for (final field in clazz.fields) {
  //   final typeOfField = field.type.getDisplayString(withNullability: true);
  //   if (_mapper.containsKey(typeOfField)) {
  //     final methodCall = _mapper[typeOfField];
  //   }
  // }

  final newInstance = refer(clazz.displayName)
      .newInstance(positionalArgs, namedArgs)
      .assignFinal(varName);
  builder.addExpression(newInstance);

  builder.addExpression(refer(varName).returned);
  return builder.build();
}

Map<String, String> _mapper = {'String': 'randomString', 'int': 'randomInt'};
