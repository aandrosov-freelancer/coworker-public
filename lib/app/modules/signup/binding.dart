import 'package:get/get.dart';
import 'controller.dart';
import 'repository.dart';

class SignupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(
      () => SignupController(repository: SignupRepository()),
    );
  }
}
