import 'package:get/get.dart';

import 'circular_event_news_controller.dart';


class NewsCircularEventBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => NewsCircularEventController());
  }
}