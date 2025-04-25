import 'package:json_annotation/json_annotation.dart';

part 'china_region_model.g.dart';

@JsonSerializable()
class ChinaRegionModel {
  @JsonKey(name: 'code')
  String code;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'level')
  int level;
  @JsonKey(name: 'category')
  int category;

  ChinaRegionModel({
    required this.code,
    required this.name,
    required this.level,
    required this.category,
  });

  factory ChinaRegionModel.fromJson(Map<String, dynamic> json) =>
      _$ChinaRegionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChinaRegionModelToJson(this);
}
