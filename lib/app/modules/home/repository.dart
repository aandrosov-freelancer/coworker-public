import 'package:app/app/data/model/profile_model.dart';
import 'package:app/app/data/provider/profile_provider.dart';
import 'package:get/get.dart';

class HomeRepository {
  final _profileProvider = Get.find<ProfileProvider>();

  Future<ProfileModel> fetchProfile({bool refresh = false}) async {
    return await _profileProvider.fetchProfile(refresh: refresh);
  }
}
