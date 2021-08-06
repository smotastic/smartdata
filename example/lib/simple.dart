import 'package:generis/generis.dart';

part 'simple.g.dart';

@GenerisInit(classesToGenerate: [Simple])
void init() {
  $init();
}

class Simple {
  final int id;
  final String name;

  Simple(this.id, this.name);
}
