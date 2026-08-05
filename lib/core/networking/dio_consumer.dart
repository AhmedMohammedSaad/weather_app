import 'package:dio/dio.dart';
import '../api/api_consumer.dart';
import '../errors/error_handler.dart';
import '../errors/failure.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/app_strings.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options
      ..connectTimeout = const Duration(seconds: 15)
      ..receiveTimeout = const Duration(seconds: 15)
      ..responseType = ResponseType.json;
  }

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<dynamic> put(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<dynamic> delete(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  ErrorHandler _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return ErrorHandler(
          NetworkFailure(message: AppStrings.connectionTimeout.tr()),
        );
      case DioExceptionType.badResponse:
        String errorMessage = error.response?.statusMessage ?? AppStrings.serverError.tr();
        final responseData = error.response?.data;
        if (responseData != null && responseData is Map<String, dynamic>) {
          if (responseData['error'] != null && responseData['error']['message'] != null) {
            errorMessage = responseData['error']['message'].toString();
          } else if (responseData['message'] != null) {
            errorMessage = responseData['message'].toString();
          }
        }
        return ErrorHandler(
          ServerFailure(
            message: errorMessage,
            statusCode: error.response?.statusCode,
          ),
        );
      case DioExceptionType.cancel:
        return ErrorHandler(
          UnknownFailure(message: AppStrings.requestCancelled.tr()),
        );
      default:
        return ErrorHandler(
          UnknownFailure(message: AppStrings.unexpectedNetworkError.tr()),
        );
    }
  }
}
