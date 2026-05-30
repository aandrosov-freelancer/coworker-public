import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/values/supabase.dart';
import '../enums/user_role.dart';

abstract interface class SignupService {
  Future<void> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required UserRole role,
  });
}

class SupabaseSignupService extends GetxService implements SignupService {
  final SupabaseClient _client = Supabase.instance.client;

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required UserRole role,
  }) async {
    await _client.auth.signUp(
      email: email,
      password: password,
      data: {
        AppSupabase.firstNameColumn: firstName,
        AppSupabase.lastNameColumn: lastName,
        AppSupabase.roleColumn: role.name,
      },
    );
  }
}
