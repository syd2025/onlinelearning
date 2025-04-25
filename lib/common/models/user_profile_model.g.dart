// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
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
              .toList() ??
          const [],
      purchasedCourses: (json['purchased_courses'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      wechatId: json['wechat_id'] as String?,
      region: json['region'] as String?,
      regionCodeList: (json['region_code_array'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      introduction: json['introduction'] as String?,
      profession: json['profession'] as String?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'gender': instance.gender,
      'avatar': instance.avatar,
      'created_at': instance.createdAt?.toIso8601String(),
      'purchasing_courses': instance.purchasingCourses,
      'purchased_courses': instance.purchasedCourses,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'wechat_id': instance.wechatId,
      'region': instance.region,
      'region_code_array': instance.regionCodeList,
      'introduction': instance.introduction,
      'profession': instance.profession,
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
