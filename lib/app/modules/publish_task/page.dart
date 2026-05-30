import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/app/core/values/assets.dart';
import 'package:app/app/core/values/colors.dart';
import 'package:app/app/core/values/dimensions.dart';
import 'package:app/app/core/values/strings.dart';
import 'package:app/app/data/model/category_model.dart';
import 'controller.dart';
import 'local_widgets/publish_widgets.dart';

class PublishTaskPage extends GetView<PublishTaskController> {
  const PublishTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = context.width >= AppDimensions.minDesktopWidth;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                vertical: 48,
                horizontal: isDesktop ? (context.width - 768) / 2 : 24,
              ),
              child: Container(
                width: 768,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.publishTaskTitle,
                      style: GoogleFonts.manrope(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: AppColors.profileReviewTitle,
                        letterSpacing: -0.8,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Section 1: Title and Category
                    const SectionHeader(
                      title: AppStrings.section1Title,
                      description: AppStrings.section1Desc,
                    ),
                    const SizedBox(height: 24),
                    CustomInputField(
                      label: AppStrings.taskTitleLabel,
                      hint: AppStrings.taskTitleHint,
                      onChanged: (val) =>
                          controller.titleController.value = val,
                    ),
                    const SizedBox(height: 24),
                    _buildCategoryDropdown(),

                    const SizedBox(height: 32),
                    const Divider(color: AppColors.borderColor, height: 1),
                    const SizedBox(height: 32),

                    // Section 2: Details
                    const SectionHeader(
                      title: AppStrings.section2Title,
                      description: AppStrings.section2Desc,
                    ),
                    const SizedBox(height: 24),
                    CustomInputField(
                      label: AppStrings.taskDescriptionLabel,
                      hint: AppStrings.taskDescriptionHint,
                      isTextArea: true,
                      onChanged: (val) =>
                          controller.descriptionController.value = val,
                    ),
                    const SizedBox(height: 32),
                    const Divider(color: AppColors.borderColor, height: 1),
                    const SizedBox(height: 32),

                    // Section 3: Budget
                    const SectionHeader(
                      title: AppStrings.section3Title,
                      description: AppStrings.section3Desc,
                    ),
                    const SizedBox(height: 24),
                    _buildBudgetSection(),

                    const SizedBox(height: 32),
                    _buildActions(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.category,
          style: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.profileReviewTitle,
          ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.borderColor),
              color: AppColors.white,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<CategoryModel>(
                value: controller.selectedCategory.value,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.placeholderColor,
                ),
                onChanged: (CategoryModel? newValue) {
                  if (newValue != null) controller.setCategory(newValue);
                },
                items: controller.categories
                    .map<DropdownMenuItem<CategoryModel>>((
                      CategoryModel value,
                    ) {
                      return DropdownMenuItem<CategoryModel>(
                        value: value,
                        child: Text(
                          value.title,
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            color: AppColors.profileJobTitle,
                          ),
                        ),
                      );
                    })
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBudgetSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.borderColor),
                  color: AppColors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: '0',
                          border: InputBorder.none,
                        ),
                        onChanged: (val) => controller.budget.value = val,
                      ),
                    ),
                    Text(
                      '₽',
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        color: AppColors.profileJobTitle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            const Spacer(),
          ],
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: controller.onCancel,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            side: const BorderSide(color: AppColors.borderColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            AppStrings.cancel,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.profileJobTitle,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Obx(
          () => ElevatedButton(
            onPressed: controller.isLoading.value ? null : controller.onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.priceText,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 2,
            ),
            child: controller.isLoading.value
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppStrings.next,
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      SvgPicture.asset(
                        AppAssets.icArrowRightWhite,
                        width: 16,
                        height: 16,
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
