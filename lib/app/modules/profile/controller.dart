import 'package:app/app/core/values/assets.dart';
import 'package:app/app/data/model/profile_model.dart';
import 'package:app/app/data/model/service_model.dart';
import 'package:get/get.dart';
import 'repository.dart';

class ProfileController extends GetxController with StateMixin<ProfileModel> {
  final ProfileRepository repository;

  ProfileController({required this.repository});

  final services = <ServiceModel>[
    ServiceModel(
      title: 'UI/UX Дизайн мобильного приложения',
      price: '45,000 ₽',
      imagePath: AppAssets.project3,
    ),
    ServiceModel(
      title: 'Прототипирование и вайрфрейминг',
      price: '20,000 ₽',
      imagePath: AppAssets.project1,
    ),
    ServiceModel(
      title: 'Создание дизайн-систем',
      price: '60,000 ₽',
      imagePath: AppAssets.project2,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      change(null, status: RxStatus.loading());

      String? targetId = Get.parameters['id'];
      if (targetId == null && Get.arguments is Map) {
        targetId = Get.arguments['id'];
      }

      final profile = await repository.fetchProfile(id: targetId);
      change(profile, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
