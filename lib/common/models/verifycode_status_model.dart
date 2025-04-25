import 'package:json_annotation/json_annotation.dart';

part 'verifycode_status_model.g.dart';

@JsonSerializable()
class VerifyCodeStatus {
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'status')
  int status;
  @JsonKey(name: 'valid_minites')
  int? validMinutes;

  VerifyCodeStatus(
      {required this.type, required this.status, this.validMinutes});

  factory VerifyCodeStatus.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeStatusFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyCodeStatusToJson(this);
}
