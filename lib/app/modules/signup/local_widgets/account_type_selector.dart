import 'package:app/app/modules/signup/enums/account_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';
import '../controller.dart';

class AccountTypeSelector extends GetView<SignupController> {
  const AccountTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.registerAs,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.headingDark,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Obx(
                () => _buildOption(
                  title: AppStrings.client,
                  description: AppStrings.clientDesc,
                  iconPath: 'assets/images/client_icon.svg',
                  isSelected: controller.accountType.value.isCustomer,
                  onTap: () => controller.setAccountType(AccountType.customer),
                ),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Obx(
                () => _buildOption(
                  title: AppStrings.freelancer,
                  description: AppStrings.freelancerDesc,
                  iconPath: 'assets/images/freelancer_icon.svg',
                  isSelected: controller.accountType.value.isPerformer,
                  onTap: () => controller.setAccountType(AccountType.performer),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOption({
    required String title,
    required String description,
    required String iconPath,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: 300.ms,
            curve: Curves.easeInOut,
            height: 160,
            padding: const EdgeInsets.all(26),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.selectedBlue : AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? AppColors.primaryGreen
                    : AppColors.borderColor,
                width: 2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(iconPath, width: 24, height: 24),
                    const Spacer(),
                    RadioGroup(
                      groupValue: isSelected,
                      onChanged: (_) {},
                      child: IgnorePointer(
                        child: Radio<bool>(
                          value: true,
                          activeColor: AppColors.primaryGreen,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.headingDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.bodyText,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        )
        .animate(target: isSelected ? 1 : 0)
        .scale(
          begin: const Offset(1, 1),
          end: const Offset(1.02, 1.02),
          duration: 200.ms,
          curve: Curves.easeOut,
        );
  }
}
