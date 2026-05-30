import 'package:get/get.dart';
import '../../data/provider/profile_provider.dart';
import 'controller.dart';
import 'repository.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileProvider>(() => SupabaseProfileProvider());
    Get.lazyPut<ProfileRepository>(
      () => ProfileRepository(provider: Get.find()),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(repository: Get.find()),
    );
  }
}
