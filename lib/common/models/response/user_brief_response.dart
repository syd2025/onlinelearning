import 'package:json_annotation/json_annotation.dart';
import 'package:onlinelearning/common/index.dart';

part 'user_brief_response.g.dart';

@JsonSerializable()
class UserBriefResponse extends BaseResponse {
  @JsonKey(name: "token")
  String? token;
  @JsonKey(name: "brief")
  UserBriefModel? brief;

  UserBriefResponse({
    required super.code,
    this.token,
    required this.brief,
    super.message,
  });

  factory UserBriefResponse.fromJson(Map<String, dynamic> json) =>
      _$UserBriefResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserBriefResponseToJson(this);
}
