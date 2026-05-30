import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class VerifyService {
  Future<void> verifyOTP({required String email, required String token});
  Future<void> resendOTP({required String email});
}

class SupabaseVerifyService extends GetxService implements VerifyService {
  final _client = Supabase.instance.client;

  @override
  Future<void> verifyOTP({required String email, required String token}) async {
    await _client.auth.verifyOTP(
      email: email,
      token: token,
      type: OtpType.signup,
    );
  }

  @override
  Future<void> resendOTP({required String email}) async {
    await _client.auth.resend(type: OtpType.signup, email: email);
  }
}
