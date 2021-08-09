import 'package:code_builder/code_builder.dart';

generateLibrary(List<Spec> body) {
  final lib = Library(
    (b) => b
      ..body.addAll(body)
      ..directives.add(Directive.import('package:generis/generis.dart')),
  );
  return lib;
}
