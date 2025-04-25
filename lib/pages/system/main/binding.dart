import 'package:get/get.dart';
import 'package:onlinelearning/pages/index.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeIndexController>(() => HomeIndexController());
    Get.lazyPut<CategoryIndexController>(() => CategoryIndexController());
    Get.lazyPut<StudyIndexController>(() => StudyIndexController());
    Get.lazyPut<MyIndexController>(() => MyIndexController());
    Get.lazyPut<MainController>(() => MainController());
  }
}
