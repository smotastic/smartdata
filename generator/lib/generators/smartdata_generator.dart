import 'package:analyzer/dart/constant/value.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:smartdata/smartdata.dart';
import 'package:smartdata_generator/code_builders/generator_class_builder.dart';
import 'package:smartdata_generator/code_builders/init_builder.dart';
import 'package:smartdata_generator/code_builders/library_builder.dart';

import 'package:source_gen/source_gen.dart';

/// Codegenerator to generate implemented mapping classes
class SmartdataGenerator extends GeneratorForAnnotation<SmartdataInit> {
  static Map<String, dynamic> readConfig(
      ConstantReader annotation, Element element) {
    final smartdataAnno =
        element.metadata.first.element!.enclosingElement as ClassElement;
    final config = <String, dynamic>{};
    smartdataAnno.fields.forEach((field) {
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
    for (final type in typeList) {
      final original = type.toTypeValue()!.element!;
      if (original is! ClassElement) {
        throw InvalidGenerationSourceError(
            '${element.displayName} is not a class and a generator cannot be created for this',
            element: element,
            todo: 'Only add classes to the generatable classes');
      }
      build.add(buildClass(original));
    }

    build.add(buildInit());

    final lib = generateLibrary(build);
    final emitter = DartEmitter(
      allocator: Allocator.simplePrefixing(),
      orderDirectives: true,
      useNullSafetySyntax: true,
    );
    return '${lib.accept(emitter)}';
  }
}
