import 'package:analyzer/dart/constant/value.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:generis/generis.dart';
import 'package:source_gen/source_gen.dart';

/// Codegenerator to generate implemented mapping classes
class GenerisGenerator extends GeneratorForAnnotation<GenerisInit> {
  static Map<String, dynamic> readConfig(
      ConstantReader annotation, Element element) {
    final generisAnno =
        element.metadata.first.element!.enclosingElement as ClassElement;
    final config = <String, dynamic>{};
    generisAnno.fields.forEach((field) {
      final configField = annotation.read(field.name).literalValue;
      config.putIfAbsent(field.name, () => configField);
    });
    return config;
  }

  @override
  dynamic generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    // if (element is! ClassElement) {
    //   throw InvalidGenerationSourceError(
    //       '${element.displayName} is not a class and cannot be annotated with @Mapper',
    //       element: element,
    //       todo: 'Add Mapper annotation to a class');
    // }

    final config = readConfig(annotation, element);
    final typeList = config['classesToGenerate'] as List<DartObject>;
    final build = <Spec>[];
    for (DartObject type in typeList) {
      print(type.toTypeValue()!.element!.displayName);
      build.add(Class((b) =>
          b..name = '${type.toTypeValue()!.element!.displayName}Generator'));
    }
    final mapperImpl = Method((b) => b
      ..name = '\$init'
      ..body = _generateBody());
    build.add(mapperImpl);

    final emitter = DartEmitter();
    String inti = "";
    return build.fold(inti,
        (value, element) => (value as String) + '${element.accept(emitter)}');

    // return '${mapperImpl.accept(emitter)}';
  }

  Code _generateBody() {
    final blockBuilder = BlockBuilder();
    return blockBuilder.build();
  }
}
