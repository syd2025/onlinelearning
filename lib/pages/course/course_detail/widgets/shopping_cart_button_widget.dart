import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class ShoppingCartButtonWidget extends StatelessWidget {
  const ShoppingCartButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 36.w,
          height: 36.h,
          child: ButtonWidget.icon(
            const Icon(Icons.shopping_cart_outlined, size: 22),
            onTap: () {},
          ).paddingZero,
        ),
        Obx(() {
          int courseCount = UserService.to.purchasingCourses.length;
          if (courseCount > 0) {
            return Positioned(
              right: 0,
              child: Container(
                padding: EdgeInsets.all(1.w),
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                constraints: BoxConstraints(
                  minWidth: 16.w,
                  minHeight: 16.h,
                ),
                child: Center(
                  child: TextWidget.body(
                    courseCount > 99 ? '99+' : '$courseCount',
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        })
      ],
    );
  }
}
