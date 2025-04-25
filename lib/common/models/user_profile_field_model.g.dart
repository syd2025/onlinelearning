// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_field_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileFieldModel _$UserProfileFieldModelFromJson(
        Map<String, dynamic> json) =>
    UserProfileFieldModel(
      id: (json['id'] as num).toInt(),
      field: json['field'] as String,
      value: json['value'] as String,
      list: (json['list'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserProfileFieldModelToJson(
        UserProfileFieldModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'field': instance.field,
      'value': instance.value,
      'list': instance.list,
    };
