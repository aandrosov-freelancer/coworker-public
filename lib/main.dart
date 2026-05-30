import 'package:app/app/core/values/supabase.dart';
import 'package:app/app/data/provider/profile_provider.dart';
import 'package:app/app/data/services/signin_service.dart';
import 'package:app/app/data/services/signup_service.dart';
import 'package:app/app/data/services/verify_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/core/theme/app_theme.dart';
import 'app/routes/pages.dart';
import 'app/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  await Supabase.initialize(
    url: dotenv.get(AppSupabase.supabaseUrlEnvKey),
    anonKey: dotenv.get(AppSupabase.supabaseAnonEnvKey),
  );

  Get.put<ProfileProvider>(SupabaseProfileProvider());
  Get.put<SignupService>(SupabaseSignupService());
  Get.put<SigninService>(SupabaseSigninService());
  Get.put<VerifyService>(SupabaseVerifyService());

  runApp(
    GetMaterialApp(
      title: 'Coworker',
      initialRoute: AppRoutes.initial,
      getPages: AppPages.pages,
      theme: AppThemes.lightTheme,
      debugShowCheckedModeBanner: false,
      builder: (_, child) => Scaffold(body: child),
    ),
  );
}
