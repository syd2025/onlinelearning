// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_field_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileFieldResponse _$UserProfileFieldResponseFromJson(
        Map<String, dynamic> json) =>
    UserProfileFieldResponse(
      result: json['result'] == null
          ? null
          : UserProfileFieldModel.fromJson(
              json['result'] as Map<String, dynamic>),
      message: json['message'] as String?,
      code: (json['code'] as num).toInt(),
    );

Map<String, dynamic> _$UserProfileFieldResponseToJson(
        UserProfileFieldResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };
