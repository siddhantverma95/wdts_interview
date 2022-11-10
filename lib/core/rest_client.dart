import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'custom_exception.dart';

class RestClient {
  RestClient() {
    final options = BaseOptions(
      baseUrl: '',
      connectTimeout: 60000,
      receiveTimeout: 60000,
    );
    _dio = Dio(options);
  }

  late Dio _dio;

  Future<dynamic> get(
    String path, [
    Map<String, dynamic>? data,
  ]) async {
    return _dio
        .get<dynamic>(
          path,
          queryParameters: data,
        )
        .then((value) => value)
        .catchError(_getDioException);
  }

  FutureOr<Response<dynamic>> _getDioException(dynamic error) {
    debugPrint('DIO EXCEPT: ${error.runtimeType}');
    if (error is DioError) {
      debugPrint('DIO ERROR: ${error.type}');
      switch (error.type) {
        case DioErrorType.cancel:
          throw RequestCancelledException(
            0001,
            'Something went wrong. Please try again.',
          );
        case DioErrorType.connectTimeout:
          throw RequestTimeoutException(
            408,
            'Could not connect to the server.',
          );
        case DioErrorType.other:
          throw DefaultException(
            0002,
            'Something went wrong. Please try again.',
          );
        case DioErrorType.receiveTimeout:
          throw ReceiveTimeoutException(
            0004,
            'Could not connect to the server.',
          );
        case DioErrorType.sendTimeout:
          throw RequestTimeoutException(
            408,
            'Could not connect to the server.',
          );
        case DioErrorType.response:
          switch (error.response?.statusCode) {
            case 400:
            case 403:
              throw UnauthorisedException(
                error.response?.statusCode ?? 400,
                '${error.response?.data}',
              );
            case 401:
              throw UnauthorisedException(
                error.response?.statusCode ?? 400,
                '${error.response?.data}',
              );
            case 404:
              throw NotFoundException(404, error.response?.data.toString());
            case 409:
              throw ConflictException(
                409,
                'Something went wrong. Please try again.',
              );
            case 408:
              throw RequestTimeoutException(
                408,
                'Could not connect to the server.',
              );
            case 500:
              throw InternalServerException(
                500,
                'Something went wrong. Please try again.',
              );
            default:
              throw DefaultException(
                0002,
                'Something went wrong. Please try again.',
              );
          }
      }
    } else {
      throw UnexpectedException(000, 'Something went wrong. Please try again.');
    }
  }
}

abstract class ApiOptions {
  Options options = Options();
}

// Public API options need to be sent with public
class PublicApiOptions extends ApiOptions {
  PublicApiOptions() {
    super.options.headers = <String, dynamic>{
      'Accept': 'application/json',
    };
  }
}
