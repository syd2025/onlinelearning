// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseCategoryResponse _$CourseCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    CourseCategoryResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => CourseCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CourseCategoryResponseToJson(
        CourseCategoryResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'categories': instance.categories,
    };
