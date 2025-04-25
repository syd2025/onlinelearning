import 'package:json_annotation/json_annotation.dart';

part 'user_profile_field_model.g.dart';

@JsonSerializable()
class UserProfileFieldModel {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'field')
  String field;
  @JsonKey(name: 'value')
  String value;
  @JsonKey(name: 'list')
  List<String>? list;

  UserProfileFieldModel({
    required this.id,
    required this.field,
    required this.value,
    this.list,
  });

  factory UserProfileFieldModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFieldModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileFieldModelToJson(this);
}
