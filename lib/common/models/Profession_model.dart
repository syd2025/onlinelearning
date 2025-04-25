import 'package:json_annotation/json_annotation.dart';

part 'profession_model.g.dart';

@JsonSerializable()
class ProfessionModel {
  int id;
  String title;

  ProfessionModel({
    required this.id,
    required this.title,
  });

  factory ProfessionModel.fromJson(Map<String, dynamic> json) =>
      _$ProfessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfessionModelToJson(this);
}
