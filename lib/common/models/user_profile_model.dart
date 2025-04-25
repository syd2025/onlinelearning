import 'package:json_annotation/json_annotation.dart';
import 'package:onlinelearning/common/index.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel extends UserBriefModel {
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'phone_number')
  String? phoneNumber;
  @JsonKey(name: 'wechat_id')
  String? wechatId;
  @JsonKey(name: 'region')
  String? region;
  @JsonKey(name: 'region_code_array')
  List<String>? regionCodeList;

  @JsonKey(name: 'introduction')
  String? introduction;
  @JsonKey(name: 'profession')
  String? profession;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  UserProfileModel({
    super.id,
    super.type,
    super.name,
    super.gender,
    super.avatar,
    super.createdAt,
    super.purchasingCourses = const [],
    super.purchasedCourses = const [],
    this.email,
    this.phoneNumber,
    this.wechatId,
    this.region,
    this.regionCodeList,
    this.introduction,
    this.profession,
    this.updatedAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);

  @override
  UserProfileModel copyWith({
    String? type,
    String? name,
    String? gender,
    String? avatar,
    DateTime? createdAt,
    int? learnedMinutes,
    List<int>? purchasingCourses,
    List<int>? purchasedCourses,
    String? email,
    String? phoneNumber,
    String? wechatId,
    String? region,
    List<String>? regionCodeList,
    String? introduction,
    String? profession,
    DateTime? updatedAt,
    int? version,
  }) {
    return UserProfileModel(
      id: id,
      type: type ?? this.type,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      purchasingCourses: purchasingCourses ?? this.purchasingCourses,
      purchasedCourses: purchasedCourses ?? this.purchasedCourses,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      wechatId: wechatId ?? this.wechatId,
      region: region ?? this.region,
      regionCodeList: regionCodeList ?? this.regionCodeList,
      introduction: introduction ?? this.introduction,
      profession: profession ?? this.profession,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserProfileModel &&
        other.id == id &&
        other.type == type &&
        other.name == name &&
        other.gender == gender &&
        other.avatar == avatar &&
        other.createdAt == createdAt &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.wechatId == wechatId &&
        other.region == region &&
        other.regionCodeList == regionCodeList &&
        other.introduction == introduction &&
        other.profession == profession &&
        other.updatedAt == updatedAt &&
        other.purchasingCourses == purchasingCourses &&
        other.purchasedCourses == purchasedCourses;
  }

  @override
  int get hashCode =>
      super.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      wechatId.hashCode ^
      region.hashCode ^
      regionCodeList.hashCode ^
      introduction.hashCode ^
      profession.hashCode ^
      updatedAt.hashCode;

  UserBriefModel getUserBrief() {
    return UserBriefModel(
      id: id,
      type: type,
      name: name,
      gender: gender,
      avatar: avatar,
      createdAt: createdAt,
      purchasingCourses: purchasingCourses,
      purchasedCourses: purchasedCourses,
    );
  }
}
