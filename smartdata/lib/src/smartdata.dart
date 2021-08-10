import 'package:smartdata/src/generator.dart';

import 'default_generators.dart';

class Smartdata {
  static Smartdata get I => Smartdata();

  List<T> get<T>(int amount) {
    final gen = _findGenerator<T>();
    return _numbers.take(amount).map((e) => gen.generateRandom() as T).toList();
  }

  T getSingle<T>() {
    final gen = _findGenerator<T>();
    return gen.generateRandom();
  }

  Generator _findGenerator<T>() {
    final gen = _generators[T];
    if (gen == null) {
      throw 'Generator for type $T does not exist. Please provide one or generate him';
    }
    return gen;
  }

  Iterable<int> get _numbers sync* {
    var i = 0;
    while (true) {
      yield i++;
    }
  }

  static final Map<Type, Generator> _generators = {
    int: NumGenerator(),
    num: NumGenerator(),
    String: StringGenerator(),
    bool: BooleanGenerator(),
    double: DoubleGenerator(),
  };

  static void put(Type key, Generator val) {
    _generators.putIfAbsent(key, () => val);
  }
}
