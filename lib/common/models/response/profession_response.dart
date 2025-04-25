import 'package:json_annotation/json_annotation.dart';
import 'package:onlinelearning/common/index.dart';

part 'profession_response.g.dart';

@JsonSerializable()
class ProfessionResponse extends BaseResponse {
  @JsonKey(name: 'professions')
  List<ProfessionModel>? professions;

  ProfessionResponse({
    required super.code,
    super.message,
    this.professions,
  });

  factory ProfessionResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfessionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfessionResponseToJson(this);
}
