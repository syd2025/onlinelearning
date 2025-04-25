// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'china_region_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChinaRegionModel _$ChinaRegionModelFromJson(Map<String, dynamic> json) =>
    ChinaRegionModel(
      code: json['code'] as String,
      name: json['name'] as String,
      level: (json['level'] as num).toInt(),
      category: (json['category'] as num).toInt(),
    );

Map<String, dynamic> _$ChinaRegionModelToJson(ChinaRegionModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'level': instance.level,
      'category': instance.category,
    };
