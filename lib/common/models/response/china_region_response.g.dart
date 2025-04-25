// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'china_region_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChinaRegionResponse _$ChinaRegionResponseFromJson(Map<String, dynamic> json) =>
    ChinaRegionResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String?,
      regions: (json['regions'] as List<dynamic>?)
          ?.map((e) => ChinaRegionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChinaRegionResponseToJson(
        ChinaRegionResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'regions': instance.regions,
    };
