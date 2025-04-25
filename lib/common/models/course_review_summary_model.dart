import 'package:json_annotation/json_annotation.dart';

part 'course_review_summary_model.g.dart';

@JsonSerializable()
class CourseReviewSummaryModel {
  @JsonKey(name: 'total_count')
  int totalCount;
  @JsonKey(name: 'avg_rating')
  double? avgRating;
  @JsonKey(name: 'rating_counts')
  Map<int, int>? ratingCounts;

  CourseReviewSummaryModel({
    required this.totalCount,
    this.avgRating,
    this.ratingCounts,
  });

  factory CourseReviewSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$CourseReviewSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseReviewSummaryModelToJson(this);

  // 获取课程的评价数量
  bool get hasRatings => totalCount > 0;

  // 获取课程的平均评分
  double get rating => avgRating ?? 0;

  // 获取课程的评分字符串，格式为 "X.0 / 5.0"
  String get ratingString => '${(avgRating ?? 0).toStringAsFixed(1)} / 5.0';
}
