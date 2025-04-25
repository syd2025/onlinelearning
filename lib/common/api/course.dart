import 'package:dio/dio.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/common/models/response/course_category_response.dart';
import 'package:onlinelearning/common/models/response/top_course_keys_response.dart';

class CourseApi {
  /// 获取所有课程
  static Future<CourseCategoryResponse> getAllCategories() async {
    final res = await WPHttpService.to.get(
      "/v1/course/categories",
    );
    return CourseCategoryResponse.fromJson(res.data);
  }

  /// 获取top课程
  static Future<TopCourseKeysResponse> getTopCategories() async {
    final res = await WPHttpService.to.get(
      "/v1/course/topcoursekeys",
    );
    return TopCourseKeysResponse.fromJson(res.data);
  }

  /// 获取课程列表
  static Future<CourseListResponse> getCourseList({
    int? categoryId,
    int? page,
    int? pageSize,
    CancelToken? cancelToken,
  }) async {
    final res = await WPHttpService.to.get(
      "/v1/courses",
      params: {
        "category_id": categoryId,
        "page": page,
        "page_size": pageSize,
      },
      cancelToken: cancelToken,
    );
    return CourseListResponse.fromJson(res.data);
  }

  /// 搜索课程
  static Future<CourseListResponse> searchCourses({
    required String key,
    int? page,
    int? pageSize,
    CancelToken? cancelToken,
  }) async {
    final res = await WPHttpService.to.get(
      "/v1/course/search",
      params: {
        "key": key,
        "page": page,
        "page_size": pageSize,
      },
      cancelToken: cancelToken,
    );
    return CourseListResponse.fromJson(res.data);
  }

  /// 获取热门搜索关键词
  static Future<TopCourseKeysResponse> getTopCourseKeys() async {
    final res = await WPHttpService.to.get(
      "/v1/course/topcoursekeys",
    );
    return TopCourseKeysResponse.fromJson(res.data);
  }

  /// 获取课程详情
  static Future<CourseDetailResponse> getCourseDetail(int courseId) async {
    final res = await WPHttpService.to.get("/v1/course", params: {
      "course_id": courseId,
    });
    return CourseDetailResponse.fromJson(res.data);
  }
}
