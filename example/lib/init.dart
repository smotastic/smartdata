import 'package:smartdata/smartdata.dart';
import 'package:smartdata_example/simple.dart';
import 'package:smartdata_example/init.smart.dart';

@SmartdataInit(classesToGenerate: [Simple])
void init() {
  $init();
}
