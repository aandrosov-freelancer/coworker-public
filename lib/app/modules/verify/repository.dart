import '../../data/services/verify_service.dart';

class VerifyRepository {
  final VerifyService service;
  VerifyRepository({required this.service});

  Future<void> verifyOTP({required String email, required String token}) {
    return service.verifyOTP(email: email, token: token);
  }

  Future<void> resendOTP({required String email}) {
    return service.resendOTP(email: email);
  }
}
