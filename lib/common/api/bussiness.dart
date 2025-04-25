import 'package:dio/dio.dart';
import 'package:onlinelearning/common/index.dart';

class BusinessApi {
  // 课程列表
  static Future<CourseReviewListResponse> getCourseReviews({
    required int courseId,
    bool fetchMyReview = false,
    int? page,
    int? pageSize,
    CancelToken? cancelToken,
  }) async {
    final res = await WPHttpService.to.get(
      "/v1/course/reviews",
      params: {
        'course_id': courseId,
        'fetch_my_review': fetchMyReview,
        'page': page,
        'page_size': pageSize,
      },
      cancelToken: cancelToken,
    );
    return CourseReviewListResponse.fromJson(res.data);
  }

  // 回复课程评论
  static Future<SimpleResponse> replyCourseReview(
    int courseId,
    int reviewId,
    String content,
  ) async {
    final res = await WPHttpService.to.post(
      "/v1/course/review/reply",
      data: {
        'course_id': courseId,
        'review_id': reviewId,
        'content': content,
      },
    );
    return SimpleResponse.fromJson(res.data);
  }

  // 提交课程评论
  static Future<MyReviewResponse> reviewCourse(
    int courseId,
    int rating,
    String content,
  ) async {
    final res = await WPHttpService.to.post(
      "/v1/course/review",
      data: {
        'course_id': courseId,
        'rating': rating,
        'content': content,
      },
    );
    return MyReviewResponse.fromJson(res.data);
  }

  static Future<SimpleResponse> addFavoriteCourse(int courseId) async {
    final res = await WPHttpService.to.post(
      "/v1/course/favorite",
      data: {
        'course_id': courseId,
      },
    );
    return SimpleResponse.fromJson(res.data);
  }

  static Future<SimpleResponse> removeFavoriteCourse(int courseId) async {
    final res = await WPHttpService.to.delete(
      "/v1/course/favorite",
      data: {
        'course_id': courseId,
      },
    );
    return SimpleResponse.fromJson(res.data);
  }

  static Future<SimpleResponse> addCourseToShoppingCart(
      int courseId, double price) async {
    final res = await WPHttpService.to.post(
      "/v1/course/shopping_cart",
      data: {
        'course_id': courseId,
        'price': price,
      },
    );
    return SimpleResponse.fromJson(res.data);
  }

  static Future<PurchaseCourseResponse> removeCourseFromShoppingCart(
      List<int> couseIdArray) async {
    final res = await WPHttpService.to.delete(
      "/v1/course/shopping_cart",
      data: {
        'courseid_array': couseIdArray,
      },
    );
    return PurchaseCourseResponse.fromJson(res.data);
  }

  static Future<PurchaseCourseResponse> purchaseCourses(
      List<int> couseIdArray) async {
    final res = await WPHttpService.to.post(
      "/v1/course/order",
      data: {
        'courseid_array': couseIdArray,
      },
    );
    return PurchaseCourseResponse.fromJson(res.data);
  }

  static Future<CourseOrderListResponse> getCourseOrders({
    required List<int> courseIds,
    CancelToken? cancelToken,
  }) async {
    final res = await WPHttpService.to.get(
      "/v1/course/orders",
      params: {
        'course_ids': courseIds,
      },
    );
    return CourseOrderListResponse.fromJson(res.data);
  }
}
