import 'package:json_annotation/json_annotation.dart';
import 'package:onlinelearning/common/index.dart';

part 'course_review_list_response.g.dart';

@JsonSerializable()
class CourseReviewListResponse extends BaseResponse {
  @JsonKey(name: 'my_review')
  CourseReviewModel? myReview;

  @JsonKey(name: 'reviews')
  List<CourseReviewModel>? reviews;
  @JsonKey(name: 'page_meta')
  PageMetaModel? pageMeta;

  CourseReviewListResponse({
    required super.code,
    super.message,
    this.myReview,
    this.reviews,
    this.pageMeta,
  });

  factory CourseReviewListResponse.fromJson(Map<String, dynamic> json) =>
      _$CourseReviewListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseReviewListResponseToJson(this);
}
