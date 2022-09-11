import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio
      ..options.baseUrl = 'http://10.0.2.2:8080/'
      ..options.connectTimeout = 15000
      ..options.receiveTimeout = 15000
      ..options.responseType = ResponseType.json;
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
    String url, {
    dynamic data,
  }) async {
    try {
      final Response response = await _dio.post(url, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> downloadFile(
    String url,
    String path, {
    ProgressCallback? onReceiveProgress,
  }) async {
    await _dio.download(
      url,
      (Headers header) {
        final fileName = header.value('content-disposition')?.split('=').last.replaceAll('"', '');
        return '$path/${fileName ?? 'download.pdf'}';
      },
      onReceiveProgress: onReceiveProgress,
    );
  }
}
