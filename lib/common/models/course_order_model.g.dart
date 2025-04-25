// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseOrderModel _$CourseOrderModelFromJson(Map<String, dynamic> json) =>
    CourseOrderModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      image: json['image'] as String,
      videoCount: (json['video_count'] as num).toInt(),
      duration: (json['duration'] as num).toInt(),
      level: json['level'] as String,
      price: (json['price'] as num).toDouble(),
      author: json['author'] as String,
      authorId: (json['author_id'] as num).toInt(),
      studentCount: (json['student_count'] as num).toInt(),
      orderAt: DateTime.parse(json['order_at'] as String),
    );

Map<String, dynamic> _$CourseOrderModelToJson(CourseOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'video_count': instance.videoCount,
      'duration': instance.duration,
      'level': instance.level,
      'price': instance.price,
      'author': instance.author,
      'author_id': instance.authorId,
      'student_count': instance.studentCount,
      'order_at': instance.orderAt.toIso8601String(),
    };
