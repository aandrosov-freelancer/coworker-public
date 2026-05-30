import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/app/core/values/colors.dart';
import 'package:app/app/core/values/assets.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String description;

  const SectionHeader({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.profileReviewTitle,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.profileJobTitle,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class CustomInputField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isTextArea;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const CustomInputField({
    super.key,
    required this.label,
    required this.hint,
    this.isTextArea = false,
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.profileReviewTitle,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: isTextArea ? 5 : 1,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.manrope(
              color: AppColors.placeholderColor,
              fontSize: 16,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primaryGreen),
            ),
            filled: true,
            fillColor: AppColors.white,
          ),
        ),
      ],
    );
  }
}

class SkillChip extends StatelessWidget {
  final String label;
  final VoidCallback onDeleted;

  const SkillChip({super.key, required this.label, required this.onDeleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.backgroundDimmed,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.profileJobTitle,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onDeleted,
            child: SvgPicture.asset(
              AppAssets.icClose,
              width: 14,
              height: 14,
              colorFilter: const ColorFilter.mode(
                AppColors.profileJobTitle,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
