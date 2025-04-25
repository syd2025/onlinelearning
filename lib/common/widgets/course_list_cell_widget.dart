import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class CourseListCellWidget extends StatelessWidget {
  final CourseBriefModel course;
  final String? searchKey;
  final GestureTapCallback? onTap;
  final String? trailingText;

  const CourseListCellWidget({
    super.key,
    required this.course,
    this.searchKey,
    this.onTap,
    this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildThumbnailWidget(context),
            const SizedBox(width: 16),
            _buildTextInfoWidget(context),
          ],
        ),
      ),
    );
  }

  /// 构建缩略图部分
  Widget _buildThumbnailWidget(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: course.imageUrl,
        width: 90,
        height: 120,
        errorWidget: (context, url, error) => const Icon(
          Icons.error,
          color: Colors.red,
        ),
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            const CupertinoActivityIndicator(radius: 15),
      ),
    );
  }

  /// 构建文本信息部分
  Widget _buildTextInfoWidget(BuildContext context) {
    final majorTitleStyle =
        context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold);
    final minorTitleStyle =
        context.textTheme.titleSmall?.copyWith(color: Colors.grey[500]);
    return Expanded(
      child: SizedBox(
        height: 115,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMajorTitle(context, majorTitleStyle),
                const SizedBox(height: 4),
                _buildMinorTitleRow(context, minorTitleStyle),
              ],
            ),
            const Spacer(),
            _buildBottomRow(context, minorTitleStyle),
          ],
        ),
      ),
    );
  }

  /// 构建主要标题行
  Widget _buildMajorTitle(BuildContext context, TextStyle? majorTitleStyle) {
    if (searchKey == null) {
      return Text(
        course.title,
        style: majorTitleStyle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
    } else {
      final textSpans = <TextSpan>[];
      final matchedStyle =
          majorTitleStyle?.copyWith(color: context.theme.colorScheme.primary);
      course.title
          .splitMapJoin(RegExp(RegExp.escape(searchKey!), caseSensitive: false),
              onMatch: (m) {
        textSpans.add(TextSpan(text: m.group(0), style: matchedStyle));
        return m.group(0)!;
      }, onNonMatch: (n) {
        textSpans.add(TextSpan(text: n, style: majorTitleStyle));
        return n;
      });
      return RichText(
        text: TextSpan(children: textSpans),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
    }
  }

  /// 构建次要标题行
  Widget _buildMinorTitleRow(BuildContext context, TextStyle? minorTitleStyle) {
    return Row(
      children: [
        TextWidget.body(
          course.author,
          textStyle: minorTitleStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(width: 16),
        TextWidget.body(
          course.levelTitle,
          textStyle: minorTitleStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildBottomRow(BuildContext context, TextStyle? minorTitleStyle) {
    final primaryColor = context.theme.colorScheme.primary;
    final priceStyle = context.textTheme.titleMedium?.copyWith(
      color: primaryColor,
      fontWeight: FontWeight.bold,
    );
    Widget trailing;
    if (trailingText != null) {
      trailing = TextWidget.body(
        trailingText!,
        textStyle: minorTitleStyle,
      );
    } else if (UserService.to.purchasedCourses.contains(course.id)) {
      trailing = TextWidget.body(
        LocaleKeys.studying.tr,
        textStyle: minorTitleStyle?.copyWith(color: primaryColor),
      );
    } else if (course.authorId == UserService.to.accountId) {
      trailing = TextWidget.body(
        LocaleKeys.myCourses.tr,
        textStyle: minorTitleStyle?.copyWith(color: primaryColor),
      );
    } else {
      trailing = TextWidget.body(
        '${course.studentCount} ${LocaleKeys.studyingCountTip.tr}',
        textStyle: minorTitleStyle,
      );
    }

    return Row(
      children: [
        Text(
          '¥ ${course.price}',
          style: priceStyle,
        ),
        const Spacer(),
        trailing,
      ],
    );
  }
}
