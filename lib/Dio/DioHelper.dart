import 'package:dio/dio.dart';

class DioHelper {
  static late Dio _dio;

  static void init() {

    _dio = Dio(
      BaseOptions(
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    return await _dio.get(
      url,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    Map<String, dynamic> defaultHeaders = {
      "Content-Type": "application/json",
    };

    if (headers != null) {
      defaultHeaders.addAll(headers);
    }

    return await _dio.post(
      url,
      data: data,
      options: Options(headers: defaultHeaders),
    );
  }

}
