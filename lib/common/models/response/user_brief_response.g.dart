// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_brief_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBriefResponse _$UserBriefResponseFromJson(Map<String, dynamic> json) =>
    UserBriefResponse(
      code: (json['code'] as num).toInt(),
      token: json['token'] as String?,
      brief: json['brief'] == null
          ? null
          : UserBriefModel.fromJson(json['brief'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$UserBriefResponseToJson(UserBriefResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'token': instance.token,
      'brief': instance.brief,
    };
