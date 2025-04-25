import 'package:json_annotation/json_annotation.dart';
import 'package:onlinelearning/common/index.dart';

part 'user_profile_response.g.dart';

@JsonSerializable()
class UserProfileResponse extends BaseResponse {
  @JsonKey(name: 'profile')
  UserProfileModel? profile;

  UserProfileResponse({
    required super.code,
    this.profile,
    super.message,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileResponseToJson(this);
}
