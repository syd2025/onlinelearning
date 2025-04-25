import 'package:json_annotation/json_annotation.dart';

part 'video_item_model.g.dart';

@JsonSerializable()
class VideoItemModel {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'index')
  int index;
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'duration')
  int duration;

  VideoItemModel({
    required this.id,
    required this.index,
    required this.title,
    required this.duration,
  });

  factory VideoItemModel.fromJson(Map<String, dynamic> json) =>
      _$VideoItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$VideoItemModelToJson(this);
}
