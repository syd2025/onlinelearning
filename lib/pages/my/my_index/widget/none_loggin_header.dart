import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class NoneLogginHeader extends StatelessWidget {
  NoneLogginHeader({super.key});

  final controller = Get.find<MyIndexController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      child: <Widget>[
        // 圆形图标
        CircleAvatar(
          radius: AppRadius.avatar,
          backgroundColor: context.theme.colorScheme.surface,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.grey[600]!, BlendMode.srcIn),
            child: IconWidget.img(AssetsImages.avatarPlaceholder),
          ),
        ).clipRRect(all: AppRadius.avatar),
        SizedBox(width: 16.w),
        // click to login
        SizedBox(
          height: 50.h,
          child: <Widget>[
            GestureDetector(
              onTap: () => Get.toNamed(
                  RouteNames.systemLogin), // 点击跳转至登录页面的逻辑，可以根据需要修改为实际的跳转逻辑。
              child: TextWidget.body(LocaleKeys.clickLogin.tr,
                  textStyle: context.textTheme.headlineSmall),
            ),
            SizedBox(height: 5.h),
            TextWidget.body(LocaleKeys.welcomeLogin.tr,
                textStyle: context.textTheme.bodyMedium, color: Colors.grey),
          ].toColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ].toRow(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}
