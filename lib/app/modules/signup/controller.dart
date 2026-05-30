import 'package:app/app/routes/routes.dart';
import 'package:get/get.dart';

import '../../core/values/strings.dart';
import 'enums/account_type.dart';
import 'repository.dart';

class SignupController extends GetxController {
  SignupController({required this.repository});

  final SignupRepository repository;

  final accountType = AccountType.customer.obs;
  final obscurePassword = true.obs;
  final agreeToTerms = false.obs;
  final isLoading = false.obs;
  final isSuccess = false.obs;

  // Field values
  final firstName = ''.obs;
  final lastName = ''.obs;
  final email = ''.obs;
  final password = ''.obs;

  // Error messages
  final firstNameError = RxnString();
  final lastNameError = RxnString();
  final emailError = RxnString();
  final passwordError = RxnString();
  final termsError = RxnString();

  void togglePasswordVisibility() =>
      obscurePassword.value = !obscurePassword.value;
  void setAccountType(AccountType type) => accountType.value = type;
  void setAgreeToTerms(bool? value) {
    agreeToTerms.value = value ?? false;
    if (agreeToTerms.value) termsError.value = null;
  }

  bool validate() {
    bool isValid = true;

    if (firstName.value.isEmpty) {
      firstNameError.value = AppStrings.fieldRequired;
      isValid = false;
    } else {
      firstNameError.value = null;
    }

    if (lastName.value.isEmpty) {
      lastNameError.value = AppStrings.fieldRequired;
      isValid = false;
    } else {
      lastNameError.value = null;
    }

    if (email.value.isEmpty) {
      emailError.value = AppStrings.fieldRequired;
      isValid = false;
    } else {
      emailError.value = null;
    }

    if (password.value.isEmpty) {
      passwordError.value = AppStrings.fieldRequired;
      isValid = false;
    } else {
      passwordError.value = null;
    }

    if (password.value.length < 8) {
      passwordError.value = AppStrings.passwordLengthError;
      isValid = false;
    } else {
      passwordError.value = null;
    }

    if (!agreeToTerms.value) {
      termsError.value = AppStrings.consentRequired;
      isValid = false;
    } else {
      termsError.value = null;
    }

    return isValid;
  }

  Future<void> signup() async {
    if (validate()) {
      isLoading.value = true;
      try {
        await repository.signUp(
          email: email.value.trim(),
          password: password.value,
          firstName: firstName.value.trim(),
          lastName: lastName.value.trim(),
          accountType: accountType.value,
        );

        isSuccess.value = true;
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

  Future<void> signin() async {
    Get.offAllNamed(AppRoutes.signin);
  }
}
