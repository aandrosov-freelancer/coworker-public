import '../../data/provider/profile_provider.dart';
import '../../data/model/profile_model.dart';

class EditProfileRepository {
  final ProfileProvider profileProvider;
  EditProfileRepository({required this.profileProvider});

  Future<ProfileModel> fetchProfile() => profileProvider.fetchProfile();

  Future<void> updateProfile({required ProfileModel profile}) =>
      profileProvider.updateProfile(profile: profile);
}
