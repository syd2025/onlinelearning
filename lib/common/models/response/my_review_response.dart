import 'package:json_annotation/json_annotation.dart';
import 'package:onlinelearning/common/index.dart';

part 'my_review_response.g.dart';

@JsonSerializable()
class MyReviewResponse extends BaseResponse {
  @JsonKey(name: 'my_review')
  CourseReviewModel? review;

  MyReviewResponse({required super.code, super.message, this.review});

  factory MyReviewResponse.fromJson(Map<String, dynamic> json) =>
      _$MyReviewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyReviewResponseToJson(this);
}
