import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

import 'index.dart';

class MyIndexPage extends GetView<MyIndexController> {
  const MyIndexPage({super.key});

  // 主视图
  Widget _buildView(BuildContext context) {
    final style = context.textTheme.titleLarge!
        .copyWith(fontWeight: FontWeight.w600, fontSize: 16);
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(scrollbars: false),
      child: ListView(
        children: [
          SizedBox(height: AppSpace.page),
          // 根据登录状态显示
          GetBuilder<MyIndexController>(
            id: "avatar",
            init: controller,
            builder: (controller) {
              return UserService.to.isLogin
                  ? BriefProfileHeader()
                  : NoneLogginHeader();
            },
          ),
          SizedBox(height: AppSpace.page),
          _buildFirstSection(style),
          SizedBox(height: AppSpace.page),
          _buildSecondSection(style),
          SizedBox(height: AppSpace.page),
          _buildExitRow(style),
          SizedBox(height: AppSpace.page),
          Footer(),
        ],
      ).paddingHorizontal(AppSpace.card),
    );
  }

  Widget _buildSecondSection(TextStyle style) {
    return Card(
      child: <Widget>[
        ListItem(
            icon: Icons.info,
            title: LocaleKeys.aboutLearning.tr,
            onTap: () {},
            style: style),
        DividerWidget.normal(),
        ListItem(
          icon: Icons.superscript_outlined,
          title: LocaleKeys.myOrder.tr,
          onTap: () {},
          style: style,
        ),
        DividerWidget.normal(),
        ListItem(
          icon: Icons.star_rate,
          title: LocaleKeys.ratingMe.tr,
          onTap: () {},
          style: style,
        ),
        DividerWidget.normal(),
        ListItem(
          icon: Icons.edit,
          title: LocaleKeys.editProfile.tr,
          onTap: () => controller.jumpToProfileSettingPage(),
          style: style,
        ),
      ].toColumn(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
      ),
    );
  }

  Widget _buildFirstSection(TextStyle style) {
    return Card(
      child: <Widget>[
        ListItem(
            icon: Icons.shopping_cart_outlined,
            title: LocaleKeys.shoppingCart.tr,
            onTap: () {},
            style: style),
        DividerWidget.normal(),
        ListItem(
          icon: Icons.assessment,
          title: LocaleKeys.myOrder.tr,
          onTap: () {},
          style: style,
        ),
        DividerWidget.normal(),
        ListItem(
          icon: Icons.favorite,
          title: LocaleKeys.favoriteCourse.tr,
          onTap: () {},
          style: style,
        ),
      ].toColumn(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
      ),
    );
  }

  Widget _buildExitRow(TextStyle style) {
    return GetBuilder<MyIndexController>(
      id: "btn_exit",
      init: controller,
      builder: (_) => UserService.to.isLogin
          ? <Widget>[
              Card(
                child: ListItem(
                    icon: Icons.exit_to_app,
                    title: LocaleKeys.logout.tr,
                    onTap: () => controller.logout(),
                    style: style),
              ),
            ].toColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
            )
          : SizedBox.shrink(), // 表示未登录状态
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyIndexController>(
      init: MyIndexController(),
      id: "my_index",
      builder: (_) {
        return Scaffold(
          // appBar: AppBar(title: Text(LocaleKeys.tabBarProfile.tr)),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
