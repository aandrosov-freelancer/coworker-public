import 'package:app/app/core/values/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/errors/unauthorized_exception.dart';
import '../model/profile_model.dart';

abstract interface class ProfileProvider {
  Future<ProfileModel> fetchProfile({bool refresh = false, String? id});
  Future<void> updateProfile({required ProfileModel profile});
}

class SupabaseProfileProvider implements ProfileProvider {
  final supabase = Supabase.instance.client;

  ProfileModel? _profile;

  @override
  Future<ProfileModel> fetchProfile({bool refresh = false, String? id}) async {
    if (_profile != null && !refresh && id == null) {
      return _profile!;
    }

    final targetId = id ?? supabase.auth.currentUser?.id;
    if (targetId == null) throw UnauthorizedException();

    final data = await supabase
        .from(AppSupabase.profilesTable)
        .select()
        .eq(AppSupabase.idColumn, targetId)
        .limit(1)
        .single();

    final fetchedProfile = ProfileModel.fromJson(data);

    if (id == null) {
      _profile = fetchedProfile;
    }

    return fetchedProfile;
  }

  @override
  Future<void> updateProfile({required ProfileModel profile}) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw UnauthorizedException();

    await supabase
        .from(AppSupabase.profilesTable)
        .update(profile.toJson()..remove(AppSupabase.idColumn))
        .eq(AppSupabase.idColumn, user.id);
  }
}
