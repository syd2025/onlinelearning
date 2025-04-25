// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorMessageModel _$ErrorMessageModelFromJson(Map<String, dynamic> json) =>
    ErrorMessageModel(
      statusCode: (json['status_code'] as num?)?.toInt(),
      error: json['error'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ErrorMessageModelToJson(ErrorMessageModel instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'error': instance.error,
      'message': instance.message,
    };
