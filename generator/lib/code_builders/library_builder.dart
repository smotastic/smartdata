import 'package:code_builder/code_builder.dart';

Library generateLibrary(List<Spec> body) {
  final lib = Library(
    (b) => b
      ..body.addAll(body)
      ..directives.add(Directive.import('package:smartdata/smartdata.dart')),
  );
  return lib;
}
