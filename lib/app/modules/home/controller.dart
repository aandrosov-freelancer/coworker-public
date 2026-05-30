import 'package:app/app/data/model/profile_model.dart';
import 'package:app/app/routes/routes.dart';
import 'package:get/get.dart';

import '../../core/errors/unauthorized_exception.dart';
import 'repository.dart';

class HomeController extends GetxController with StateMixin<ProfileModel> {
  String get currentRoute => _currentRoute.value;

  final _homeRepository = Get.find<HomeRepository>();

  final _currentRoute = AppRoutes.profile.obs;

  @override
  void onInit() {
    super.onInit();
    load(refresh: true);
  }

  Future<void> load({bool refresh = false}) async {
    try {
      change(null, status: .loading());
      final profile = await _homeRepository.fetchProfile(refresh: refresh);
      change(profile, status: .success());
    } on UnauthorizedException {
      Get.offAllNamed(AppRoutes.signin);
    } catch (e) {
      change(null, status: .error(e.toString()));
    }
  }

  void updateRoute(String route) {
    _currentRoute.value = route;
  }
}
