// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseListResponse _$CourseListResponseFromJson(Map<String, dynamic> json) =>
    CourseListResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String?,
      courses: (json['courses'] as List<dynamic>?)
          ?.map((e) => CourseBriefModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageMeta: json['page_meta'] == null
          ? null
          : PageMetaModel.fromJson(json['page_meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CourseListResponseToJson(CourseListResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'courses': instance.courses,
      'page_meta': instance.pageMeta,
    };
