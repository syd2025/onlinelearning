class BaseResponse {
  int code;
  String? message;

  BaseResponse({
    required this.code,
    this.message,
  });
}
