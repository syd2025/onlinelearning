import 'package:json_annotation/json_annotation.dart';
import 'package:onlinelearning/common/index.dart';

part 'top_course_keys_response.g.dart';

@JsonSerializable()
class TopCourseKeysResponse extends BaseResponse {
  @JsonKey(name: 'keys')
  List<String>? keys;

  TopCourseKeysResponse({
    required super.code,
    super.message,
    this.keys,
  });

  factory TopCourseKeysResponse.fromJson(Map<String, dynamic> json) =>
      _$TopCourseKeysResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TopCourseKeysResponseToJson(this);
}
