// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profession_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfessionModel _$ProfessionModelFromJson(Map<String, dynamic> json) =>
    ProfessionModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
    );

Map<String, dynamic> _$ProfessionModelToJson(ProfessionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
