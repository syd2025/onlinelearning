import 'package:json_annotation/json_annotation.dart';
import 'package:onlinelearning/common/index.dart';

part 'course_order_list_response.g.dart'; // 生成的代码文件，用于序列化和反序列化Dat

@JsonSerializable()
class CourseOrderListResponse extends BaseResponse {
  @JsonKey(name: 'orders')
  List<CourseOrderModel>? orders;

  CourseOrderListResponse({required super.code, super.message, this.orders});

  factory CourseOrderListResponse.fromJson(Map<String, dynamic> json) =>
      _$CourseOrderListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseOrderListResponseToJson(this);
}
