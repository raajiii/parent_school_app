import 'package:get/get.dart';
import 'package:raji_parent_school_app/controllers/profile_controller/profile_controller.dart';

class ProfileBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController(),fenix: true);
  }

}