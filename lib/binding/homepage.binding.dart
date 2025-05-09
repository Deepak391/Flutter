import 'package:get/get.dart';
import 'package:notereader/controller/homepage.controller.dart';

class DeatilsPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomepageController>(HomepageController());
  }
}
