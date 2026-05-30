import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';
import '../controller.dart';

class FilterSidebar extends GetView<TaskPoolController> {
  final bool isMobile;
  const FilterSidebar({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isMobile ? double.infinity : 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.taskCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.filters,
            style: GoogleFonts.manrope(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.taskTitle,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            AppStrings.category,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.profileJobTitle,
            ),
          ),
          const SizedBox(height: 12),
          _buildCategoryCheckbox(AppStrings.designAndUx),
          _buildCategoryCheckbox(AppStrings.softwareDevelopment),
          _buildCategoryCheckbox(AppStrings.marketing),
          _buildCategoryCheckbox(AppStrings.textsAndTranslations),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: controller.resetFilters,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                side: const BorderSide(color: AppColors.filterResetBorder),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                AppStrings.resetFilters,
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.filterResetText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCheckbox(String title) {
    return Obx(() {
      final isSelected = controller.selectedCategories.contains(title);
      return InkWell(
        onTap: () => controller.toggleCategory(title),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryGreen
                        : AppColors.borderColor,
                    width: 1,
                  ),
                  color: isSelected
                      ? AppColors.primaryGreen
                      : Colors.transparent,
                ),
                child: isSelected
                    ? const Icon(Icons.check, size: 12, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.taskTitle,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
