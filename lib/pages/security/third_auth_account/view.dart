import 'dart:io';

import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/common/values/icons.dart';

import 'index.dart';

class ThirdAuthAccountPage extends GetView<ThirdAuthAccountController> {
  const ThirdAuthAccountPage({super.key});

  // 主视图
  Widget _buildView() {
    return <Widget>[
      const SizedBox(height: 20),
      ThirdAuthWidget(icon: AssetsIcons.wechart, title: LocaleKeys.wechart),
      const SizedBox(height: 20),
      ThirdAuthWidget(icon: AssetsIcons.qq, title: LocaleKeys.qq),
      const SizedBox(height: 20),
      ThirdAuthWidget(icon: AssetsIcons.weibo, title: LocaleKeys.weibo),
      if (Platform.isIOS || Platform.isMacOS) const SizedBox(height: 20),
      if (Platform.isIOS || Platform.isMacOS)
        ThirdAuthWidget(icon: AssetsIcons.wechart, title: LocaleKeys.wechart),
    ].toColumn();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThirdAuthAccountController>(
      init: ThirdAuthAccountController(),
      id: "third_auth_account",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text(LocaleKeys.thirdAuthAccount.tr)),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
