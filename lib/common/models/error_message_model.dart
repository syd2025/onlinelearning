import 'package:json_annotation/json_annotation.dart';

part 'error_message_model.g.dart';

/// 错误体信息
@JsonSerializable()
class ErrorMessageModel {
  @JsonKey(name: 'status_code')
  int? statusCode;
  @JsonKey(name: 'error')
  String? error;
  @JsonKey(name: 'message')
  String? message;

  ErrorMessageModel({
    this.statusCode,
    this.error,
    this.message,
  });

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorMessageModelToJson(this);
}
