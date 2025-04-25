// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profession_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfessionResponse _$ProfessionResponseFromJson(Map<String, dynamic> json) =>
    ProfessionResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String?,
      professions: (json['professions'] as List<dynamic>?)
          ?.map((e) => ProfessionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfessionResponseToJson(ProfessionResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'professions': instance.professions,
    };
