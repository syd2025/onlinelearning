// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_meta_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageMetaModel _$PageMetaModelFromJson(Map<String, dynamic> json) =>
    PageMetaModel(
      offset: (json['offset'] as num).toInt(),
      currentPage: (json['current_page'] as num).toInt(),
      pageSize: (json['page_size'] as num).toInt(),
      firstPage: (json['first_page'] as num).toInt(),
      lastPage: (json['last_page'] as num).toInt(),
      totalCount: (json['total_records'] as num).toInt(),
    );

Map<String, dynamic> _$PageMetaModelToJson(PageMetaModel instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'current_page': instance.currentPage,
      'page_size': instance.pageSize,
      'first_page': instance.firstPage,
      'last_page': instance.lastPage,
      'total_records': instance.totalCount,
    };
