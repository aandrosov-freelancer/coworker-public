import '../../data/model/profile_model.dart';
import '../../data/provider/profile_provider.dart';

class ProfileRepository {
  final ProfileProvider provider;

  ProfileRepository({required this.provider});

  Future<ProfileModel> fetchProfile({String? id}) => provider.fetchProfile(id: id);

  Future<void> updateProfile({required ProfileModel profile}) =>
      provider.updateProfile(profile: profile);
}
