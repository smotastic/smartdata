class Simple {
  final int id;
  final String name;
  final num finalNumber;
  final SimpleNested nested;

  int? number;

  Simple(this.id, this.name, this.finalNumber, this.nested);
}

class SimpleNested {
  final int id;

  SimpleNested(this.id);
}
