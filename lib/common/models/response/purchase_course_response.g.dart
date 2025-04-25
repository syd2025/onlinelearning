// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_course_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseCourseResponse _$PurchaseCourseResponseFromJson(
        Map<String, dynamic> json) =>
    PurchaseCourseResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String?,
      totalPrice: (json['total_price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PurchaseCourseResponseToJson(
        PurchaseCourseResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'total_price': instance.totalPrice,
    };
