import 'package:smartdata/smartdata.dart';
import 'package:smartdata_example/simple.dart';

import 'simple_test.smart.dart';
import 'package:test/test.dart';

@SmartdataInit(classesToGenerate: [Simple, SimpleNested])
void init() {
  $init();
}

void main() {
  setUp(init);
  test('should create lots of random data', () {
    final testData = Smartdata.I.get<Simple>(50);
    expect(testData.length, 50);
  });
}
