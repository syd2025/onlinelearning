// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseDetailModel _$CourseDetailModelFromJson(Map<String, dynamic> json) =>
    CourseDetailModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      image: json['image'] as String,
      videoCount: (json['video_count'] as num).toInt(),
      duration: (json['duration'] as num).toInt(),
      level: json['level'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      skills:
          (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
      chapters: (json['contents'] as List<dynamic>)
          .map((e) => ChapterItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      author:
          CourseAuthorModel.fromJson(json['author'] as Map<String, dynamic>),
      studentCount: (json['student_count'] as num).toInt(),
      reviewSummary: CourseReviewSummaryModel.fromJson(
          json['review_summary'] as Map<String, dynamic>),
      isFavorite: json['is_favorite'] as bool,
    );

Map<String, dynamic> _$CourseDetailModelToJson(CourseDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'video_count': instance.videoCount,
      'duration': instance.duration,
      'level': instance.level,
      'price': instance.price,
      'description': instance.description,
      'skills': instance.skills,
      'contents': instance.chapters,
      'author': instance.author,
      'student_count': instance.studentCount,
      'review_summary': instance.reviewSummary,
      'is_favorite': instance.isFavorite,
    };
