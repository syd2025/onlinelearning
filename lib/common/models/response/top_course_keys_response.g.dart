// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_course_keys_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopCourseKeysResponse _$TopCourseKeysResponseFromJson(
        Map<String, dynamic> json) =>
    TopCourseKeysResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String?,
      keys: (json['keys'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TopCourseKeysResponseToJson(
        TopCourseKeysResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'keys': instance.keys,
    };
