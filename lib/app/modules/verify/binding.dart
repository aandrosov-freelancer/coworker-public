import 'package:get/get.dart';
import '../../data/services/verify_service.dart';
import 'controller.dart';
import 'repository.dart';

class VerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyController>(
      () => VerifyController(
        repository: VerifyRepository(service: Get.find<VerifyService>()),
      ),
    );
  }
}
