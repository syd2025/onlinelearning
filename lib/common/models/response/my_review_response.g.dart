// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_review_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyReviewResponse _$MyReviewResponseFromJson(Map<String, dynamic> json) =>
    MyReviewResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String?,
      review: json['my_review'] == null
          ? null
          : CourseReviewModel.fromJson(
              json['my_review'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyReviewResponseToJson(MyReviewResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'my_review': instance.review,
    };
