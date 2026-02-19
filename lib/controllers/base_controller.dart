import 'package:get/get.dart';
import '../constants/app_string.dart';

abstract class BaseController extends GetxController {
  final isLoading = false.obs;
  final errorMessage = RxnString();

  Future<T?> noteExecutor<T>(
    Future<T> future,
  ) async {
    try {
      isLoading.value = true;
      clearError();

      final response = await future;

      return response;
    } catch (e) {
      setError(e.toString());
      Get.snackbar(AppStrings.error, e.toString());
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  void setError(String message) => errorMessage.value = message;

  void clearError() => errorMessage.value = null;
}
