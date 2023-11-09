class ApiResponse{
  int? statusCode;
  bool success;
  String message;
  dynamic data;
  ApiResponse({
    this.statusCode,
    required this.success,
    required this.message,
    this.data
  });
}