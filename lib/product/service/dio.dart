import 'package:dio/dio.dart';

/// Dio connfig
Dio dio() {
  const baseUrl = 'http://165.232.75.224:8080/api/';
  final dio = Dio();
  // dio.options.baseUrl = baseUrl;
  dio.options.connectTimeout = const Duration(seconds: 60);
  dio.options.contentType = Headers.jsonContentType;

  /*
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: false,
        responseHeader: false,
        error: true,
        compact: false,
        maxWidth: 250));
  */

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // final token = await storage.read(key: 'token');
        const token =
            'eyJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE3MTc0MjgyNDg1OTcsImV4cCI6MTcxNzQ3MTQ0ODU5Nywic3ViIjoic3VuZ3VyIiwiZmlyc3ROYW1lIjoic3VuZ3VyIiwibGFzdE5hbWUiOiJzdW5ndXIiLCJlbWFpbCI6InN1bmd1ckBnbWFpbC5jb20ifQ.dCIrBhYICJ-Yvb2x4gA1Quh9A0o5IUW8M_CwRoUEaTJvqCjZk_-ySHLqsUV3RwQTiKz0so6x7CEos761I2DMgg';

        if (token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        return handler.next(options); //continue
      },
      onResponse: (response, handler) {
        return handler.next(response); // continue
      },
    ),
  );

  return dio;
}
