import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class StudyCourseController extends GetxController {
  StudyCourseController();

  // 课程ID
  late final int courseId;
  // 课程详情
  CourseDetailModel? courseDetail;
  bool loading = false;
  bool error = false;
  bool get isContentEmpty => courseDetail == null;

  // 课程评论
  int? _lastReviewPage;
  int _reviewPage = 1;
  int _reviewPageSize = 20;
  bool reviewLoding = false;
  bool reviewError = false;
  CancelToken? _reviewCancelToken;
  List<CourseReviewModel>? reviews;

  // 是否加载我的评论
  bool _fetchMyReview = true;
  // 我的评论
  CourseReviewModel? myReview;
  // 当前视频ID
  int get currentVideoId => videoId.value;
  // 课程评论是否为空
  bool get isReviewEmpty =>
      (reviews == null || reviews!.isEmpty) && myReview == null;

  // 课程评论数量
  int get reviewCount => reviews?.length ?? 0;
  // 收藏
  bool _favoriteChanging = false;
  // 收藏
  bool get isMyFavorite => courseDetail?.isFavorite ?? false;
  // 分页
  List<CourseTableContentUnitModel> categoryUnits = [];
  // 当前选中的tab的索引
  int currentTabIndex = 0;
  // 是否已经加载过数据
  bool isDataRead = false;
  // 是否手动改变位置
  bool manualPostionChaning = false;
  // 是否正在播放
  bool isPlaying = false;
  // 播放进度
  final positionProgress = Duration.zero.obs;
  // 缓冲进度
  final bufferPositionProgress = Duration.zero.obs;
  // 视频ID
  final videoId = 0.obs;
  // 进度百分比值
  final progress = 0.0.obs;
  // 是否更新位置
  bool updatePostionWhenPlaying = true;
  // 初始化播放器
  late final player = Player(
    configuration: PlayerConfiguration(
      title: 'Course Media Play',
      ready: () {
        log('The initialization is complete.');
      },
    ),
  );
  // 初始化控制器
  late final videoController = VideoController(player);

  // 载入更多的评论
  bool get canLoadMoreReviews {
    if (_lastReviewPage != null) {
      return _reviewPage <= _lastReviewPage!;
    } else {
      return true;
    }
  }

  // 切换tab的索引
  void changeTabIndex(int index) {
    currentTabIndex = index;
    if (index == 2 && reviews == null) {
      loadReviews();
    }
    update(["study_course"]);
  }

  // 我的评论
  void assignMyReview(CourseReviewModel review) {
    myReview = review;
    update(["study_course_review"]);
  }

  // 加载课程评论
  void loadReviews() async {
    try {
      if (reviewLoding) {
        return;
      }

      Loading.show();

      reviewLoding = true;
      reviewError = false;
      update(["study_course_review"]);

      final response = await BusinessApi.getCourseReviews(
        courseId: courseId,
        fetchMyReview: _fetchMyReview,
        page: _reviewPage,
        pageSize: _reviewPageSize,
        cancelToken: _reviewCancelToken,
      );
      _fetchMyReview = false;
      reviewLoding = false;
      Loading.dismiss();
      if (response.code == 0) {
        final newRrecords = response.reviews ?? [];
        final accountId = UserService.to.accountId ?? 0;
        newRrecords.removeWhere((element) => element.userId == accountId);

        if (reviews == null) {
          reviews = newRrecords;
        } else {
          reviews!.addAll(newRrecords);
        }
        _lastReviewPage = response.pageMeta?.lastPage;
        _reviewPage = (response.pageMeta?.currentPage ?? _reviewPage) + 1;
        _reviewPageSize = response.pageMeta?.pageSize ?? 20;

        if (response.myReview != null) {
          myReview = response.myReview;
        }
      } else {
        reviewError = true;
        Loading.error(response.message ?? LocaleKeys.unknownError.tr);
      }
      update(["study_course_review"]);
    } on DioException catch (e) {
      Loading.dismiss();
      if (e.type == DioExceptionType.cancel) {
        return;
      }
      reviewLoding = false;
      reviewError = true;
      update(["study_course_review"]);
      Loading.error(e.toString());
      log('Error: $e');
    } catch (e) {
      Loading.dismiss();
      reviewLoding = false;
      reviewError = true;
      update(["study_course_review"]);
      log('Error: $e');
    }
  }

  // 初始化数据
  _initData() {
    Future.delayed(Duration.zero, () {
      loadCourseDetail();
    });
    update(["study_course"]);
  }

  //  加载课程详情
  void loadCourseDetail() async {
    try {
      if (loading) {
        return;
      }
      Loading.show();
      loading = true;
      error = false;
      update(["study_course"]);
      final response = await CourseApi.getCourseDetail(courseId);
      Loading.dismiss();
      loading = false;
      if (response.code == 0) {
        courseDetail = response.course;
        error = false;
        await makeCategoryUnits();
      } else {
        error = true;
        Loading.error(response.message ?? LocaleKeys.unknownError.tr);
      }
      update(["study_course"]);
    } on DioException catch (e) {
      Loading.dismiss();
      if (e.type == DioExceptionType.cancel) {
        return;
      }
      loading = false;
      error = true;
      update(["study_course"]);
      Loading.error(e.toString());
    } catch (e) {
      Loading.dismiss();
      log('Error: $e');
      loading = false;
      error = true;
      update(["study_course"]);
    }
  }

  // 生成课程目录
  Future<void> makeCategoryUnits() async {
    final chapters = courseDetail?.chapters;
    if (chapters == null) {
      return;
    }
    categoryUnits.clear();

    var firstVideoId = 0;

    for (final chapter in chapters) {
      final chapterTitle =
          '${Strings.chapterIndex(chapter.index)} ${chapter.title}';
      categoryUnits.add(CourseTableContentUnitModel(
        id: chapter.id,
        title: chapterTitle,
        isChapter: true,
        isFree: true,
      ));

      for (final item in chapter.videos ?? []) {
        final cIndex = chapter.index;
        final vIndex = item.index;
        final vTitle = item.title;
        final vMiniutes = item.duration ~/ 60;
        final vSeconds = (item.duration % 60).toString().padLeft(2, '0');
        final videoTitle = '$cIndex-$vIndex $vTitle';
        categoryUnits.add(CourseTableContentUnitModel(
          id: item.id,
          title: videoTitle,
          timeString: '$vMiniutes:$vSeconds',
          isChapter: false,
          isFree: true,
        ));

        if (firstVideoId == 0) {
          firstVideoId = item.id;
        }
      }
    }
    await makeFirstVideoMedia(firstVideoId);
  }

  // 切换收藏状态
  void toggleFavorite() async {
    if (_favoriteChanging) {
      return;
    }
    _favoriteChanging = true;

    try {
      if (isMyFavorite) {
        final response = await BusinessApi.removeFavoriteCourse(courseId);
        if (response.code == 0) {
          courseDetail?.isFavorite = false;
          update(["study_course"]);
        } else {
          log(response.message ?? LocaleKeys.unknownError.tr);
        }
      } else {
        final response = await BusinessApi.addFavoriteCourse(courseId);
        if (response.code == 0) {
          courseDetail?.isFavorite = true;
          update(["study_course"]);
        } else {
          log(response.message ?? LocaleKeys.unknownError.tr);
        }
      }
    } catch (e) {
      log('toggleFavorite error: $e');
    } finally {
      _favoriteChanging = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    courseId = int.parse(Get.arguments["id"].toString());
    Get.find<StudyIndexController>().activeCourseId.value = 0;
  }

  @override
  void onReady() {
    super.onReady();
    // 监听视频播放状态
    player.stream.playlist.listen((event) async {
      final medias = event.medias;
      if (medias.length == 2) {
        final media = event.medias[1];
        final videoId = int.parse(media.uri.split('/').last);
        this.videoId.value = videoId;
        progress.value =
            await DataBaseService.to.getVideoProgress(videoId) ?? 0;
        player.next();
        player.play();
        updatePostionWhenPlaying = true;
        Future.delayed(Duration.zero, () async {
          player.remove(0);
        });
      } else if (medias.length == 1) {
        final media = event.medias[0];
        final videoId = int.parse(media.uri.split('/').last);
        this.videoId.value = videoId;
        progress.value =
            await DataBaseService.to.getVideoProgress(videoId) ?? 0;
      }

      if (isDataRead == false) {
        isDataRead = true;
        update(["study_course_video_play"]);
      }
    });

    player.stream.buffer.listen((event) async {
      if (updatePostionWhenPlaying) {
        final videoId = currentVideoId;
        final progress = await DataBaseService.to.getVideoProgress(videoId);
        if (progress != null) {
          final v = player.state.duration.inMilliseconds * progress / 100;
          await player.seek(Duration(milliseconds: v.round()));
        }
        updatePostionWhenPlaying = false;
      }
    });
    // 监听视频播放状态
    player.stream.position.listen(_updateVideoPostion);

    // 监听视频缓冲进度
    player.stream.buffer.listen((event) {
      bufferPositionProgress.value = event;
      update(['video_progress']);
    });

    // 监听视频播放错误状态
    player.stream.error.listen((event) {
      log('video error: $event');
    });

    // 监听视频播放完成状态
    player.stream.completed.listen((event) async {
      if (event) {
        final videoId = currentVideoId;
        final progress = (positionProgress.value.inMilliseconds /
                player.state.duration.inMilliseconds) *
            100;
        final millseconds = positionProgress.value.inMilliseconds;
        await DataBaseService.to
            .setVideoProgress(videoId, courseId, millseconds, progress);
      }
    });
    _initData();
  }

  // 更新视频位置
  void _updateVideoPostion(Duration v) {
    if (!manualPostionChaning && !updatePostionWhenPlaying) {
      positionProgress.value = v;
      update(['video_progress']); // 强制刷新进度条
    }
    if (!updatePostionWhenPlaying) {
      final duration = player.state.duration.inMilliseconds;
      if (duration == 0) {
        progress.value = 0.0;
      } else {
        progress.value = (v.inMilliseconds / duration) * 100;
      }
    }
  }

  @override
  void dispose() {
    final videoId = currentVideoId;
    if (videoId != 0) {
      final progress = (positionProgress.value.inMilliseconds /
              player.state.duration.inMilliseconds) *
          100;
      final milliseconds = positionProgress.value.inMilliseconds;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await DataBaseService.to
            .setVideoProgress(videoId, courseId, milliseconds, progress);
        Get.find<StudyIndexController>().activeCourseId.value = courseId;
      });
    }
    _reviewCancelToken?.cancel();
    player.dispose();
    super.dispose();
  }

  // 返回上一页
  void jumpToBack() {
    final videoId = currentVideoId;
    if (videoId != 0) {
      final progress = (positionProgress.value.inMilliseconds /
              player.state.duration.inMilliseconds) *
          100;
      final milliseconds = positionProgress.value.inMilliseconds;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await DataBaseService.to
            .setVideoProgress(videoId, courseId, milliseconds, progress);
        Get.find<StudyIndexController>().activeCourseId.value = courseId;
      });
    }
    player.pause();
    Get.back();
  }

  // 加载第一个视频
  Future<void> makeFirstVideoMedia(int videoId) async {
    final token = UserService.to.token;
    if (!UserService.to.hasToken) {
      return;
    }

    final videoUrl = '${Constants.wpVideoApiBaseUrl}/v1/course/video/$videoId';

    final m = Media(
      videoUrl,
      httpHeaders: {
        'authorization': 'Bearer $token',
      },
    );

    progress.value = await DataBaseService.to.getVideoProgress(videoId) ?? 0;

    await player.open(m, play: true);
  }

  // 加载视频
  void loadVideo(int videoId) async {
    final token = UserService.to.token;
    if (!UserService.to.hasToken) {
      return;
    }

    await player.pause();

    final oldId = currentVideoId;
    if (oldId != 0) {
      final progress = (positionProgress.value.inMilliseconds /
              player.state.duration.inMilliseconds) *
          100;
      final millseconds = positionProgress.value.inMilliseconds;
      await DataBaseService.to
          .setVideoProgress(oldId, courseId, millseconds, progress);
    }

    Future.delayed(Duration.zero, () async {
      bufferPositionProgress.value = Duration.zero;
      progress.value = await DataBaseService.to.getVideoProgress(videoId) ?? 0;
      positionProgress.value = Duration.zero;

      final videoUrl =
          '${Constants.wpVideoApiBaseUrl}/v1/course/video/$videoId';
      final m = Media(
        videoUrl,
        httpHeaders: {
          'authorization': 'Bearer $token',
        },
      );
      await player.add(m);

      isDataRead = false;
      update(["study_course_video_play", "study_course_table_contents"]);
    });
  }

  void videoPositionChangeStart(double v) {
    manualPostionChaning = true;
    isPlaying = player.state.playing;
    player.pause();
  }

  void videoPositionChanging(double v) {
    positionProgress.value = Duration(milliseconds: v.round());
  }

  void videoPositionChangeEnd(double v) async {
    await player.seek(Duration(milliseconds: v.round()));
    manualPostionChaning = false;
    if (isPlaying) {
      player.play();
    }
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  // 播放视频
  void playVideo(int videoId) async {
    if (videoId == currentVideoId) {
      return;
    }
    loadVideo(videoId);
  }
}
