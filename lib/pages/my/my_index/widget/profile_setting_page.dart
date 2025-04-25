import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class ProfileSettingPage extends StatelessWidget {
  ProfileSettingPage({super.key});

  final controller = Get.find<MyIndexController>();

  Widget _buildInfoTextCell({
    required BuildContext context,
    required String title,
    required GestureTapCallback? onTap,
    required String data,
  }) {
    return Container(
      height: 60,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: <Widget>[
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(width: 10),
        Expanded(
          child: TextWidget(
            text: data,
            onTap: onTap,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            textStyle: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey),
          ),
        ),
        const SizedBox(width: 5),
        const IconWidget.icon(
          Icons.arrow_forward_ios,
          size: 15,
          color: Colors.grey,
        )
      ].toRow(),
    ).paddingHorizontal(20).inkWell(onTap: onTap);
  }

  Widget _buildAvatar(BuildContext context) {
    return Container(
      height: 60,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: <Widget>[
        Text(LocaleKeys.avatar.tr,
            style: Theme.of(context).textTheme.titleMedium),
        const Spacer(),
        ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Container(
            width: 44,
            height: 44,
            color: Theme.of(context).colorScheme.surface,
            child: AccountAvatarWidget(),
          ),
        ),
        const SizedBox(width: 5),
        const Icon(
          Icons.arrow_forward_ios,
          size: 15,
          color: Colors.grey,
        ),
      ].toRow(),
    ).paddingHorizontal(20).inkWell(
      onTap: () async {
        await controller.updateAvatar();
      },
    );
  }

  void selectGender(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return GenderSelector(
          gender: controller.gender,
          onGender: controller.updateGender,
        );
      },
    );
  }

  Widget _buildMainListView(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 15),
        _buildAvatar(context),
        _buildInfoTextCell(
          context: context,
          title: LocaleKeys.nickname.tr,
          onTap: () => controller.jumpToNicknameSettingPage(),
          data: UserService.to.brief.name ?? LocaleKeys.defaultStrings.tr,
        ),
        _buildInfoTextCell(
          context: context,
          title: LocaleKeys.profession.tr,
          onTap: () => controller.jumpToProfessionSettingPage(),
          data:
              UserService.to.profile.profession ?? LocaleKeys.defaultStrings.tr,
        ),
        _buildInfoTextCell(
          context: context,
          title: LocaleKeys.gender.tr,
          onTap: () => selectGender(context),
          data: UserService.to.profile.gender == "m"
              ? LocaleKeys.male.tr
              : LocaleKeys.female.tr,
        ),
        // todo 用户区域选择
        _buildInfoTextCell(
          context: context,
          title: LocaleKeys.region.tr,
          onTap: () => controller.jumpToRegionSettingPage(),
          data: UserService.to.profile.region ?? LocaleKeys.defaultStrings.tr,
        ),
        _buildInfoTextCell(
          context: context,
          title: LocaleKeys.introduction.tr,
          onTap: () => controller.jumpToIntroductionSettingPage(),
          data: UserService.to.profile.introduction ??
              LocaleKeys.defaultStrings.tr,
        ),
        SizedBox(height: 15),
        _buildInfoTextCell(
          context: context,
          title: LocaleKeys.accountSecurity.tr,
          onTap: () => controller.jumpToAccountSecurityPage(),
          data: LocaleKeys.accountSecurityTip.tr,
        ),
      ],
    );
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    return _buildMainListView(context);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyIndexController>(
      init: MyIndexController(),
      id: "profile_setting",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.profileTitle.tr),
            leading: Icon(Icons.arrow_back_ios).onTap(() => Get.back()),
          ),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
