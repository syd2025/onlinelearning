import 'package:json_annotation/json_annotation.dart';

part 'course_subcategory_model.g.dart';

@JsonSerializable()
class CourseSubcategoryModel {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'icon')
  String icon;

  CourseSubcategoryModel({
    required this.id,
    required this.title,
    required this.icon,
  });

  factory CourseSubcategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CourseSubcategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseSubcategoryModelToJson(this);
}
