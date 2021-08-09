import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';

Library generateLibrary(List<Spec> body, List<Element> classesToGenerate) {
  final imports = classesToGenerate
      .map((clazz) => clazz.library!.identifier)
      .toSet()
      .map((e) => Directive.import(e));

  final lib = Library(
    (b) => b
      ..body.addAll(body)
      ..directives.addAll(
          [Directive.import('package:smartdata/smartdata.dart'), ...imports]),
  );
  return lib;
}
