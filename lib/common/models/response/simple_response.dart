import 'package:json_annotation/json_annotation.dart';
import 'package:onlinelearning/common/index.dart';

part 'simple_response.g.dart';

@JsonSerializable()
class SimpleResponse extends BaseResponse {
  SimpleResponse({
    required super.code,
    super.message,
  });

  factory SimpleResponse.fromJson(Map<String, dynamic> json) =>
      _$SimpleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleResponseToJson(this);
}
