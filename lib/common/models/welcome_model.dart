/// 欢迎数据 Model
library;

import 'package:json_annotation/json_annotation.dart';

part 'welcome_model.g.dart';

@JsonSerializable()
class WelcomeModel {
  /// 图片url
  @JsonKey(name: "image")
  String? image;

  /// 标题
  @JsonKey(name: "title")
  String? title;

  /// 说明
  @JsonKey(name: "desc")
  String? desc;

  WelcomeModel({this.image, this.title, this.desc});

  factory WelcomeModel.fromJson(Map<String, dynamic> json) =>
      _$WelcomeModelFromJson(json);

  Map<String, dynamic> toJson() => _$WelcomeModelToJson(this);
}
