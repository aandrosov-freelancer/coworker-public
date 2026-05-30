import 'package:app/app/core/errors/email_not_confirmed_exception.dart';
import 'package:app/app/core/values/supabase.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class SigninService {
  Future<void> signIn({required String email, required String password});
}

class SupabaseSigninService extends GetxService implements SigninService {
  final _client = Supabase.instance.client;

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      await _client.auth.signInWithPassword(email: email, password: password);
    } on AuthApiException catch (e) {
      if (e.code == AppSupabase.emailNotConfirmedCode) {
        throw EmailNotConfirmedException();
      }

      rethrow;
    }
  }
}
