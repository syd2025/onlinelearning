import 'package:get/get.dart';

class ThirdAuthAccountController extends GetxController {
  ThirdAuthAccountController();

  _initData() {
    update(["third_auth_account"]);
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
