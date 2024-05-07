import 'package:cloudwalk/shared/services/api_client/clients/dio_client_service_impl.dart';
import 'package:cloudwalk/shared/services/api_client/exceptions/api_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../api_client_mocks.dart';

void main() {
  late DioClientServiceImpl dioClientService;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();

    final fakeInterceptors = Interceptors();

    when(() => mockDio.interceptors).thenReturn(fakeInterceptors);

    dioClientService = DioClientServiceImpl(
      dio: mockDio,
    );
  });

  group('DioClientServiceImpl', () {
    test('should initialize Dio with interceptors', () {
      // Arrange
      final fakeInterceptors = Interceptors();

      when(() => mockDio.interceptors).thenReturn(fakeInterceptors);

      // Act
      dioClientService.initialize();
    });

    test('should make a GET request using Dio', () async {
      // Arrange
      const path = '/test';

      final response = Response(
        requestOptions: RequestOptions(path: path),
      );

      when(
        () => mockDio.get(
          path,
          queryParameters: any(named: 'queryParameters'),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) async => response);

      // Act
      final result = await dioClientService.get(path: path);

      // Assert
      expect(result, response);
    });

    test('should throw ApiException on DioException', () async {
      // Arrange
      const path = '/test';

      final exception = DioException(
        requestOptions: RequestOptions(path: path),
        response: Response(
          statusCode: 400,
          data: {
            'errorCode': '400',
            'message': 'Bad Request',
          },
          requestOptions: RequestOptions(path: path),
        ),
      );

      when(() => mockDio.get(
            path,
            queryParameters: any(named: 'queryParameters'),
            data: any(named: 'data'),
            options: any(named: 'options'),
          )).thenThrow(exception);

      var future = dioClientService.get(path: path);
      await expectLater(future, throwsA(isA<ApiException>()));
    });
  });
}
