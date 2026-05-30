import 'package:get/get.dart';
import '../modules/home/binding.dart';
import '../modules/home/page.dart';
import '../modules/signin/binding.dart';
import '../modules/signin/page.dart';
import '../modules/signup/binding.dart';
import '../modules/signup/page.dart';
import '../modules/verify/binding.dart';
import '../modules/verify/page.dart';
import 'routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupPage(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: AppRoutes.signin,
      page: () => const SigninPage(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: AppRoutes.verify,
      page: () => const VerifyPage(),
      binding: VerifyBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
