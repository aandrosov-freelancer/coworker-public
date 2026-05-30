import 'package:app/app/data/provider/category_provider.dart';
import 'package:app/app/data/provider/task_provider.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'repository.dart';

class PublishTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskProvider>(() => SupabaseTaskProvider());
    Get.lazyPut<CategoryProvider>(() => SupabaseCategoryProvider());
    Get.lazyPut<PublishTaskRepository>(
      () => PublishTaskRepository(
        taskProvider: Get.find(),
        categoryProvider: Get.find(),
      ),
    );
    Get.lazyPut<PublishTaskController>(
      () => PublishTaskController(repository: Get.find()),
    );
  }
}
