import 'package:get/get.dart';
import '../../data/provider/task_provider.dart';
import 'controller.dart';
import 'repository.dart';

class ListTasksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskProvider>(() => SupabaseTaskProvider());
    Get.lazyPut<ListTasksRepository>(
      () => ListTasksRepository(taskProvider: Get.find<TaskProvider>()),
    );
    Get.lazyPut<ListTasksController>(
      () => ListTasksController(repository: Get.find<ListTasksRepository>()),
    );
  }
}
