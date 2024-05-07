import 'package:dio/dio.dart';

/// [ApiClientService] is an abstract class that defines the methods to be implemented by the API client.
abstract class ApiClientService {
  Future<Response> get({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  });
}
