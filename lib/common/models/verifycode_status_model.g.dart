// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verifycode_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyCodeStatus _$VerifyCodeStatusFromJson(Map<String, dynamic> json) =>
    VerifyCodeStatus(
      type: json['type'] as String,
      status: (json['status'] as num).toInt(),
      validMinutes: (json['valid_minites'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VerifyCodeStatusToJson(VerifyCodeStatus instance) =>
    <String, dynamic>{
      'type': instance.type,
      'status': instance.status,
      'valid_minites': instance.validMinutes,
    };
