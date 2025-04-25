import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

import 'index.dart';

class IntroductionSettiingPage extends GetView<IntroductionSettiingController> {
  const IntroductionSettiingPage({super.key});

  // 主视图
  Widget _buildView() {
    final longIntroduction =
        UserService.to.brief.isTeacher ?? UserService.to.brief.isAdmin ?? false;
    return Column(
      children: [
        const SizedBox(height: 15),
        TextField(
          decoration: InputDecoration(
            labelText: LocaleKeys.introduction.tr,
            hintText: LocaleKeys.signatureHint.tr,
            contentPadding: EdgeInsets.symmetric(horizontal: 15),
          ),
          controller: controller.textController,
          focusNode: controller.focusNode,
          autofocus: true,
          maxLength: longIntroduction ? 1500 : 90,
          maxLines: longIntroduction ? 20 : 6,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final fontSize =
        (Theme.of(context).appBarTheme.titleTextStyle?.fontSize ?? 20) - 2;
    return GetBuilder<IntroductionSettiingController>(
      init: IntroductionSettiingController(),
      id: "introduction_settiing",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.updateIntroduction.tr),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                    textStyle: TextStyle(fontSize: fontSize)),
                onPressed: controller.okAction,
                child: Text(LocaleKeys.ok.tr),
              ),
            ],
          ),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
