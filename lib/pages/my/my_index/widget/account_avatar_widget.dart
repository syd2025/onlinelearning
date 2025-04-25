import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class AccountAvatarWidget extends StatelessWidget {
  AccountAvatarWidget({super.key});

  final controller = Get.find<MyIndexController>();

  @override
  Widget build(BuildContext context) {
    final avatar = UserService.to.brief.avatar;
    final token = UserService.to.token;
    if (avatar == null || token.isEmpty) {
      return ImageWidget.img(AssetsImages.avatarPlaceholder);
    }
    return CachedNetworkImage(
      key: ValueKey(UserService.to.index),
      imageUrl: "${Constants.wpApiBaseUrl}/v1/user/avatar",
      httpHeaders: {"Authorization": "Bearer ${UserService.to.token}"},
      placeholder: (context, url) => ColorFiltered(
        colorFilter: ColorFilter.mode(AppTheme.primary, BlendMode.modulate),
        child: ImageWidget.img(AssetsImages.avatarPlaceholder),
      ),
      fit: BoxFit.cover,
      errorWidget: (context, url, error) =>
          ImageWidget.img(AssetsImages.avatarPlaceholder),
      errorListener: (e) {},
    );
  }
}
