import 'package:build/build.dart';
import 'package:smartdata_generator/generators/smartdata_generator.dart';
import 'package:source_gen/source_gen.dart';

/// Main Builder for the [SmartdataInit] Annotation
Builder smartdataBuilder(BuilderOptions options) =>
    LibraryBuilder(SmartdataGenerator(), generatedExtension: '.smart.dart');
