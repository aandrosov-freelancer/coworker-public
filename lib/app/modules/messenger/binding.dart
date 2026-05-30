import 'package:get/get.dart';
import '../../data/provider/messenger_provider.dart';
import 'controller.dart';
import 'repository.dart';

class MessengerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessengerProvider>(() => SupabaseMessengerProvider());
    Get.lazyPut<MessengerRepository>(
      () => MessengerRepository(provider: Get.find()),
    );
    Get.lazyPut<MessengerController>(
      () => MessengerController(repository: Get.find()),
    );
  }
}
