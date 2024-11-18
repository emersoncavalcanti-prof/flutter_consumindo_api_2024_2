import 'package:dio/dio.dart';

abstract interface class HttpClient {
  Future get({required url, Map<String, dynamic>? headers});
  Future post(
      {required url,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? data});
}

class DioClient implements HttpClient {
  final Dio client;

  DioClient(this.client);

  @override
  Future get({required url, Map<String, dynamic>? headers}) async {
    return await client.get(url, options: Options(headers: headers));
  }

  @override
  Future post(
      {required url,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? data}) async {
    return await client.post(url,
        data: data, options: Options(headers: headers));
  }
}
