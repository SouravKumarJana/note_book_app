import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("Dio Error: ${err.message}");
    super.onError(err, handler);
  }
}
