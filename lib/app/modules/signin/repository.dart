import 'package:get/get.dart';
import '../../data/services/signin_service.dart';

class SigninRepository {
  final _signinService = Get.find<SigninService>();

  Future<void> signIn({required String email, required String password}) async {
    await _signinService.signIn(email: email, password: password);
  }
}
