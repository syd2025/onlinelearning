import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:onlinelearning/common/index.dart';

class Images {
  static final url = "${Constants.wpApiBaseUrl}/v1/user/avatar";
  // 清除单个文件的缓存
  static void clearSingleImageCache([String? imageUrl]) async {
    PaintingBinding.instance.imageCache
        .evict(CachedNetworkImageProvider(imageUrl ?? url));
    await DefaultCacheManager().removeFile(imageUrl ?? url);
  }

  //清除所有缓存
  static void clearAllImageCache([String? imageUrl]) async {
    PaintingBinding.instance.imageCache
        .evict(CachedNetworkImageProvider(imageUrl ?? url));
    await DefaultCacheManager().emptyCache();
  }
}
