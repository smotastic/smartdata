import 'dart:math';

import 'package:smartdata/src/generator.dart';

class NumGenerator extends Generator<num> {
  final _random = Random();
  final _nums = <num>[1, 2, 3, 4];
  @override
  num generateRandom() {
    return _nums[_random.nextInt(_nums.length)];
  }
}

class StringGenerator extends Generator<String> {
  final _random = Random();
  final _strings = ['bulbasaur', 'ivysaur', 'venosaur'];
  @override
  String generateRandom() {
    return _strings[_random.nextInt(_strings.length)];
  }
}
