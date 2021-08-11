import 'dart:math';

import 'package:smartdata/src/generator.dart';

/// A default [Generator] to produce random nums
class NumGenerator extends Generator<num> {
  final _random = Random();
  final _nums = <num>[1, 2, 3, 4];
  @override
  num generateRandom() {
    return _nums[_random.nextInt(_nums.length)];
  }
}

/// A default [Generator] to produce random doubles
class DoubleGenerator extends Generator<double> {
  final _random = Random();
  final _nums = <double>[1.5, 2.1, 3.3, 4.45];
  @override
  double generateRandom() {
    return _nums[_random.nextInt(_nums.length)];
  }
}

/// A default [Generator] to produce random strings
class StringGenerator extends Generator<String> {
  final _random = Random();
  final _strings = ['bulbasaur', 'ivysaur', 'venosaur'];
  @override
  String generateRandom() {
    return _strings[_random.nextInt(_strings.length)];
  }
}

/// A default [Generator] to produce random booleans
class BooleanGenerator extends Generator<bool> {
  final _random = Random();
  @override
  bool generateRandom() {
    return _random.nextBool();
  }
}
