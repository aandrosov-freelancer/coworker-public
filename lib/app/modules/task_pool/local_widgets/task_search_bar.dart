import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/values/assets.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';
import '../controller.dart';

class TaskSearchBar extends GetView<TaskPoolController> {
  const TaskSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Row(
              children: [
                SvgPicture.asset(AppAssets.icSearch),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    onChanged: controller.onSearch,
                    decoration: InputDecoration(
                      hintText: AppStrings.searchTasks,
                      hintStyle: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.placeholderColor,
                      ),
                      border: InputBorder.none,
                      isCollapsed: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Row(
            children: [
              Text(
                AppStrings.sortByNewest,
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.taskTitle,
                ),
              ),
              const SizedBox(width: 12),
              const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.placeholderColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
