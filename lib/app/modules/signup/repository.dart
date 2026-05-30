import 'package:app/app/data/services/signup_service.dart';
import 'package:app/app/modules/signup/enums/account_type.dart';
import 'package:get/get.dart';

class SignupRepository {
  final _signupService = Get.find<SignupService>();

  Future<void> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required AccountType accountType,
  }) async {
    return await _signupService.signUp(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      role: accountType == .customer ? .customer : .performer,
    );
  }
}
