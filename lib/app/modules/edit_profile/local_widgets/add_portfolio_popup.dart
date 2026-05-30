import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/values/assets.dart';
import '../../../core/values/colors.dart';

class AddPortfolioPopup extends StatelessWidget {
  const AddPortfolioPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        width: 672,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              offset: const Offset(0, 12),
              blurRadius: 24,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildInputField(
                      label: 'Название проекта',
                      required: true,
                      placeholder: 'Например: Дизайн мобильного приложения',
                    ),
                    const SizedBox(height: 24),
                    _buildInputField(
                      label: 'Описание',
                      placeholder:
                          'Кратко опишите вашу роль, задачи и результаты...',
                      maxLines: 4,
                    ),
                    const SizedBox(height: 24),
                    _buildUploadSection(),
                    const SizedBox(height: 24),
                    _buildInputField(
                      label: 'Ссылка на проект (необязательно)',
                      placeholder: 'https://...',
                      prefixIcon: AppAssets.icLink,
                    ),
                  ],
                ),
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.borderColor.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Добавить работу в портфолио',
            style: GoogleFonts.manrope(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.profileReviewTitle,
            ),
          ),
          IconButton(
            onPressed: () => Get.back(),
            icon: SvgPicture.asset(AppAssets.icClose),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
            style: IconButton.styleFrom(shape: const CircleBorder()),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
        border: Border(
          top: BorderSide(color: AppColors.borderColor.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () => Get.back(),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.profileReviewTitle,
              side: const BorderSide(color: AppColors.borderColor),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Отмена'),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.profileHeaderBg,
              foregroundColor: AppColors
                  .successBorder, // Using this as light text color for button
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: Text(
              'Добавить',
              style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String placeholder,
    bool required = false,
    int maxLines = 1,
    String? prefixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.profileReviewTitle,
            ),
            children: [
              if (required)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: AppColors.errorColor),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: GoogleFonts.manrope(
              fontSize: 16,
              color: AppColors.placeholderColor,
            ),
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(prefixIcon),
                  )
                : null,
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
          ),
          style: GoogleFonts.manrope(
            fontSize: 16,
            color: AppColors.profileReviewTitle,
          ),
        ),
      ],
    );
  }

  Widget _buildUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Загрузить обложку',
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.profileReviewTitle,
            ),
            children: const [
              TextSpan(
                text: ' *',
                style: TextStyle(color: AppColors.errorColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.borderColor,
              width: 2,
              style: BorderStyle.solid, // Should be dashed in final production
            ),
          ),
          child: Column(
            children: [
              SvgPicture.asset(AppAssets.icUpload, width: 32, height: 32),
              const SizedBox(height: 8),
              Text(
                'Нажмите, чтобы загрузить, или перетащите файл',
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  color: AppColors.profileJobTitle,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'JPG, PNG или WEBP (макс. 5 МБ)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.placeholderColor,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Рекомендуемое соотношение 16:9',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.placeholderColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
