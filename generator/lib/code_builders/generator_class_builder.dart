import 'package:analyzer/dart/element/element.dart';
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
  final builder = BlockBuilder();
  return builder.build();
}
