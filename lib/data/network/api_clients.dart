// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ApiClient {
//   Future<Map<String, dynamic>> post(
//     String url,
//     Map<String, dynamic> body,
//   ) async {
//     final response = await http.post(
//       Uri.parse(url),
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//       },
//       body: jsonEncode(body),
//     );

//     if (response.statusCode >= 200 && response.statusCode < 300) {
//       return jsonDecode(response.body);
//     } else {
//       // ReqRes returns JSON error even for failures
//       final error = jsonDecode(response.body);
//       throw Exception(error['error'] ?? 'Something went wrong');
//     }
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter_login/data/network/api_end_points.dart';
import 'dart:developer';

class ApiClient {
  final Dio _dio;

  ApiClient({Dio? dio}) : _dio = dio ?? Dio() {
    _dio.options.baseUrl = ApiEndPoints.localUrl;
    _dio.options.headers = {'Content-Type': 'application/json'};
    _dio.options.connectTimeout = const Duration(seconds: 100);
    _dio.options.receiveTimeout = const Duration(seconds: 100);

    _dio.interceptors.add(DioLoggerInterceptor());
  }

  Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _dio.post(
        path,
        data:
            body, // Dio automatically encodes JSON if headers are application/json
      );

      // Successful response (2xx)
      return response.data; // Already a Map<String, dynamic>
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        // Server returned an error response
        final errorData = e.response!.data;
        throw Exception(errorData['error'] ?? 'Something went wrong');
      } else {
        // Network error, timeout, cancellation, etc.
        throw Exception(e.message);
      }
    } catch (e) {
      // Other errors
      throw Exception('Unexpected error: $e');
    }
  }
}

class DioLoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('➡️ REQUEST');
    log('METHOD: ${options.method}');
    log('URL: ${options.baseUrl}${options.path}');
    log('HEADERS: ${options.headers}');
    log('BODY: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('✅ RESPONSE');
    log(
      'URL: ${response.requestOptions.baseUrl}${response.requestOptions.path}',
    );
    log('STATUS CODE: ${response.statusCode}');
    log('DATA: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('❌ ERROR');
    log('URL: ${err.requestOptions.baseUrl}${err.requestOptions.path}');
    log('STATUS CODE: ${err.response?.statusCode}');
    log('ERROR DATA: ${err.response?.data}');
    super.onError(err, handler);
  }
}
