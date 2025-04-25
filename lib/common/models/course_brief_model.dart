import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:onlinelearning/common/index.dart';

part 'course_brief_model.g.dart';

@JsonSerializable()
class CourseBriefModel {
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
  @JsonKey(name: 'author')
  String author;
  @JsonKey(name: 'author_id')
  int authorId;
  @JsonKey(name: 'student_count')
  int studentCount;

  CourseBriefModel({
    required this.id,
    required this.title,
    required this.image,
    required this.videoCount,
    required this.duration,
    required this.level,
    required this.price,
    required this.author,
    required this.authorId,
    required this.studentCount,
  });

  factory CourseBriefModel.fromJson(Map<String, dynamic> json) =>
      _$CourseBriefModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseBriefModelToJson(this);

  String get imageUrl => '${Constants.wpApiBaseUrl}/v1/course/image/$image';

  String get levelTitle {
    switch (level) {
      case 'beginner':
        return LocaleKeys.beginner.tr;
      case 'intermediate':
        return LocaleKeys.intermediate.tr;
      case 'advanced':
        return LocaleKeys.advanced.tr;
      default:
        return "";
    }
  }

  int get durationInMinutes => duration ~/ 60;

  int get durationInMilliseconds => duration * 1000;
}
