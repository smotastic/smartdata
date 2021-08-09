// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// SmartdataGenerator
// **************************************************************************

import 'package:smartdata/smartdata.dart';
import 'package:smartdata_example/simple.dart';

class SimpleGenerator extends Generator {
  @override
  Simple generateRandom() {
    final simple = Simple(randomInt, randomString);
    return simple;
  }
}

$init() {
  Smartdata.put(Simple, SimpleGenerator());
}
