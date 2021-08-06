import 'package:build/build.dart';
import 'package:generis_generator/generators/generis_generator.dart';
import 'package:source_gen/source_gen.dart';

/// Main Builder for the [GenerisInit] Annotation
Builder generisBuilder(BuilderOptions options) =>
    PartBuilder([GenerisGenerator()], '.g.dart');
