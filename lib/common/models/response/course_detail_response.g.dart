// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseDetailResponse _$CourseDetailResponseFromJson(
        Map<String, dynamic> json) =>
    CourseDetailResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String?,
      course: json['course'] == null
          ? null
          : CourseDetailModel.fromJson(json['course'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CourseDetailResponseToJson(
        CourseDetailResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'course': instance.course,
    };
