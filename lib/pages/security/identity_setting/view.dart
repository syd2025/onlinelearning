import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

import 'index.dart';

class IdentitySettingPage extends GetView<IdentitySettingController> {
  const IdentitySettingPage({super.key});

  Widget _buildIDVerifyNoteTexts(BuildContext context) {
    const color = Colors.grey;
    final style = Theme.of(context).textTheme.bodySmall?.copyWith(color: color);
    final lines = LocaleKeys.identityVerificationTip.tr.split('\n');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map(
        (e) {
          return Column(
            children: [
              Text(e, style: style),
              const SizedBox(height: 10),
            ],
          );
        },
      ).toList(),
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
          LocaleKeys.verify.tr,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    const color = Colors.grey;
    return <Widget>[
      const SizedBox(height: 20),
      <Widget>[
        const Spacer(),
        const Icon(Icons.error, color: color, size: 24),
        const SizedBox(width: 10),
        Text(
          LocaleKeys.notVerified.tr,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: color),
        ),
        const Spacer(),
      ].toRow(),
      const SizedBox(height: 30),
      Text(
        LocaleKeys.identityVerificationTipTitle.tr,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(height: 5),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildIDVerifyNoteTexts(context),
      ),
      const SizedBox(height: 30),
      _buildMainButtonRow(context),
    ]
        .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
        .paddingHorizontal(10);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IdentitySettingController>(
      init: IdentitySettingController(),
      id: "identity_setting",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text(LocaleKeys.identityVerification.tr)),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
