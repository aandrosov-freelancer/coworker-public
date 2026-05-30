import 'package:get/get.dart';
import '../../data/provider/category_provider.dart';
import '../../data/provider/task_provider.dart';
import 'controller.dart';
import 'repository.dart';

class TaskDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskDetailsRepository>(
      () => TaskDetailsRepository(
        SupabaseTaskProvider(),
        SupabaseCategoryProvider(),
      ),
    );
    Get.lazyPut<TaskDetailsController>(
      () => TaskDetailsController(Get.find<TaskDetailsRepository>()),
    );
  }
}
