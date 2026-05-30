import 'package:get/get.dart';
import '../../data/provider/profile_provider.dart';
import 'controller.dart';
import 'repository.dart';

class EditProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileProvider>(() => SupabaseProfileProvider());
    Get.lazyPut<EditProfileRepository>(
      () => EditProfileRepository(profileProvider: Get.find()),
    );
    Get.lazyPut<EditProfileController>(
      () => EditProfileController(repository: Get.find()),
    );
  }
}
