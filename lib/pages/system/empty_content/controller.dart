import 'package:get/get.dart';

class EmptyContentController extends GetxController {
  EmptyContentController();

  _initData() {
    update(["empty_content"]);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
