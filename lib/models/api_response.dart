// models/api_response.dart
// API javoblari uchun umumiy model

class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final String? error;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.error,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return ApiResponse(
      success: json['error'] == null,
      data: json['error'] == null && json.containsKey('data') ? fromJsonT(json['data']) : null,
      message: json['message'],
      error: json['error'],
    );
  }
}