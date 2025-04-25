import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class NicknameSettingController extends GetxController {
  NicknameSettingController();

  late final TextEditingController textController;
  late final FocusNode focusNode;
  final RxInt _leftCount = 20.obs;

  int get leftCount => _leftCount.value;

  _initData() {
    update(["nickname_setting"]);
  }

  void onTap() {}

  @override
  void onInit() {
    super.onInit();
    textController = TextEditingController();
    // 页面默认显示的昵称
    textController.text = Get.arguments["nickname"] ?? "";
    focusNode = FocusNode();
    textController.addListener(() {
      _leftCount.value = 20 - textController.text.length;
    });
  }

  void okAction() {
    final newName = textController.text.trim();
    if (newName.isEmpty) {
      Loading.error(LocaleKeys.nicknameCannotBeEmpty.tr);
      return;
    }
    focusNode.unfocus();
    updateNickName(newName).then((value) {
      if (value) {
        Get.back(result: newName);
      }
    });
  }

  Future<bool> updateNickName(String newName) async {
    if (newName == Get.arguments["nickname"]) {
      return true;
    }

    try {
      Loading.show();
      final response = await UserApi.updateUserNickName(newName);
      if (response.code == 0 && response.result?.field == 'nickname') {
        Loading.success(LocaleKeys.updateSuccess.tr);
        UserService.to.updateNickname(response.result?.value);
        return true;
      } else {
        Loading.error(response.message ?? LocaleKeys.updateFailed.tr);
        return false;
      }
    } catch (e) {
      Loading.error("error in updateNickName: $e");
      return false;
    }
  }

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
