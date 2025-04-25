// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseReviewResponse _$CourseReviewResponseFromJson(
        Map<String, dynamic> json) =>
    CourseReviewResponse(
      id: (json['id'] as num).toInt(),
      courseId: (json['course_id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      userName: json['user_name'] as String,
      content: json['content'] as String,
      rating: (json['rating'] as num).toInt(),
      reviewAt: DateTime.parse(json['review_at'] as String),
      replyId: (json['reply_id'] as num?)?.toInt(),
      reply: json['reply'] as String?,
      replyAt: json['reply_at'] == null
          ? null
          : DateTime.parse(json['reply_at'] as String),
    );

Map<String, dynamic> _$CourseReviewResponseToJson(
        CourseReviewResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course_id': instance.courseId,
      'user_id': instance.userId,
      'user_name': instance.userName,
      'content': instance.content,
      'rating': instance.rating,
      'review_at': instance.reviewAt.toIso8601String(),
      'reply_id': instance.replyId,
      'reply': instance.reply,
      'reply_at': instance.replyAt?.toIso8601String(),
    };
