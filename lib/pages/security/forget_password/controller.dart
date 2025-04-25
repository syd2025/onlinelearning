import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class ForgetPasswordController extends GetxController {
  ForgetPasswordController();

  late final textController = TextEditingController();
  late final focusNode = FocusNode();

  final String prevRoute = Get.arguments?['prev_route'];

  late final _emailRegex =
      RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  late final _phoneRegex = RegExp(r'^1[3-9]\d{9}$');

  bool get canSubmit {
    final account = textController.text;
    return _emailRegex.hasMatch(account) || _phoneRegex.hasMatch(account);
  }

  _initData() {
    update(["forget_password"]);
  }

  // 主按钮
  void mainButtonPressed() {
    submit().then((value) {
      if (value) {
        Get.toNamed(RouteNames.systemPin, arguments: {
          'submit_type': ActionType.kResetPassword,
          'hold_value': textController.text,
          'prev_route': prevRoute,
        });
      }
    });
  }

  Future<bool> submit() async {
    final account = textController.text;
    final String type;
    if (_emailRegex.hasMatch(account)) {
      type = 'email';
    } else if (_phoneRegex.hasMatch(account)) {
      type = 'phone_number';
    } else {
      return false;
    }
    focusNode.unfocus();
    try {
      Loading.show();
      final response = await UserApi.changeUserPassword(type, account);
      Loading.dismiss();
      if (response.code == 0 && response.status != null) {
        final tipMessage = type == 'email'
            ? LocaleKeys.emailVerifyCodeSended.tr
            : LocaleKeys.phoneNumberVerifyCodeSended.tr;
        Loading.success(tipMessage);
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

  @override
  void onInit() {
    super.onInit();
    textController.addListener(() {
      update(["forget_password"]);
    });
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
