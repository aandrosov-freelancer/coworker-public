import 'package:app/app/routes/routes.dart';
import 'package:get/get.dart';
import '../../core/values/strings.dart';
import 'repository.dart';

class VerifyController extends GetxController {
  final VerifyRepository repository;
  VerifyController({required this.repository});

  late final String email;

  @override
  void onInit() {
    super.onInit();
    final argsEmail = Get.arguments as String?;

    email = argsEmail ?? '';

    if (email.isEmpty) {
      Get.log('VerifyController: email is missing');
    }
  }

  final code = ''.obs;
  final errorText = RxnString();
  final showSuccessBanner = false.obs;
  final isVerified = false.obs;
  final isLoading = false.obs;

  void onCodeChanged(String value) {
    code.value = value;
    if (errorText.value != null) {
      errorText.value = null;
    }
    // Automatically verify if code length is 6
    if (value.length == 6 && !isLoading.value) {
      onContinue();
    }
  }

  Future<void> onContinue() async {
    if (isVerified.value || isLoading.value) {
      if (isVerified.value) onGoToDashboard();
      return;
    }

    if (code.value.length == 6) {
      isLoading.value = true;
      errorText.value = null;
      showSuccessBanner.value = false;

      try {
        await repository.verifyOTP(email: email, token: code.value);
        errorText.value = null;
        isVerified.value = true;
      } catch (e) {
        errorText.value = e.toString().contains('invalid')
            ? AppStrings.invalidCode
            : e.toString();
      } finally {
        isLoading.value = false;
      }
    }
  }

  void onGoToDashboard() {
    Get.offAllNamed(AppRoutes.home);
  }

  Future<void> onResendCode() async {
    errorText.value = null;
    isLoading.value = true;
    try {
      await repository.resendOTP(email: email);
      showSuccessBanner.value = true;

      // Auto-hide success banner after some time
      Future.delayed(const Duration(seconds: 5), () {
        showSuccessBanner.value = false;
      });
    } catch (e) {
      Get.snackbar(AppStrings.error, e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
