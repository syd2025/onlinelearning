import 'package:get/get.dart';

class IdentitySettingController extends GetxController {
  IdentitySettingController();

  _initData() {
    update(["identity_setting"]);
  }

  void mainButtonPressed() {}

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
