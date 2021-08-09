import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';

Spec buildInit(List<Element> classesToGenerate) {
  final mapperImpl = Method((b) => b
    ..name = '\$init'
    ..body = _generateBody(classesToGenerate));
  return mapperImpl;
}

Code _generateBody(List<Element> classesToGenerate) {
  final blockBuilder = BlockBuilder();
  for (final clazz in classesToGenerate) {
    // Smartdata.put(Simple, SimpleGenerator());
    blockBuilder.addExpression(
      refer('Smartdata').property('put').call([
        refer(clazz.displayName),
        refer('${clazz.displayName}Generator').newInstance([])
      ]),
    );
  }
  return blockBuilder.build();
}
