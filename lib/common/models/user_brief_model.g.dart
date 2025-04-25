// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_brief_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBriefModel _$UserBriefModelFromJson(Map<String, dynamic> json) =>
    UserBriefModel(
      id: (json['id'] as num?)?.toInt(),
      type: json['type'] as String?,
      name: json['name'] as String?,
      gender: json['gender'] as String?,
      avatar: json['avatar'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      purchasingCourses: (json['purchasing_courses'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      purchasedCourses: (json['purchased_courses'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$UserBriefModelToJson(UserBriefModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'gender': instance.gender,
      'avatar': instance.avatar,
      'created_at': instance.createdAt?.toIso8601String(),
      'purchasing_courses': instance.purchasingCourses,
      'purchased_courses': instance.purchasedCourses,
    };
