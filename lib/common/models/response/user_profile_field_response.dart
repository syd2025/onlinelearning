import 'package:json_annotation/json_annotation.dart';
import 'package:onlinelearning/common/index.dart';

part 'user_profile_field_response.g.dart';

@JsonSerializable()
class UserProfileFieldResponse extends BaseResponse {
  @JsonKey(name: 'result')
  UserProfileFieldModel? result;

  UserProfileFieldResponse({
    this.result,
    super.message,
    required super.code,
  });

  factory UserProfileFieldResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFieldResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileFieldResponseToJson(this);
}
