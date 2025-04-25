import 'package:json_annotation/json_annotation.dart';
import 'package:onlinelearning/common/index.dart';

part 'course_detail_response.g.dart';

@JsonSerializable()
class CourseDetailResponse extends BaseResponse {
  @JsonKey(name: 'course')
  CourseDetailModel? course;

  CourseDetailResponse({
    required super.code,
    super.message,
    this.course,
  });

  factory CourseDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$CourseDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseDetailResponseToJson(this);
}
