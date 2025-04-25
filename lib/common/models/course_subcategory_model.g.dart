// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_subcategory_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseSubcategoryModel _$CourseSubcategoryModelFromJson(
        Map<String, dynamic> json) =>
    CourseSubcategoryModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$CourseSubcategoryModelToJson(
        CourseSubcategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'icon': instance.icon,
    };
