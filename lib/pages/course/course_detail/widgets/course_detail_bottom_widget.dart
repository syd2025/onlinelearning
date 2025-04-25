import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class CourseDetailBottomWidget extends StatelessWidget {
  CourseDetailBottomWidget(
      {super.key,
      required this.purchaseButtonKey,
      required this.startAnimation});

  final GlobalKey purchaseButtonKey;
  final Function startAnimation;

  final controller = Get.find<CourseDetailController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseDetailController>(
      init: controller,
      id: "course_detail_bottom",
      builder: (_) {
        final purchaseTextColor = AppTheme.inverseTextColor;
        final purchaseTextStyle = context.textTheme.titleSmall;
        if (controller.isContentEmpty || controller.isMyCourse) {
          return const SizedBox.shrink();
        }
        return BottomAppBar(
          height: 50.h,
          padding: EdgeInsets.zero,
          child: <Widget>[
            if (!controller.isPruchased)
              InkWell(
                onTap: () {},
                child: SizedBox(
                  width: 50.w,
                  child: <Widget>[
                    const Spacer(),
                    const Icon(Icons.play_circle_outline, size: 20),
                    SizedBox(height: 2.h),
                    Text(
                      LocaleKeys.freeWatch.tr,
                      style:
                          context.textTheme.bodySmall?.copyWith(fontSize: 10),
                    ),
                  ].toColumn(),
                ),
              ),
            SizedBox(width: controller.isContentEmpty ? 16.w : 10.w),
            if (!controller.isPruchased)
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 7.h),
                  decoration: BoxDecoration(
                    color: AppTheme.commonTipColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: GestureDetector(
                      key: purchaseButtonKey,
                      onTap: () {
                        if (!UserService.to.isLogin) {
                          Get.toNamed(RouteNames.systemLogin);
                          return;
                        }
                        controller.addToShoppingCarts().then((value) {
                          if (value) {
                            startAnimation(); // 开始动画
                          }
                        });
                      },
                      child: TextWidget.body(
                        LocaleKeys.putToCart.tr,
                        textStyle: purchaseTextStyle,
                        color: purchaseTextColor,
                        weight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: context.theme.colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 7.h),
                  ),
                  child: TextWidget.body(
                    LocaleKeys.goToLearn.tr,
                    textStyle: purchaseTextStyle,
                    color: purchaseTextColor,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
            if (!controller.isPruchased)
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 7.h),
                  decoration: BoxDecoration(
                    color: AppTheme.purchaseTipColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        if (!UserService.to.isLogin) {
                          Get.toNamed(RouteNames.systemLogin);
                          return;
                        }
                        final price = controller.courseDetail?.price;
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(LocaleKeys.confrimPurchase.tr),
                            content: Text('${LocaleKeys.coursePrice.tr}$price'),
                            actions: [
                              ButtonWidget.primary(
                                LocaleKeys.commonBottomCancel.tr,
                                onTap: () => Get.back(result: false),
                              ),
                              ButtonWidget.primary(
                                LocaleKeys.commonBottomConfirm.tr,
                                onTap: () => Get.back(result: true),
                              ),
                            ],
                          ),
                        );
                        if (confirm == true) {
                          controller.purchase();
                        }
                      },
                      child: TextWidget.body(
                        LocaleKeys.buyNow.tr,
                        textStyle: purchaseTextStyle,
                        color: purchaseTextColor,
                        weight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(width: 16.w),
          ].toRow(),
        );
      },
    );
  }
}
