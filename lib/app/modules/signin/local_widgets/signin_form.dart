import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';
import '../../signup/local_widgets/input_field.dart';
import '../controller.dart';

class SigninForm extends GetView<SigninController> {
  const SigninForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 80),
        Text(AppStrings.welcomeBack, style: context.textTheme.displayLarge),
        const SizedBox(height: 12),
        Text(AppStrings.loginToAccount, style: context.textTheme.bodyLarge),
        const SizedBox(height: 48),
        Obx(
          () => InputField(
            label: AppStrings.emailLabel,
            hint: AppStrings.emailHint,
            onChanged: (v) => controller.email.value = v,
            errorText: controller.emailError.value,
          ),
        ),
        const SizedBox(height: 24),
        Obx(
          () => InputField(
            label: AppStrings.password,
            hint: AppStrings.passwordFieldHint,
            isPassword: true,
            obscureText: controller.obscurePassword.value,
            onToggleVisibility: controller.togglePasswordVisibility,
            onChanged: (v) => controller.password.value = v,
            errorText: controller.passwordError.value,
          ),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text(
              AppStrings.forgotPassword,
              style: TextStyle(
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: Obx(
            () => ElevatedButton(
              onPressed: controller.isLoading.value ? null : controller.signIn,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: AppColors.white,
                disabledBackgroundColor: AppColors.primaryGreen.withValues(
                  alpha: 0.7,
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 1,
              ),
              child: controller.isLoading.value
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.white,
                        ),
                      ),
                    )
                  : const Text(
                      AppStrings.signIn,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        Center(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.bodyText,
                fontFamily: 'Inter',
              ),
              children: [
                const TextSpan(text: AppStrings.dontHaveAccountPart1),
                TextSpan(
                  text: AppStrings.dontHaveAccountPart2,
                  style: const TextStyle(
                    color: AppColors.primaryGreen,
                    fontWeight: FontWeight.w600,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = controller.signup,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}
