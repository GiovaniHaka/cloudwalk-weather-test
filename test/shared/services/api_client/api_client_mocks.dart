import 'package:cloudwalk/shared/services/api_client/api_client_service.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockApiClientService extends Mock implements ApiClientService {}

class MockResponse extends Mock implements Response {}
