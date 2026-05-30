import 'package:get/get.dart';
import 'controller.dart';
import 'repository.dart';

class TaskPoolBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskPoolRepository>(() => TaskPoolRepository());
    Get.lazyPut<TaskPoolController>(
      () => TaskPoolController(repository: Get.find()),
    );
  }
}
