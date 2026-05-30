import 'package:app/app/core/errors/email_not_confirmed_exception.dart';
import 'package:app/app/routes/routes.dart';
import 'package:get/get.dart';
import '../../core/values/strings.dart';
import 'repository.dart';

class SigninController extends GetxController {
  final SigninRepository repository;
  SigninController({required this.repository});

  final obscurePassword = true.obs;
  final isLoading = false.obs;

  // Field values
  final email = ''.obs;
  final password = ''.obs;

  // Error messages
  final emailError = RxnString();
  final passwordError = RxnString();

  void togglePasswordVisibility() =>
      obscurePassword.value = !obscurePassword.value;

  bool validate() {
    bool isValid = true;

    if (email.value.isEmpty) {
      emailError.value = AppStrings.fieldRequired;
      isValid = false;
    } else {
      emailError.value = null;
    }

    if (password.value.isEmpty) {
      passwordError.value = AppStrings.fieldRequired;
      isValid = false;
    } else if (password.value.length < 8) {
      passwordError.value = AppStrings.passwordLengthError;
      isValid = false;
    } else {
      passwordError.value = null;
    }

    return isValid;
  }

  Future<void> signIn() async {
    if (validate()) {
      isLoading.value = true;
      try {
        await repository.signIn(email: email.value, password: password.value);
        Get.offAllNamed(AppRoutes.home);
      } on EmailNotConfirmedException {
        Get.offNamed(AppRoutes.verify, arguments: email.value);
      } catch (e) {
        Get.snackbar(
          AppStrings.error,
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> signup() async {
    Get.offAllNamed(AppRoutes.signup);
  }
}
