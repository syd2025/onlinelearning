import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class EmptyContentWidget extends StatelessWidget {
  final bool loading;
  final bool error;
  final Function? reloadAction;
  final String? buttonTitle;
  final Function? otherAction;
  const EmptyContentWidget({
    super.key,
    required this.loading,
    required this.error,
    this.reloadAction,
    this.buttonTitle,
    this.otherAction,
  });

  @override
  Widget build(BuildContext context) {
    String imagePath;
    if (loading) {
      imagePath = AssetsImages.loading;
    } else if (error) {
      imagePath = AssetsImages.loadingFailed;
    } else {
      imagePath = AssetsImages.noContent;
    }

    return Center(
      child: Column(
        children: [
          const Spacer(),
          Stack(
            children: [
              ImageWidget.img(
                imagePath,
                fit: BoxFit.cover,
              ),
              if (loading == false && error == true)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (reloadAction != null) {
                        reloadAction!();
                      }
                    },
                    child: TextWidget.body(LocaleKeys.reload.tr),
                  ),
                ),
              if (loading == false && error == false && buttonTitle != null)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (otherAction != null) {
                        otherAction!();
                      }
                    },
                    child: TextWidget.body(
                      buttonTitle!,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
