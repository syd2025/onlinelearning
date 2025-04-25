import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class PasswordSettingController extends GetxController {
  PasswordSettingController();

  late final passwordController0 = TextEditingController();
  late final passwordController1 = TextEditingController();
  late final passwordController2 = TextEditingController();
  late final focusNode0 = FocusNode();
  late final focusNode1 = FocusNode();
  late final focusNode2 = FocusNode();

  bool? password0Ready;
  bool? password1Ready;
  bool? password2Ready;

  bool _password0Used = false;
  bool _password1Used = false;
  bool _password2Used = false;

  bool get canSubmit =>
      password0Ready == true &&
      password1Ready == true &&
      password2Ready == true;

  _initData() {
    passwordController0.addListener(() {
      final text0 = passwordController0.text;
      if (text0.isNotEmpty) {
        _password0Used = true;
      }
      if (_password0Used) {
        password0Ready = text0.length >= 8;
      }
      update(["password_setting"]);
    });

    passwordController1.addListener(() {
      final text1 = passwordController1.text;
      if (text1.isNotEmpty) {
        _password1Used = true;
      }
      if (_password1Used) {
        password1Ready = text1.length >= 8;
      }
      if (_password2Used) {
        final text2 = passwordController2.text;
        password2Ready = text2.length >= 8 && text2 == text1;
      }
      update(["password_setting"]);
    });

    passwordController2.addListener(() {
      final text = passwordController2.text;
      if (text.isNotEmpty) {
        _password2Used = true;
      }
      if (_password2Used) {
        password2Ready = text.length >= 8 && text == passwordController1.text;
      }
      update(["password_setting"]);
    });
  }

  Future<bool> submit() async {
    focusNode0.unfocus();
    focusNode1.unfocus();
    focusNode2.unfocus();
    final old = passwordController0.text;
    final passwd = passwordController1.text;
    if (old == passwd) {
      Loading.error(LocaleKeys.newAndOldPasswordSame.tr);
      return false;
    }
    if (passwd != passwordController2.text) {
      return false;
    }

    try {
      Loading.show();
      final response = await UserApi.updateUserPassword(
        type: ActionType.kupdatePassword,
        password: passwd,
        code: old,
      );
      Loading.dismiss();
      if (response.code == 0) {
        Loading.success(LocaleKeys.updateSuccess.tr);
        return true;
      } else {
        Loading.error(response.message ?? LocaleKeys.unknownError.tr);
        return false;
      }
    } catch (e) {
      Loading.dismiss();
      Loading.error(e.toString());
      log('Error: $e');
      return false;
    }
  }

  void mainButtonPressed() {
    submit().then((value) {
      if (value) {
        Get.back();
      }
    });
  }

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
