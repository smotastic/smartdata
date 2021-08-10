// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// SmartdataGenerator
// **************************************************************************

import 'package:smartdata/smartdata.dart';
import 'package:smartdata_example/simple.dart';

class SimpleGenerator extends Generator {
  @override
  Simple generateRandom() {
    final simple = Simple(
        Smartdata.I.getSingle<int>(),
        Smartdata.I.getSingle<String>(),
        Smartdata.I.getSingle<num>(),
        Smartdata.I.getSingle<SimpleNested>(),
        Smartdata.I.getSingle<double>(),
        Smartdata.I.get<num>(10));
    simple.number = Smartdata.I.getSingle<int>();
    return simple;
  }
}

class SimpleNestedGenerator extends Generator {
  @override
  SimpleNested generateRandom() {
    final simplenested = SimpleNested(Smartdata.I.getSingle<int>());
    return simplenested;
  }
}

$init() {
  Smartdata.put(Simple, SimpleGenerator());
  Smartdata.put(SimpleNested, SimpleNestedGenerator());
}
