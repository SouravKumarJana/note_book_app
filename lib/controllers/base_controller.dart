import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  final isLoading = false.obs;
  final errorMessage = RxnString();

  Future<T?> callApi<T>(
    Future<T> future,
  ) async {
    try {
      isLoading.value = true;
      clearError();

      final response = await future;

      return response;
    } catch (e) {
      setError(e.toString());
      Get.snackbar("Error", e.toString());
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  void setError(String message) => errorMessage.value = message;

  void clearError() => errorMessage.value = null;
}
