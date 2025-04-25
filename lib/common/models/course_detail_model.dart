import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:onlinelearning/common/index.dart';

part 'course_detail_model.g.dart';

@JsonSerializable()
class CourseDetailModel {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'image')
  String image;
  @JsonKey(name: 'video_count')
  int videoCount;
  @JsonKey(name: 'duration')
  int duration;
  @JsonKey(name: 'level')
  String level;
  @JsonKey(name: 'price')
  double price;
  @JsonKey(name: 'description')
  String description;
  @JsonKey(name: 'skills')
  List<String> skills;
  @JsonKey(name: 'contents')
  List<ChapterItemModel> chapters;
  @JsonKey(name: 'author')
  CourseAuthorModel author;
  @JsonKey(name: 'student_count')
  int studentCount;
  @JsonKey(name: 'review_summary')
  CourseReviewSummaryModel reviewSummary;
  @JsonKey(name: 'is_favorite')
  bool isFavorite;

  CourseDetailModel({
    required this.id,
    required this.title,
    required this.image,
    required this.videoCount,
    required this.duration,
    required this.level,
    required this.price,
    required this.description,
    required this.skills,
    required this.chapters,
    required this.author,
    required this.studentCount,
    required this.reviewSummary,
    required this.isFavorite,
  });

  factory CourseDetailModel.fromJson(Map<String, dynamic> json) =>
      _$CourseDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseDetailModelToJson(this);

  // 获取课程的图片URL，拼接基础URL和图片路径
  String get imageUrl => '${Constants.wpApiBaseUrl}/v1/course/image/$image';

  // 获取课程的价格字符串，格式为 "¥X.00"
  String get minorTitle {
    return '${author.name} | ${author.selfApplyedTitle ?? author.levelMarkTitle ?? author.learnMarkTitle ?? ''}';
  }

  // 获取课程级别的标题
  String get levelTitle {
    switch (level) {
      case 'beginner':
        return LocaleKeys.beginner.tr;
      case 'intermediate':
        return LocaleKeys.intermediate.tr;
      case 'advanced':
        return LocaleKeys.advanced.tr;
      default:
        return '';
    }
  }

  // 获取持续学习时长
  String get durationInHours {
    final hours = duration ~/ 3600;
    return '$hours${LocaleKeys.hour.tr}';
  }
}
