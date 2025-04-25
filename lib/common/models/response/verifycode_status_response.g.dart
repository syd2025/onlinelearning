// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verifycode_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyCodeStatusResponse _$VerifyCodeStatusResponseFromJson(
        Map<String, dynamic> json) =>
    VerifyCodeStatusResponse(
      status: json['status'] == null
          ? null
          : VerifyCodeStatus.fromJson(json['status'] as Map<String, dynamic>),
      code: (json['code'] as num).toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$VerifyCodeStatusResponseToJson(
        VerifyCodeStatusResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'status': instance.status,
    };
