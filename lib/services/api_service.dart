import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.14:8000/api/';

  final Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(minutes: 2),
    receiveTimeout: const Duration(minutes: 2),
  ));

  void removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  Future<String> recoveryToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw ('No existe un token');
      }

      return token;
    } catch (error) {
      rethrow;
    }
  }

  void saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  Future<Options> getTokenAuthorization() async {
    String? token = await recoveryToken();
    return Options(headers: {"Authorization": "Bearer $token"});
  }

  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParams, Options? options}) async {
    try {
      final response = await dio.get(endpoint,
          options: options, queryParameters: queryParams);
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        // Handle known errors
        throw e.response?.data;
      } else {
        // Handle unknown errors
        throw 'Ha ocurrido un error inesperado';
      }
    }
  }

  Future<Response> post(String endpoint,
      {required Map<String, dynamic> data, Options? options}) async {
    try {
      final response = await dio.post(endpoint, data: data, options: options);
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        // Handle known errors
        throw e.response?.data;
      } else {
        // Handle unknown errors
        throw 'Ha ocurrido un error inesperado';
      }
    }
  }

  Future<Response> put(String endpoint,
      {required Map<String, dynamic> data, Options? options}) async {
    try {
      final response = await dio.put(endpoint, data: data, options: options);
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        // Handle known errors
        throw e.response?.data;
      } else {
        // Handle unknown errors
        throw 'Ha ocurrido un error inesperado';
      }
    }
  }

  Future<Response> delete(String endpoint, {Options? options}) async {
    try {
      final response = await dio.delete(endpoint, options: options);
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        // Handle known errors
        throw e.response?.data;
      } else {
        // Handle unknown errors
        throw 'Ha ocurrido un error inesperado';
      }
    }
  }
}
