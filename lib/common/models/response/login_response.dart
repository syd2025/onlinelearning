import 'package:json_annotation/json_annotation.dart';
import 'package:onlinelearning/common/index.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'token')
  String? token;
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'brief')
  UserBriefModel? brief;

  LoginResponse({
    this.code,
    this.token,
    this.brief,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
