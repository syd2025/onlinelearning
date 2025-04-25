import 'package:json_annotation/json_annotation.dart';

part 'page_meta_model.g.dart';

@JsonSerializable()
class PageMetaModel {
  @JsonKey(name: 'offset')
  int offset;
  @JsonKey(name: 'current_page')
  int currentPage;
  @JsonKey(name: 'page_size')
  int pageSize;
  @JsonKey(name: 'first_page')
  int firstPage;
  @JsonKey(name: 'last_page')
  int lastPage;
  @JsonKey(name: 'total_records')
  int totalCount;

  PageMetaModel({
    required this.offset,
    required this.currentPage,
    required this.pageSize,
    required this.firstPage,
    required this.lastPage,
    required this.totalCount,
  });

  factory PageMetaModel.fromJson(Map<String, dynamic> json) =>
      _$PageMetaModelFromJson(json);

  Map<String, dynamic> toJson() => _$PageMetaModelToJson(this);
}
