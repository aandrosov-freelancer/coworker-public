import 'package:app/app/modules/signup/controller.dart';
import 'package:app/app/core/values/assets.dart';
import 'package:app/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';

class SuccessView extends StatefulWidget {
  const SuccessView({super.key});

  @override
  State<SuccessView> createState() => _SuccessViewState();
}

class _SuccessViewState extends State<SuccessView>
    with SingleTickerProviderStateMixin {
  late final _tickAnimationController = AnimationController(vsync: this);
  final _signupController = Get.find<SignupController>();

  @override
  void initState() {
    super.initState();
    _tickAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.offAllNamed(
          AppRoutes.verify,
          arguments: _signupController.email.value,
        );
      }
    });
  }

  @override
  void dispose() {
    _tickAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          AppAssets.successTickAnimation,
          controller: _tickAnimationController,
          width: 200,
          height: 200,
          repeat: false,
          onLoaded: (composition) {
            _tickAnimationController
              ..duration = composition.duration
              ..forward();
          },
        ),
        const SizedBox(height: 24),
        Text(
          AppStrings.registrationSuccess,
          style: context.textTheme.displaySmall?.copyWith(
            color: AppColors.headingDark,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          AppStrings.registrationSuccessDesc,
          style: context.textTheme.bodyLarge?.copyWith(
            color: AppColors.bodyText,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.offAllNamed(
              AppRoutes.verify,
              arguments: _signupController.email.value,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              AppStrings.continueText,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
