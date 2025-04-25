import 'package:get/get.dart';

class AccountCancellationController extends GetxController {
  AccountCancellationController();

  _initData() {
    update(["account_cancellation"]);
  }

  mainButtonPressed() {}

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
