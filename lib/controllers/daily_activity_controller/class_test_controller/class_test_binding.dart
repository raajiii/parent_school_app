import 'package:get/get.dart';

import 'class_test_controller.dart';

class ClassTestBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ClassTestController());
  }

}