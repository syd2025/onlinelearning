// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseCategoryModel _$CourseCategoryModelFromJson(Map<String, dynamic> json) =>
    CourseCategoryModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      icon: json['icon'] as String,
      subCategories: (json['subs'] as List<dynamic>)
          .map(
              (e) => CourseSubcategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CourseCategoryModelToJson(
        CourseCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'icon': instance.icon,
      'subs': instance.subCategories,
    };
