class ApiEndpoints {
  ApiEndpoints._();
  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:5000/api/";
  // static const String baseUrl = "http://192.168.68.55:5000/api/";
  // For iPhone
  // static const String baseUrl = "http://localhost:5000/api/v1/";

  //========================Auth========================//
  static const String login = "user/login";
  static const String register = "user/register";
  static const String uploadImage = "user/uploadImage";
}
