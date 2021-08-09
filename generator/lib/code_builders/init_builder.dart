import 'package:code_builder/code_builder.dart';

Spec buildInit() {
  final mapperImpl = Method((b) => b
    ..name = '\$init'
    ..body = _generateBody());
  return mapperImpl;
}

Code _generateBody() {
  final blockBuilder = BlockBuilder();
  return blockBuilder.build();
}
