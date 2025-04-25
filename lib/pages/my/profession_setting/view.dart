import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

import 'index.dart';

class ProfessionSettingPage extends GetView<ProfessionSettingController> {
  const ProfessionSettingPage({super.key});

  Widget _buildProfessionList(BuildContext context) {
    final professions = controller.professions ?? [];
    final Color dividerColor;
    if (Theme.of(context).brightness == Brightness.light) {
      dividerColor = Colors.grey[200]!;
    } else {
      dividerColor = Colors.grey[800]!;
    }

    return ListView.separated(
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Divider(
          color: dividerColor,
          height: 0.25,
        ),
      ),
      itemCount: professions.length,
      itemBuilder: (context, index) {
        final profession = professions[index];
        return ListTile(
          title: Text(profession.title!),
          trailing: controller.currentProfessionName == profession.title
              ? Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.primary,
                )
              : null,
          onTap: () {
            controller.selectProfession(index);
          },
        );
      },
    );
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    final professions = controller.professions;
    if (professions == null) {
      return Center(
        child: Text("No Content"),
      );
    } else {
      return _buildProfessionList(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fontSize =
        (Theme.of(context).appBarTheme.titleTextStyle?.fontSize ?? 20) - 2;
    return GetBuilder<ProfessionSettingController>(
      init: ProfessionSettingController(),
      id: "profession_setting",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.updateProfession.tr),
            actions: [
              TextButton(
                onPressed: controller.currentProfessionName != null
                    ? controller.okAction
                    : null,
                child: Text(
                  LocaleKeys.ok,
                  style: TextStyle(fontSize: fontSize),
                ),
              )
            ],
          ),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
