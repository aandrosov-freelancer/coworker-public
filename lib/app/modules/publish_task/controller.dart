import 'package:app/app/core/values/strings.dart';
import 'package:app/app/data/model/category_model.dart';
import 'package:app/app/data/model/task_model.dart';
import 'package:app/app/routes/routes.dart';
import 'package:get/get.dart';
import 'repository.dart';

class PublishTaskController extends GetxController {
  final PublishTaskRepository repository;
  PublishTaskController({required this.repository});

  final titleController = ''.obs;
  final descriptionController = ''.obs;
  final budget = '0'.obs;
  final isNegotiated = false.obs;
  final categories = <CategoryModel>[].obs;
  final selectedCategory = Rxn<CategoryModel>();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final fetchedCategories = await repository.fetchCategories();
      categories.assignAll(fetchedCategories);
      if (categories.isNotEmpty) {
        selectedCategory.value = categories.first;
      }
    } catch (e) {
      Get.snackbar(AppStrings.error, e.toString());
    }
  }

  void toggleNegotiated(bool? value) {
    isNegotiated.value = value ?? false;
  }

  void setCategory(CategoryModel category) {
    selectedCategory.value = category;
  }

  void onCancel() {
    Get.back(id: AppRoutes.homeNavId);
  }

  Future<void> onNext() async {
    if (titleController.value.isEmpty ||
        descriptionController.value.isEmpty ||
        selectedCategory.value == null) {
      Get.snackbar(AppStrings.error, AppStrings.fieldRequired);
      return;
    }

    final budgetValue = double.tryParse(budget.value) ?? 0.0;

    isLoading.value = true;
    try {
      final task = TaskModel(
        title: titleController.value,
        description: descriptionController.value,
        budget: budgetValue,
        categoryId: selectedCategory.value!.id,
      );
      await repository.publishTask(task);
      Get.back(id: AppRoutes.homeNavId);
      Get.snackbar(
        AppStrings.success,
        AppStrings.taskPublishedSuccess,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        AppStrings.error,
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
