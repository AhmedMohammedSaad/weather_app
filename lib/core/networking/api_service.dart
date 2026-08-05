import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../api/api_consumer.dart';
import '../errors/error_handler.dart';
import '../errors/failure.dart';
import 'dio_service.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/app_strings.dart';

/// AppDio / ApiService providing clean HTTP methods delegating to [DioService].
/// Implements [ApiConsumer] interface for Clean Architecture compliance.
class ApiService implements ApiConsumer {
  // Create (POST)
  @override
  Future<dynamic> post(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await DioService.instance.sendRequest(
        method: 'POST',
        path: path,
        data: body,
        queryParams: queryParameters,
        headers: headers ?? await DioService.instance.getHeaders(),
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // Read (GET)
  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await DioService.instance.sendRequest(
        method: 'GET',
        path: path,
        queryParams: queryParameters,
        headers: headers ?? await DioService.instance.getHeaders(),
      );
      return response.data;
    } on DioException catch (e) {
      if (kDebugMode) {
        debugPrint('GET Request Error: ${e.toString()}');
      }
      throw _handleDioError(e);
    }
  }

  // Update (PUT)
  @override
  Future<dynamic> put(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await DioService.instance.sendRequest(
        method: 'PUT',
        path: path,
        data: body,
        queryParams: queryParameters,
        headers: headers ?? await DioService.instance.getHeaders(),
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // Delete (DELETE)
  @override
  Future<dynamic> delete(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await DioService.instance.sendRequest(
        method: 'DELETE',
        path: path,
        data: body,
        queryParams: queryParameters,
        headers: headers ?? await DioService.instance.getHeaders(),
      );
      return response.data;
    } on DioException catch (e) {
      if (kDebugMode) {
        debugPrint('DELETE Request Error: ${e.response?.data}');
      }
      throw _handleDioError(e);
    }
  }

  // Patch (PATCH)
  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await DioService.instance.sendRequest(
        method: 'PATCH',
        path: path,
        data: data,
        headers: headers ?? await DioService.instance.getHeaders(),
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Maps [DioException] into [ErrorHandler] exception with friendly [Failure].
  ErrorHandler _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return ErrorHandler(
          NetworkFailure(message: AppStrings.noInternetConnection.tr()),
        );
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 400 || statusCode == 404) {
          return ErrorHandler(
            InvalidCityFailure(
              message: AppStrings.cityNotFound.tr(),
            ),
          );
        }
        return ErrorHandler(
          ServerFailure(
            message: error.response?.statusMessage ?? AppStrings.serverError.tr(),
            statusCode: statusCode,
          ),
        );
      case DioExceptionType.cancel:
        return ErrorHandler(
          UnknownFailure(message: AppStrings.requestCancelled.tr()),
        );
      default:
        return ErrorHandler(
          NetworkFailure(message: AppStrings.networkErrorOccurred.tr()),
        );
    }
  }
}
