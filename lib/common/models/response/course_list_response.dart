import 'package:json_annotation/json_annotation.dart';
import 'package:onlinelearning/common/index.dart';

part 'course_list_response.g.dart';

@JsonSerializable()
class CourseListResponse extends BaseResponse {
  @JsonKey(name: 'courses')
  List<CourseBriefModel>? courses;
  @JsonKey(name: 'page_meta')
  PageMetaModel? pageMeta;

  CourseListResponse({
    required super.code,
    super.message,
    this.courses,
    this.pageMeta,
  });

  factory CourseListResponse.fromJson(Map<String, dynamic> json) =>
      _$CourseListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseListResponseToJson(this);
}
