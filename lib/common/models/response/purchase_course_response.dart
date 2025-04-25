import 'package:json_annotation/json_annotation.dart';
import 'package:onlinelearning/common/index.dart';

part 'purchase_course_response.g.dart';

@JsonSerializable()
class PurchaseCourseResponse extends BaseResponse {
  @JsonKey(name: 'total_price')
  double? totalPrice;

  PurchaseCourseResponse({required super.code, super.message, this.totalPrice});

  factory PurchaseCourseResponse.fromJson(Map<String, dynamic> json) =>
      _$PurchaseCourseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseCourseResponseToJson(this);
}
