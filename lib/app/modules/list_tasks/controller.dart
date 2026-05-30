import 'package:get/get.dart';
import 'repository.dart';

class MyTask {
  final int id;
  final String title;
  final String description;
  final String budget;
  final int responsesCount;
  final String status;

  MyTask({
    required this.id,
    required this.title,
    required this.description,
    required this.budget,
    required this.responsesCount,
    required this.status,
  });
}

class ListTasksController extends GetxController {
  final ListTasksRepository repository;

  ListTasksController({required this.repository});

  final tasks = <MyTask>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      isLoading.value = true;
      final result = await repository.fetchTasks();
      tasks.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load tasks: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
