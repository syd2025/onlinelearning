import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

import 'index.dart';

class SecurityIndexPage extends GetView<SecurityIndexController> {
  const SecurityIndexPage({super.key});

  Widget _buildMainListView(BuildContext context) {
    return Container(
      // 背景颜色与主题相同，避免与底部导航条颜色相同，导致显示不清晰
      color: Theme.of(context).colorScheme.surface,
      child: Obx(
        () => ListView(
          children: [
            const SizedBox(height: 15),
            InfoTextWidget(
              title: LocaleKeys.phone.tr,
              info: controller.phoneNumber,
              onTap: controller.jumpToCredentialPhone,
            ),
            InfoTextWidget(
              title: LocaleKeys.email.tr,
              info: controller.email,
              onTap: controller.jumpToCredentialEmail,
            ),
            InfoTextWidget(
              title: LocaleKeys.thirdAccount.tr,
              info: controller.thirdAccount,
              onTap: controller.jumpToThirdAuthAccount,
            ),
            InfoTextWidget(
              title: LocaleKeys.passwordSetting.tr,
              info: controller.password,
              onTap: controller.jumpToPasswordSetting,
            ),
            InfoTextWidget(
              title: LocaleKeys.identityVerification.tr,
              info: controller.identityVerification,
              onTap: controller.jumpToIdentityVerification,
            ),
            InfoTextWidget(
              title: LocaleKeys.accountDeletion.tr,
              info: controller.accountCancellation,
              onTap: controller.jumpToAccountCancellation,
            ),
          ],
        ),
      ),
    );
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(scrollbars: false),
      child: _buildMainListView(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SecurityIndexController>(
      init: SecurityIndexController(),
      id: "security_index",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text(LocaleKeys.accountSecurity.tr)),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
