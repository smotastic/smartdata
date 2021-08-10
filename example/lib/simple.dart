class Simple {
  final int id;
  final String name;
  final num finalNumber;
  final SimpleNested nested;
  final double dub;

  int? number;

  Simple(this.id, this.name, this.finalNumber, this.nested, this.dub);
}

class SimpleNested {
  final int id;

  SimpleNested(this.id);
}
