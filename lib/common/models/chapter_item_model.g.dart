// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterItemModel _$ChapterItemModelFromJson(Map<String, dynamic> json) =>
    ChapterItemModel(
      id: (json['id'] as num).toInt(),
      index: (json['index'] as num).toInt(),
      title: json['title'] as String,
      videos: (json['videos'] as List<dynamic>?)
          ?.map((e) => VideoItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChapterItemModelToJson(ChapterItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'title': instance.title,
      'videos': instance.videos,
    };
