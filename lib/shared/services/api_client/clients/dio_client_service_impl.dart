import 'package:cloudwalk/shared/services/api_client/api_client_service.dart';
import 'package:cloudwalk/shared/services/api_client/exceptions/api_exception.dart';
import 'package:dio/dio.dart';

/// [DioClientServiceImpl] is a service that implements [ApiClientService] using Dio package.
class DioClientServiceImpl implements ApiClientService {
  final Dio _dio;

  DioClientServiceImpl({
    required Dio dio,
  }) : _dio = dio {
    initialize();
  }

  initialize() {
    _dio.interceptors.add(
      LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
      ),
    );
  }

  @override
  Future<Response> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        data: data,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
    } on DioException catch (e) {
      final code = e.response?.statusCode;
      final errorCode = e.response?.data['errorCode'];

      throw ApiException(
        code: code,
        errorCode: errorCode,
      );
    }
  }
}
