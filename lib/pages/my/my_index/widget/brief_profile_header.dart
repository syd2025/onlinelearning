import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class BriefProfileHeader extends StatelessWidget {
  BriefProfileHeader({super.key});

  final controller = Get.find<MyIndexController>();

  Widget _buildUserAvatar() {
    return SizedBox(
      height: 60,
      width: 60,
      child: ClipOval(
        child: AccountAvatarWidget(),
      ),
    );
  }

  Widget _buildLearnedDaysText(BuildContext context) {
    final isDarkMode = Get.isDarkMode;
    final normalColor = isDarkMode ? Colors.grey[300] : Colors.grey[700];
    final normalStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: normalColor,
        );
    final boldStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w600,
        );
    final span1 = TextSpan(text: LocaleKeys.learnedDays.tr, style: normalStyle);
    final span3 = TextSpan(text: LocaleKeys.day.tr, style: normalStyle);
    final span2 =
        TextSpan(text: "${controller.getLearnedDays ?? 0}", style: boldStyle);
    return RichText(
      text: TextSpan(
        children: [span1, span2, span3],
      ),
    );
  }

  Widget _buildLearnedMinsText(BuildContext context) {
    final isDarkMode = Get.isDarkMode;
    final normalColor = isDarkMode ? Colors.grey[300] : Colors.grey[700];
    final normalStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: normalColor,
        );
    final boldStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w600,
        );
    final span1 =
        TextSpan(text: LocaleKeys.learningMinutes.tr, style: normalStyle);

    TextSpan span2, span3;
    if (controller.getLearnedMinutes! / 60 > 1) {
      span2 = TextSpan(
          text: "${controller.getLearnedMinutes! ~/ 60}", style: boldStyle);
      span3 = TextSpan(text: LocaleKeys.hour.tr, style: normalStyle);
    } else {
      span2 =
          TextSpan(text: "${controller.getLearnedMinutes!}", style: boldStyle);
      span3 = TextSpan(text: LocaleKeys.minute.tr, style: normalStyle);
    }
    return RichText(
      text: TextSpan(
        children: [span1, span2, span3],
      ),
    );
  }

  Widget _buildGenderImage(BuildContext context) {
    final icon = UserService.to.brief.gender == "m" ? Icons.male : Icons.female;
    return ClipOval(
      child: Container(
        width: 20,
        height: 20,
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.75),
        child: Center(
          child: IconWidget.icon(
            icon,
            size: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildUserTextInfo(BuildContext context) {
    return SizedBox(
      height: 60,
      child: <Widget>[
        <Widget>[
          Text(
            "${UserService.to.brief.name}",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 5),
          _buildGenderImage(context),
        ].toRow(
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        <Widget>[
          _buildLearnedDaysText(context),
          const SizedBox(width: 10),
          _buildLearnedMinsText(context),
        ].toRow(),
      ].toColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: <Widget>[
        _buildUserAvatar().marginOnly(right: 16),
        _buildUserTextInfo(context),
      ]
          .toRow(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
          )
          .padding(all: 10),
    );
  }
}
