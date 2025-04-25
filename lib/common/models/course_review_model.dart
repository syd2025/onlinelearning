import 'package:json_annotation/json_annotation.dart';

part 'course_review_model.g.dart';

@JsonSerializable()
class CourseReviewModel {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'course_id')
  int courseId;
  @JsonKey(name: 'user_id')
  int userId;
  @JsonKey(name: 'user_name')
  String userName;
  @JsonKey(name: 'content')
  String content;
  @JsonKey(name: 'rating')
  int rating;
  @JsonKey(name: 'review_at')
  DateTime reviewAt;
  @JsonKey(name: 'reply_id')
  int? replyId;
  @JsonKey(name: 'reply')
  String? reply;
  @JsonKey(name: 'reply_at')
  DateTime? replyAt;

  CourseReviewModel({
    required this.id,
    required this.courseId,
    required this.userId,
    required this.userName,
    required this.content,
    required this.rating,
    required this.reviewAt,
    this.replyId,
    this.reply,
    this.replyAt,
  });

  factory CourseReviewModel.fromJson(Map<String, dynamic> json) =>
      _$CourseReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseReviewModelToJson(this);
}
