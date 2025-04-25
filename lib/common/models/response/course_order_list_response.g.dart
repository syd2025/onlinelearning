// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_order_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseOrderListResponse _$CourseOrderListResponseFromJson(
        Map<String, dynamic> json) =>
    CourseOrderListResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String?,
      orders: (json['orders'] as List<dynamic>?)
          ?.map((e) => CourseOrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CourseOrderListResponseToJson(
        CourseOrderListResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'orders': instance.orders,
    };
