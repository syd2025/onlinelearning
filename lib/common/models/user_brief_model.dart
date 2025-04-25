import 'package:json_annotation/json_annotation.dart';

part 'user_brief_model.g.dart';

@JsonSerializable()
class UserBriefModel {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'gender')
  String? gender;
  @JsonKey(name: 'avatar')
  String? avatar;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'purchasing_courses')
  List<int>? purchasingCourses;
  @JsonKey(name: 'purchased_courses')
  List<int>? purchasedCourses;

  UserBriefModel(
      {this.id,
      this.type,
      this.name,
      this.gender,
      this.avatar,
      this.createdAt,
      this.purchasingCourses,
      this.purchasedCourses});

  factory UserBriefModel.fromJson(Map<String, dynamic> json) =>
      _$UserBriefModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserBriefModelToJson(this);

  UserBriefModel copyWith({
    String? type,
    String? name,
    String? gender,
    String? avatar,
    DateTime? createdAt,
    int? learnedMinutes,
    List<int>? purchasingCourses,
    List<int>? purchasedCourses,
  }) {
    return UserBriefModel(
      id: id,
      type: type ?? this.type,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      purchasingCourses: purchasingCourses ?? this.purchasingCourses,
      purchasedCourses: purchasedCourses ?? this.purchasedCourses,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserBriefModel &&
        other.id == id &&
        other.type == type &&
        other.name == name &&
        other.gender == gender &&
        other.avatar == avatar &&
        other.createdAt == createdAt &&
        other.purchasingCourses == purchasingCourses &&
        other.purchasedCourses == purchasedCourses;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      type.hashCode ^
      name.hashCode ^
      gender.hashCode ^
      avatar.hashCode ^
      createdAt.hashCode ^
      purchasingCourses.hashCode ^
      purchasedCourses.hashCode;

  bool get isTeacher => type == 'teacher';
  bool get isAdmin => type == 'admin';
}
