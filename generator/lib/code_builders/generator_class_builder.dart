import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';

Class buildClass(Element element) {
  final clazz = Class((b) => b
    ..name = '${element.displayName}Generator'
    ..extend = refer('Generator'));
  return clazz;
}
