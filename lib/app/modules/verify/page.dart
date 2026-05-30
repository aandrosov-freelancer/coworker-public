import 'package:app/app/core/values/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
import 'controller.dart';

class VerifyPage extends GetView<VerifyController> {
  const VerifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8F9FF), AppColors.white],
          ),
        ),
        child: Stack(
          children: [
            // Logo
            Positioned(
              top: 24,
              left: 24,
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/logo.svg',
                    width: 64,
                    height: 64,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    AppStrings.appName,
                    style: GoogleFonts.manrope(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGreen,
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Center(
              child: SingleChildScrollView(
                child: Container(
                  width: 448,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Obx(
                    () => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Illustration
                        Container(
                          padding: const .all(25),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundDimmed,
                            borderRadius: .circular(12),
                          ),
                          child: controller.isVerified.value
                              ? LottieBuilder.asset(
                                  AppAssets.successTickAnimation,
                                  width: 47,
                                  height: 47,
                                  repeat: false,
                                )
                              : SvgPicture.asset(
                                  AppAssets.email,
                                  width: 35,
                                  height: 30,
                                ),
                        ),
                        const SizedBox(height: 40),
                        // Header
                        Text(
                          controller.isVerified.value
                              ? AppStrings.emailVerified
                              : AppStrings.almostDone,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.manrope(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            color: AppColors.headingDark,
                            letterSpacing: -0.8, // -2%
                            height: 1.2, // 48/40
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          controller.isVerified.value
                              ? AppStrings.accountActivated
                              : AppStrings.enterCode,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF3F4944),
                            height: 1.5, // 24/16
                          ),
                        ),
                        if (!controller.isVerified.value) ...[
                          if (controller.showSuccessBanner.value) ...[
                            const SizedBox(height: 24),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.successBg.withValues(
                                  alpha: 0.2,
                                ),
                                border: Border.all(
                                  color: AppColors.successBorder.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/email.svg',
                                    width: 15,
                                    height: 15,
                                    colorFilter: const ColorFilter.mode(
                                      AppColors.darkGreen,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      AppStrings.codeResent,
                                      style: GoogleFonts.manrope(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.darkGreen,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          const SizedBox(height: 40),
                          // Verification Form
                          Column(
                            children: [
                              _buildPinput(controller.errorText.value != null),
                              if (controller.errorText.value != null) ...[
                                const SizedBox(height: 16),
                                Text(
                                  controller.errorText.value!,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.manrope(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.errorColor,
                                    height: 1.4, // 16.8/12
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 40),
                          // Continue Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : controller.onContinue,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.darkGreen,
                                foregroundColor: AppColors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 24,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                elevation: 0,
                                disabledBackgroundColor: AppColors.darkGreen
                                    .withValues(alpha: 0.6),
                              ),
                              child: controller.isLoading.value
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              AppColors.white,
                                            ),
                                      ),
                                    )
                                  : Text(
                                      AppStrings.continueText,
                                      style: GoogleFonts.manrope(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),

                          const SizedBox(height: 24),
                          // Resend Section
                          TextButton(
                            onPressed: controller.onResendCode,
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/email.svg',
                                  width: 14,
                                  height: 14,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.darkGreen,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  AppStrings.didntGetCode,
                                  style: GoogleFonts.manrope(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.darkGreen,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else ...[
                          const SizedBox(height: 40),
                          // Dashboard Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: controller.onGoToDashboard,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.darkGreen,
                                foregroundColor: AppColors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 24,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                AppStrings.goToDashboard,
                                style: GoogleFonts.manrope(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPinput(bool hasError) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 64,
      textStyle: GoogleFonts.manrope(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.headingDark,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(
          color: hasError ? AppColors.errorColor : const Color(0xFFBEC9C2),
        ),
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000), // 0.05 opacity
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(
          color: hasError ? AppColors.errorColor : AppColors.primaryGreen,
          width: 2,
        ),
      ),
    );

    return Pinput(
      length: 6,
      onChanged: controller.onCodeChanged,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      errorPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          border: Border.all(color: AppColors.errorColor),
        ),
      ),
      separatorBuilder: (index) {
        if (index == 2) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: Text(
                '-',
                style: GoogleFonts.manrope(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFBEC9C2),
                ),
              ),
            ),
          );
        }
        return const SizedBox(width: 16);
      },
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
