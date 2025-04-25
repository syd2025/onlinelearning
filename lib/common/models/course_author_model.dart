import 'package:json_annotation/json_annotation.dart';

part 'course_author_model.g.dart';

@JsonSerializable()
class CourseAuthorModel {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'introduction')
  String? introduction;
  @JsonKey(name: 'self_apply')
  String? selfApplyedTitle;
  @JsonKey(name: 'learn_mark')
  String? learnMarkTitle;
  @JsonKey(name: 'sell_mark')
  String? sellMarkTitle;
  @JsonKey(name: 'level_mark')
  String? levelMarkTitle;

  CourseAuthorModel({
    required this.id,
    required this.name,
    this.introduction,
    this.selfApplyedTitle,
    this.learnMarkTitle,
    this.sellMarkTitle,
    this.levelMarkTitle,
  });

  factory CourseAuthorModel.fromJson(Map<String, dynamic> json) =>
      _$CourseAuthorModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseAuthorModelToJson(this);
}
