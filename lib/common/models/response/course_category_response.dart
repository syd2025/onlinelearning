import 'package:json_annotation/json_annotation.dart';
import 'package:onlinelearning/common/index.dart';

part 'course_category_response.g.dart';

@JsonSerializable()
class CourseCategoryResponse extends BaseResponse {
  @JsonKey(name: 'categories')
  List<CourseCategoryModel>? categories;

  CourseCategoryResponse({
    required super.code,
    super.message,
    this.categories,
  });

  factory CourseCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CourseCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseCategoryResponseToJson(this);
}
