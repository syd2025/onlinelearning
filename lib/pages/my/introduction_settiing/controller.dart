import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class IntroductionSettiingController extends GetxController {
  IntroductionSettiingController();

  late final TextEditingController textController;
  late final FocusNode focusNode;

  _initData() {
    update(["introduction_settiing"]);
  }

  void onTap() {}

  void okAction() {
    final newIntroduction = textController.text.trim();
    if (newIntroduction.isEmpty) {
      Loading.error(LocaleKeys.nicknameCannotBeEmpty.tr);
      return;
    }
    focusNode.unfocus();
    updateIntroduction(newIntroduction).then((value) {
      if (value) {
        Get.back(result: newIntroduction);
      }
    });
  }

  Future<bool> updateIntroduction(String description) async {
    if (description == Get.arguments["introduction"]) {
      return true;
    }

    try {
      Loading.show();
      final response = await UserApi.updateUserIntroduction(description);
      Loading.dismiss();
      if (response.code == 0 && response.result?.field == 'introduction') {
        Loading.success(LocaleKeys.updateSuccess);
        UserService.to.updateIntroduction(response.result?.value);
        return true;
      } else {
        Loading.error(response.message ?? LocaleKeys.updateFailed.tr);
        return false;
      }
    } catch (e) {
      Loading.dismiss();
      Loading.error("error in updateIntroduction $e.toString()");
      log('Error: $e');
      return false;
    }
  }

  @override
  void onInit() {
    super.onInit();

    textController = TextEditingController();
    textController.text = Get.arguments["introduction"] ?? "";
    focusNode = FocusNode();
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
