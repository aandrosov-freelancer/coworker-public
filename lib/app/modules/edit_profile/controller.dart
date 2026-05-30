import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/model/profile_model.dart';
import '../../routes/routes.dart';
import 'local_widgets/add_portfolio_popup.dart';
import 'repository.dart';

class EditProfileController extends GetxController {
  final EditProfileRepository repository;
  EditProfileController({required this.repository});

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final locationController = TextEditingController();
  final specializationController = TextEditingController();
  final bioController = TextEditingController();

  final isLoading = false.obs;
  final profile = Rxn<ProfileModel>();
  final bioLength = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchProfile();
    bioController.addListener(() {
      bioLength.value = bioController.text.length;
    });
  }

  Future<void> _fetchProfile() async {
    isLoading.value = true;
    try {
      final fetchedProfile = await repository.fetchProfile();
      profile.value = fetchedProfile;

      firstNameController.text = fetchedProfile.firstName;
      lastNameController.text = fetchedProfile.lastName;
      locationController.text = fetchedProfile.location ?? '';
      specializationController.text = fetchedProfile.focus ?? '';
      bioController.text = fetchedProfile.bio ?? '';
    } catch (e) {
      Get.snackbar('Ошибка', 'Не удалось загрузить профиль: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveChanges() async {
    if (profile.value == null) return;

    isLoading.value = true;
    try {
      final updatedProfile = profile.value!.copyWith(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        location: locationController.text.isEmpty
            ? null
            : locationController.text,
        focus: specializationController.text.isEmpty
            ? null
            : specializationController.text,
        bio: bioController.text.isEmpty ? null : bioController.text,
      );

      await repository.updateProfile(profile: updatedProfile);
      Get.back(result: true, id: AppRoutes.homeNavId);
      Get.snackbar('Успех', 'Профиль успешно обновлен');
    } catch (e) {
      Get.snackbar('Ошибка', 'Не удалось сохранить изменения: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void cancel() {
    Get.back(id: AppRoutes.homeNavId);
  }

  void showAddPortfolioPopup() {
    Get.dialog(const AddPortfolioPopup());
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    locationController.dispose();
    specializationController.dispose();
    bioController.dispose();
    super.onClose();
  }
}
