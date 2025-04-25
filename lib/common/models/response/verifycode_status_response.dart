import 'package:json_annotation/json_annotation.dart';
import 'package:onlinelearning/common/index.dart';

part 'verifycode_status_response.g.dart';

@JsonSerializable()
class VerifyCodeStatusResponse extends BaseResponse {
  @JsonKey(name: "status")
  VerifyCodeStatus? status;

  VerifyCodeStatusResponse({this.status, required super.code, super.message});

  factory VerifyCodeStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyCodeStatusResponseToJson(this);
}
