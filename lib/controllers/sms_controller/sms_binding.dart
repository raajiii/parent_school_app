import 'package:get/get.dart';
import 'package:raji_parent_school_app/controllers/sms_controller/sms_all_controller.dart';

class SmsBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => SmsController());
  }
}