import 'package:app/app/global_widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../messenger/binding.dart';
import '../messenger/page.dart';

import '../edit_profile/binding.dart';
import '../edit_profile/page.dart';
import '../list_tasks/binding.dart';
import '../list_tasks/page.dart';
import '../publish_task/binding.dart';
import '../publish_task/page.dart';
import '../task_details/binding.dart';
import '../task_details/page.dart';
import '../task_pool/binding.dart';
import '../task_pool/page.dart';
import 'local_widgets/top_nav_bar.dart';
import '../../routes/routes.dart';
import '../profile/binding.dart';
import '../profile/page.dart';
import 'controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => Scaffold(
        appBar: PreferredSize(
          preferredSize: const .fromHeight(80),
          child: TopNavBar(),
        ),
        drawer: Obx(() => AppDrawer(activeRoute: controller.currentRoute)),
        body: Navigator(
          key: Get.nestedKey(AppRoutes.homeNavId),
          initialRoute: AppRoutes.profile,
          onGenerateRoute: _onGenerateRoute,
          observers: [GetObserver(null, Get.routing)],
        ),
      ),
      onLoading: const Center(child: CircularProgressIndicator()),
      onError: (error) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ошибка: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => controller.load(refresh: true),
              child: const Text('Перезагрузить'),
            ),
          ],
        ),
      ),
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    controller.updateRoute(settings.name ?? '');

    return switch (settings.name) {
      AppRoutes.profile => GetPageRoute(
        settings: settings,
        page: () => const ProfilePage(),
        binding: ProfileBinding(),
      ),
      AppRoutes.taskPool => GetPageRoute(
        settings: settings,
        page: () => const TaskPoolPage(),
        binding: TaskPoolBinding(),
      ),
      AppRoutes.listTasks => GetPageRoute(
        settings: settings,
        page: () => const ListTasksPage(),
        binding: ListTasksBinding(),
      ),
      AppRoutes.editProfile => GetPageRoute(
        settings: settings,
        page: () => const EditProfilePage(),
        binding: EditProfileBinding(),
      ),
      AppRoutes.publishTask => GetPageRoute(
        settings: settings,
        page: () => const PublishTaskPage(),
        binding: PublishTaskBinding(),
      ),
      AppRoutes.taskDetails => GetPageRoute(
        settings: settings,
        page: () => const TaskDetailsPage(),
        binding: TaskDetailsBinding(),
      ),
      AppRoutes.messenger => GetPageRoute(
        settings: settings,
        page: () => const MessengerPage(),
        binding: MessengerBinding(),
      ),
      _ => GetPageRoute(page: () => const Text('404 не найдено')),
    };
  }
}
