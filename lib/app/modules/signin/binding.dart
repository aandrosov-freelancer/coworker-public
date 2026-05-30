import 'package:get/get.dart';
import 'controller.dart';
import 'repository.dart';

class SigninBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SigninController>(
      () => SigninController(repository: SigninRepository()),
    );
  }
}
