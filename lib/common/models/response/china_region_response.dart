import 'package:json_annotation/json_annotation.dart';
import 'package:onlinelearning/common/index.dart';

part 'china_region_response.g.dart';

@JsonSerializable()
class ChinaRegionResponse extends BaseResponse {
  @JsonKey(name: 'regions')
  List<ChinaRegionModel>? regions;

  ChinaRegionResponse({
    required super.code,
    super.message,
    this.regions,
  });

  factory ChinaRegionResponse.fromJson(Map<String, dynamic> json) =>
      _$ChinaRegionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChinaRegionResponseToJson(this);
}
