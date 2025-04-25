import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

import 'index.dart';

class AccountCancellationPage extends GetView<AccountCancellationController> {
  const AccountCancellationPage({super.key});

  Widget _buildCancelHintTexts(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(LocaleKeys.cancelHint1.tr,
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 10),
                Text(LocaleKeys.cancelHint2.tr,
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 10),
                Text(LocaleKeys.cancelHint3.tr,
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 10),
                Text(LocaleKeys.cancelHint4.tr,
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 30),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(LocaleKeys.cancelHintFooter.tr,
                style: Theme.of(context).textTheme.bodySmall),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCancelButtonTip(BuildContext context) {
    final textSpans = <TextSpan>[
      TextSpan(
          text: LocaleKeys.cancelButtonTip.tr,
          style: Theme.of(context).textTheme.titleSmall),
      TextSpan(
        text: LocaleKeys.cancelPrivacyPolicy.tr,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: Theme.of(context).colorScheme.primary),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            final background = Theme.of(context).scaffoldBackgroundColor;
            final bg = background.toHex();
            final fg =
                Theme.of(context).textTheme.titleMedium?.color?.toHex() ??
                    background.inverse.toHex();
            Get.to(() => WebViewPage(
                  backgroundColor: bg,
                  foregroundColor: fg,
                  title: LocaleKeys.userCancelPolicy.tr,
                  page: 'usercancellation',
                ));
          },
      ),
    ];

    return RichText(
      text: TextSpan(children: textSpans),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildMainButtonRow(BuildContext context) {
    return Container(
      height: 44,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: controller.mainButtonPressed,
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
        ),
        child: Text(
          LocaleKeys.agreeCancel.tr,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    final account =
        UserService.to.profile.phoneNumber ?? UserService.to.profile.email;
    return <Widget>[
      const SizedBox(height: 10),
      <Widget>[
        Spacer(),
        Icon(Icons.error, size: 70, color: Colors.grey),
        Spacer(),
      ].toRow(),
      if (account != null) const SizedBox(height: 10),
      if (account != null)
        Text(
          '${LocaleKeys.will.tr} $account ${LocaleKeys.cancelTailTip.tr}',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      const SizedBox(height: 10),
      TextWidget(
        text: LocaleKeys.cancelHintHeader.tr,
        textStyle: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: Colors.grey),
      ).paddingHorizontal(10),
      const SizedBox(height: 20),
      _buildCancelHintTexts(context),
      const SizedBox(height: 10),
      _buildCancelButtonTip(context),
      const SizedBox(height: 20),
      _buildMainButtonRow(context),
    ].toColumn();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountCancellationController>(
      init: AccountCancellationController(),
      id: "account_cancellation",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text(LocaleKeys.accountDeletion.tr)),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
