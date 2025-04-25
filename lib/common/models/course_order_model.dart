import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:onlinelearning/common/index.dart';

part 'course_order_model.g.dart';

@JsonSerializable()
class CourseOrderModel extends CourseBriefModel {
  @JsonKey(name: 'order_at')
  DateTime orderAt;

  CourseOrderModel({
    required super.id,
    required super.title,
    required super.image,
    required super.videoCount,
    required super.duration,
    required super.level,
    required super.price,
    required super.author,
    required super.authorId,
    required super.studentCount,
    required this.orderAt,
  });

  factory CourseOrderModel.fromJson(Map<String, dynamic> json) =>
      _$CourseOrderModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CourseOrderModelToJson(this);

  String get orderAtString {
    final format = DateFormat('yyyy-MM-dd HH:mm:ss');
    return format.format(orderAt);
  }
}
