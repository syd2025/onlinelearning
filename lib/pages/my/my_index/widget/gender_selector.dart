import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class GenderSelector extends StatelessWidget {
  GenderSelector({super.key, this.gender, required this.onGender});

  final String? gender;
  final Function(String) onGender;

  final controller = Get.put(MyIndexController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: <Widget>[
        const SizedBox(height: 20),
        ListTile(
          leading: const Icon(Icons.male, size: 22),
          title: Text(LocaleKeys.male.tr),
          trailing: controller.gender == 'm'
              ? const Icon(Icons.check, size: 22)
              : null,
          onTap: () {
            controller.setGender('m');
            Get.back();
            onGender('m');
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Divider(height: 0.25),
        ),
        ListTile(
          leading: const Icon(Icons.female, size: 22),
          title: Text(LocaleKeys.female.tr),
          trailing: gender == 'f' ? const Icon(Icons.check, size: 22) : null,
          onTap: () {
            controller.setGender('f');
            Get.back();
            onGender('f');
          },
        ),
      ].toColumn(
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}
