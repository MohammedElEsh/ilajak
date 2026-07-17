import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_consumer.dart';
import 'api_endpoints.dart';
import 'api_interceptors.dart';

/// Concrete [ApiConsumer] backed by Dio.
///
/// Responsibilities:
/// - Configure base URL and timeouts.
/// - Register [ApiInterceptors] (auth + 401 recovery) and [PrettyDioLogger].
/// - Delegate HTTP verbs to Dio and return the parsed response body.
class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer(this.dio, {required ApiInterceptors apiInterceptors}) {
    dio.options.baseUrl = ApiEndpoints.baseUrl.trim();
    dio.interceptors.addAll([
      apiInterceptors,
      if (const bool.fromEnvironment('dart.vm.product') == false)
        PrettyDioLogger(
          request: true,
          requestBody: false,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
    ]);
  }

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
  }) async {
    final response = await dio.get<dynamic>(
      path,
      queryParameters: queryParameters,
      data: isFormData ? FormData.fromMap(data as Map<String, dynamic>) : data,
    );
    return response.data;
  }

  @override
  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
  }) async {
    final response = await dio.post<dynamic>(
      path,
      queryParameters: queryParameters,
      data: isFormData ? FormData.fromMap(data as Map<String, dynamic>) : data,
    );
    return response.data;
  }

  @override
  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
  }) async {
    final response = await dio.put<dynamic>(
      path,
      queryParameters: queryParameters,
      data: isFormData ? FormData.fromMap(data as Map<String, dynamic>) : data,
    );
    return response.data;
  }

  @override
  Future<dynamic> patch(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
  }) async {
    final response = await dio.patch<dynamic>(
      path,
      queryParameters: queryParameters,
      data: isFormData ? FormData.fromMap(data as Map<String, dynamic>) : data,
    );
    return response.data;
  }

  @override
  Future<dynamic> delete(String path, {Object? data, bool isFormData = false}) async {
    final response = await dio.delete<dynamic>(
      path,
      data: isFormData && data != null
          ? FormData.fromMap(data as Map<String, dynamic>)
          : data,
    );
    return response.data;
  }
}
