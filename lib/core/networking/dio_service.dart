import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../api/api_constants.dart';
import '../local_data/caching_helper.dart';

/// Singleton service class wrapping [Dio] for advanced networking operations.
class DioService {
  DioService._() {
    _dio = Dio();
    final BaseOptions baseOptions = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    _dio.options = baseOptions;

    // Logging Interceptor for debug mode
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: false,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }

    // Interceptor for handling token and authentication errors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, ErrorInterceptorHandler handler) async {
          final status = e.response?.statusCode;
          if (status == 401 || status == 404) {
            await AppCacheHelper.deleteSecureCache(key: AppCacheHelper.accessTokenKey);
            await AppCacheHelper.deleteSecureCache(key: AppCacheHelper.userUuid);
            await AppCacheHelper.deleteSecureCache(key: AppCacheHelper.refreshTokenKey);
            return handler.reject(e);
          }
          return handler.next(e);
        },
      ),
    );
  }

  static DioService? _instance;
  late Dio _dio;

  /// Singleton instance getter
  static DioService get instance {
    _instance ??= DioService._();
    return _instance!;
  }

  /// Underlying Dio instance
  static Dio get dio => instance._dio;

  /// Generates headers with optional authentication token
  Future<Map<String, String>> getHeaders({bool withToken = true}) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    final token = await AppCacheHelper.getSecureString(key: AppCacheHelper.accessTokenKey);
    if (withToken && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  /// Centralized request dispatcher for standard HTTP operations
  Future<Response> sendRequest({
    required String method,
    required String path,
    dynamic data,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParams,
        options: Options(
          method: method,
          headers: headers ?? _dio.options.headers,
        ),
      );
      return response;
    } on DioException {
      rethrow;
    }
  }
}
