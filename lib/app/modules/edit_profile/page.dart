import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/values/assets.dart';
import '../../core/values/colors.dart';
import 'controller.dart';

class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Obx(
        () => Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      vertical: 48,
                      horizontal: 24,
                    ),
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 800),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader(),
                            const SizedBox(height: 32),
                            _buildPhotoUploadSection(),
                            const SizedBox(height: 32),
                            _buildPersonalInformationSection(),
                            const SizedBox(height: 32),
                            _buildAboutMeSection(),
                            const SizedBox(height: 32),
                            // _buildPortfolioSection(),
                            // const SizedBox(height: 32),
                            _buildActions(),
                            const SizedBox(height: 80),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (controller.isLoading.value)
              Container(
                color: Colors.black.withValues(alpha: 0.1),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryGreen,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Редактировать профиль',
          style: GoogleFonts.manrope(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: AppColors.profileReviewTitle,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Обновите вашу личную и профессиональную информацию.',
          style: GoogleFonts.manrope(
            fontSize: 16,
            color: AppColors.profileJobTitle,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoUploadSection() {
    return _buildSectionCard(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Container(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primaryGreen.withValues(alpha: 0.2),
                width: 2,
              ),
              image: const DecorationImage(
                image: AssetImage(AppAssets.editProfileAvatar),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 32),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: SvgPicture.asset(AppAssets.icUploadVariant),
                      label: const Text('Загрузить новое'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGreen,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                    ),
                    const SizedBox(width: 16),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.errorColor,
                        side: BorderSide(
                          color: AppColors.errorColor.withValues(alpha: 0.5),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Удалить'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Рекомендуемый размер: 400x400px. Форматы: JPG, PNG.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.placeholderColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInformationSection() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Личная информация'),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildInputField(
                        label: 'Имя',
                        textController: controller.firstNameController,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildInputField(
                        label: 'Фамилия',
                        textController: controller.lastNameController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildInputField(
                  label: 'Местоположение (необязательно)',
                  textController: controller.locationController,
                ),
                const SizedBox(height: 23),
                _buildInputField(
                  label: 'Специализация',
                  textController: controller.specializationController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutMeSection() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Обо мне'),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildInputField(
                  label: '',
                  textController: controller.bioController,
                  maxLines: 6,
                ),
                const SizedBox(height: 8),
                Obx(
                  () => Text(
                    '${controller.bioLength.value} / 1000 символов',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.placeholderColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () => controller.cancel(),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.profileJobTitle,
            side: const BorderSide(color: AppColors.borderColor),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Отмена'),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () => controller.saveChanges(),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryGreen,
            foregroundColor: AppColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: const Text('Сохранить изменения'),
        ),
      ],
    );
  }

  Widget _buildSectionCard({required Widget child, EdgeInsets? padding}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      padding: padding,
      child: child,
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.borderColor.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Text(
        title,
        style: GoogleFonts.manrope(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.profileReviewTitle,
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController textController,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.profileJobTitle,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: textController,
          maxLines: maxLines,
          decoration: InputDecoration(
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
}
