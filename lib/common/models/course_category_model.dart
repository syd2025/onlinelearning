import 'package:json_annotation/json_annotation.dart';
import 'package:onlinelearning/common/index.dart';

part 'course_category_model.g.dart';

@JsonSerializable()
class CourseCategoryModel {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'icon')
  String icon;
  @JsonKey(name: 'subs')
  List<CourseSubcategoryModel> subCategories;

  CourseCategoryModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.subCategories,
  });

  factory CourseCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CourseCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseCategoryModelToJson(this);
}
