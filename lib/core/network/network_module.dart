import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'dio_interceptor.dart';
import 'rest_client.dart';
import '../config/app_config.dart';

// class NetworkModule {
//   static void init() {
//     final dio = Dio(BaseOptions(
//       baseUrl: AppConfig.baseUrl,
//       connectTimeout: const Duration(seconds: 30),
//     ));

//     dio.interceptors.add(DioInterceptor());

//     Get.put<Dio>(dio, permanent: true);
//     Get.put<RestClient>(RestClient(dio), permanent: true);
//   }
  
// }

class NetworkModule {
  static void prepareDio() {
    Get.lazyPut<Dio>(() => Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
         headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        connectTimeout: const Duration(seconds: 30),
      ),
    ), fenix: true);

    Get.find<Dio>().interceptors.add(DioInterceptor());
    
    Get.lazyPut<RestClient>(
      () => RestClient(Get.find<Dio>()),
      fenix: true,
    );
  }
}