import 'package:get/get.dart';
import 'package:raji_parent_school_app/controllers/library_controller/renew_controller.dart';


class RenewBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => RenewController());
  }

}