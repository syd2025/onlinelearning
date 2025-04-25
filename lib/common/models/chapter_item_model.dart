import 'package:json_annotation/json_annotation.dart';
import 'package:onlinelearning/common/index.dart';

part 'chapter_item_model.g.dart';

@JsonSerializable()
class ChapterItemModel {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'index')
  int index;
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'videos')
  List<VideoItemModel>? videos;

  ChapterItemModel({
    required this.id,
    required this.index,
    required this.title,
    this.videos,
  });

  factory ChapterItemModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterItemModelToJson(this);
}
