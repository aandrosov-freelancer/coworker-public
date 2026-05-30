import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animations/animations.dart';
import 'package:get/get.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';
import '../controller.dart';
import 'account_type_selector.dart';
import 'input_field.dart';
import 'success_view.dart';

class SignupForm extends GetView<SignupController> {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PageTransitionSwitcher(
        duration: 400.ms,
        transitionBuilder: (child, animation, secondaryAnimation) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: .scaled,
            fillColor: Colors.transparent,
            child: child,
          );
        },
        child: controller.isSuccess.value
            ? const SuccessView(key: ValueKey('success'))
            : _buildForm(context),
      );
    });
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      key: const ValueKey('form'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.createAccount, style: context.textTheme.displayLarge),
        const SizedBox(height: 12),
        Text(AppStrings.joinNetwork, style: context.textTheme.bodyLarge),
        const SizedBox(height: 48),
        const AccountTypeSelector(),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(
                () => InputField(
                  label: AppStrings.firstName,
                  hint: AppStrings.firstNameHint,
                  onChanged: (v) => controller.firstName.value = v,
                  errorText: controller.firstNameError.value,
                ),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Obx(
                () => InputField(
                  label: AppStrings.lastName,
                  hint: AppStrings.lastNameHint,
                  onChanged: (v) => controller.lastName.value = v,
                  errorText: controller.lastNameError.value,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Obx(
          () => InputField(
            label: AppStrings.email,
            hint: AppStrings.emailHint,
            onChanged: (v) => controller.email.value = v,
            errorText: controller.emailError.value,
          ),
        ),
        const SizedBox(height: 24),
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputField(
                label: AppStrings.password,
                hint: AppStrings.passwordFieldHint,
                isPassword: true,
                obscureText: controller.obscurePassword.value,
                onToggleVisibility: controller.togglePasswordVisibility,
                onChanged: (v) => controller.password.value = v,
                errorText: controller.passwordError.value,
              ),
              if (controller.passwordError.value == null) ...[
                const SizedBox(height: 8),
                const Text(
                  AppStrings.passwordHint,
                  style: TextStyle(fontSize: 14, color: AppColors.bodyText),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    value: controller.agreeToTerms.value,
                    onChanged: controller.setAgreeToTerms,
                    activeColor: AppColors.primaryGreen,
                    side: controller.termsError.value != null
                        ? const BorderSide(
                            color: AppColors.errorColor,
                            width: 2,
                          )
                        : null,
                  ),
                ),
                Expanded(
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.bodyText,
                        fontFamily: 'Inter',
                      ),
                      children: [
                        TextSpan(text: AppStrings.termsAgreePart1),
                        TextSpan(
                          text: AppStrings.termsAgreePart2,
                          style: TextStyle(
                            color: AppColors.primaryGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(text: AppStrings.termsAgreePart3),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Obx(
              () => controller.termsError.value != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 12, top: 4),
                      child: Text(
                        controller.termsError.value!,
                        style: const TextStyle(
                          color: AppColors.errorColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: Obx(
            () => ElevatedButton(
              onPressed: controller.isLoading.value ? null : controller.signup,
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
                      AppStrings.submit,
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
              style: TextStyle(
                fontSize: 16,
                color: AppColors.bodyText,
                fontFamily: 'Inter',
              ),
              children: [
                TextSpan(text: AppStrings.alreadyHaveAccountPart1),
                TextSpan(
                  text: AppStrings.alreadyHaveAccountPart2,
                  style: TextStyle(
                    color: AppColors.primaryGreen,
                    fontWeight: FontWeight.w600,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = controller.signin,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 48),
        const Divider(color: AppColors.footerBorder),
        const SizedBox(height: 48),
        const Center(
          child: Text(
            AppStrings.footerText,
            style: TextStyle(fontSize: 14, color: AppColors.bodyText),
          ),
        ),
      ],
    );
  }
}
