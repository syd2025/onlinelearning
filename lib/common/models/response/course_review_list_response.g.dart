// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_review_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseReviewListResponse _$CourseReviewListResponseFromJson(
        Map<String, dynamic> json) =>
    CourseReviewListResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String?,
      myReview: json['my_review'] == null
          ? null
          : CourseReviewModel.fromJson(
              json['my_review'] as Map<String, dynamic>),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => CourseReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageMeta: json['page_meta'] == null
          ? null
          : PageMetaModel.fromJson(json['page_meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CourseReviewListResponseToJson(
        CourseReviewListResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'my_review': instance.myReview,
      'reviews': instance.reviews,
      'page_meta': instance.pageMeta,
    };
