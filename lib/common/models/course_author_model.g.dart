// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_author_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseAuthorModel _$CourseAuthorModelFromJson(Map<String, dynamic> json) =>
    CourseAuthorModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      introduction: json['introduction'] as String?,
      selfApplyedTitle: json['self_apply'] as String?,
      learnMarkTitle: json['learn_mark'] as String?,
      sellMarkTitle: json['sell_mark'] as String?,
      levelMarkTitle: json['level_mark'] as String?,
    );

Map<String, dynamic> _$CourseAuthorModelToJson(CourseAuthorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'introduction': instance.introduction,
      'self_apply': instance.selfApplyedTitle,
      'learn_mark': instance.learnMarkTitle,
      'sell_mark': instance.sellMarkTitle,
      'level_mark': instance.levelMarkTitle,
    };
