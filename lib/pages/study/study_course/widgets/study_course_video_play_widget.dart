import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class StudyCourseVideoPlayWidget extends StatelessWidget {
  StudyCourseVideoPlayWidget({super.key});

  final controller = Get.find<StudyCourseController>();

  Widget _buildVideoControlBar(VideoState state) {
    if (!controller.isDataRead) {
      return const SizedBox.shrink();
    } else {
      final player = controller.player;
      return <Widget>[
        const Spacer(),
        Container(
          height: 44.h,
          width: double.infinity,
          color: Colors.white24,
          child: <Widget>[
            const MaterialPlayOrPauseButton(iconSize: 24),
            GetBuilder<StudyCourseController>(
              id: "video_progress",
              builder: (_) {
                return Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(Get.context!).copyWith(
                      trackHeight: 3.h,
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 8),
                      overlayShape:
                          const RoundSliderOverlayShape(overlayRadius: 10),
                      thumbColor: Colors.white,
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: AppTheme.greyColor.withAlpha(128),
                      secondaryActiveTrackColor: Colors.green,
                    ),
                    child: Slider(
                      value: controller.positionProgress.value.inMilliseconds
                          .toDouble(),
                      secondaryTrackValue: controller
                          .bufferPositionProgress.value.inMilliseconds
                          .toDouble(),
                      min: 0,
                      max: player.state.duration.inMilliseconds.toDouble(),
                      onChangeStart: controller.videoPositionChangeStart,
                      onChanged: controller.videoPositionChanging,
                      onChangeEnd: controller.videoPositionChangeEnd,
                    ),
                  ),
                );
              },
            ),
            SizedBox(width: 5.w),
            const MaterialDesktopPositionIndicator(
              style: TextStyle(
                fontFamily: 'Courier',
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const MaterialDesktopVolumeButton(),
          ].toRow(),
        ),
      ].toColumn();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudyCourseController>(
      init: controller,
      id: "study_course_video_play",
      builder: (_) {
        return GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! < 5.0) {
              controller.jumpToBack(); // 向左滑
            } else if (details.primaryVelocity! > 5.0) {
              controller.jumpToBack(); // 向右滑
            }
          },
          child: Center(
            child: Video(
              controller: controller.videoController,
              controls: (state) {
                return _buildVideoControlBar(state);
              },
            ),
          ),
        );
      },
    );
  }
}
