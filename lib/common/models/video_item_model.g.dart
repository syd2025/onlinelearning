// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoItemModel _$VideoItemModelFromJson(Map<String, dynamic> json) =>
    VideoItemModel(
      id: (json['id'] as num).toInt(),
      index: (json['index'] as num).toInt(),
      title: json['title'] as String,
      duration: (json['duration'] as num).toInt(),
    );

Map<String, dynamic> _$VideoItemModelToJson(VideoItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'title': instance.title,
      'duration': instance.duration,
    };
