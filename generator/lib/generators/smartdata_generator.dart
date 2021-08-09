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
    final config = readConfig(annotation, element);
    final typeList = config['classesToGenerate'] as List<DartObject>;
    final build = <Spec>[];
    final classesToGenerate =
        typeList.map((type) => type.toTypeValue()!.element!).toList();
    for (final clazz in classesToGenerate) {
      if (clazz is! ClassElement) {
        throw InvalidGenerationSourceError(
            '${element.displayName} is not a class and a generator cannot be created for this',
            element: element,
            todo: 'Only add classes to the generatable classes');
      }
      build.add(buildClass(clazz));
    }

    build.add(buildInit(classesToGenerate));

    final lib = generateLibrary(build, classesToGenerate);
    final emitter = DartEmitter(
      allocator: Allocator.simplePrefixing(),
      orderDirectives: true,
      useNullSafetySyntax: true,
    );
    return '${lib.accept(emitter)}';
  }
}
