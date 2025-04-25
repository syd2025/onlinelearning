import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class CourseDetailAppbarWidget extends StatefulWidget
    implements PreferredSizeWidget {
  final GlobalKey shoppingCartButtonKey;

  CourseDetailAppbarWidget({required this.shoppingCartButtonKey})
      : super(
          key: GlobalKey<_CourseDetailAppbarWidgetState>(),
        );

  @override
  _CourseDetailAppbarWidgetState createState() =>
      _CourseDetailAppbarWidgetState();

  @override
  Size get preferredSize {
    final state =
        (key as GlobalKey<_CourseDetailAppbarWidgetState>).currentState;
    return state?.preferredSize ??
        const Size.fromHeight(kMinInteractiveDimensionCupertino);
  }
}

class _CourseDetailAppbarWidgetState extends State<CourseDetailAppbarWidget> {
  CupertinoNavigationBar? _bar;
  final controller = Get.find<CourseDetailController>();

  Size? get preferredSize {
    return _bar?.preferredSize;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseDetailController>(
      id: "course_detail_appbar",
      builder: (_) {
        return Builder(builder: (context) {
          final maxWith =
              MediaQuery.of(context).size.width - 36.w * 4 - 10.w * 2 - 5.w;
          _bar = CupertinoNavigationBar(
            backgroundColor: context.theme.colorScheme.surface,
            border: const Border(bottom: BorderSide(color: Colors.transparent)),
            padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
            leading: <Widget>[
              SizedBox(
                width: 36.w,
                height: 36.h,
                child: ButtonWidget.icon(
                  const Icon(Icons.arrow_back_ios_new_sharp, size: 22),
                  onTap: () => Get.back(),
                ).paddingZero,
              ),
              if (controller.showTitle && controller.courseTitle != null)
                SizedBox(
                  width: maxWith,
                  child: TextWidget.body(
                    controller.courseTitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textStyle: context.textTheme.titleMedium,
                    weight: FontWeight.bold,
                  ),
                )
              else
                const SizedBox.shrink(),
            ].toRow(),
            trailing: controller.isContentEmpty
                ? const SizedBox.shrink()
                : <Widget>[
                    const Spacer(),
                    SizedBox(
                      width: 36.w,
                      height: 36.h,
                      child: ButtonWidget.icon(
                        controller.isMyFavorite
                            ? Icon(Icons.favorite,
                                size: 22,
                                color: context.theme.colorScheme.primary)
                            : const Icon(Icons.favorite_outline, size: 22),
                        onTap: controller.clickMyFavorite,
                      ).paddingZero,
                    ),
                    SizedBox(width: 5.w),
                    SizedBox(
                      width: 36.w,
                      height: 36.h,
                      child: ShoppingCartButtonWidget(
                        key: widget.shoppingCartButtonKey,
                      ),
                    ),
                    SizedBox(
                      width: 36.w,
                      height: 36.h,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.share, size: 22),
                      ),
                    ),
                  ].toRow(),
          );
          return _bar!;
        });
      },
    );
  }
}
