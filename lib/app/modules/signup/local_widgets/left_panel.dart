import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';

class LeftPanel extends StatelessWidget {
  const LeftPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.darkBlue),
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.6,
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppColors.darkBlue,
                    Color(0xCC131B2E),
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  'assets/images/logo_outlined.svg',
                  width: 256,
                  height: 256,
                ),
                const SizedBox(height: 48),
                Text(
                  AppStrings.appName,
                  style: context.textTheme.displayLarge?.copyWith(
                    fontSize: 64,
                    color: AppColors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  AppStrings.platformSubtitle,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: AppColors.subtitleText,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 48),
                Container(
                  padding: const EdgeInsets.only(left: 12),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(color: AppColors.primaryGreen, width: 4),
                    ),
                  ),
                  child: Text(
                    AppStrings.testimonial,
                    style: context.textTheme.headlineMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
