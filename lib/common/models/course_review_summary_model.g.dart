// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_review_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseReviewSummaryModel _$CourseReviewSummaryModelFromJson(
        Map<String, dynamic> json) =>
    CourseReviewSummaryModel(
      totalCount: (json['total_count'] as num).toInt(),
      avgRating: (json['avg_rating'] as num?)?.toDouble(),
      ratingCounts: (json['rating_counts'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(int.parse(k), (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$CourseReviewSummaryModelToJson(
        CourseReviewSummaryModel instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'avg_rating': instance.avgRating,
      'rating_counts':
          instance.ratingCounts?.map((k, e) => MapEntry(k.toString(), e)),
    };
