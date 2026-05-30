import 'package:get/get.dart';
import 'repository.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final String price;
  final String postedAt;
  final String deadline;
  final bool isUrgent;
  final List<String> tags;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.postedAt,
    required this.deadline,
    this.isUrgent = false,
    this.tags = const [],
  });
}

class TaskPoolController extends GetxController {
  final TaskPoolRepository repository;

  TaskPoolController({required this.repository});

  final tasks = <Task>[].obs;
  final selectedCategories = <String>[].obs;
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyTasks();
  }

  void _loadDummyTasks() {
    tasks.assignAll([
      Task(
        id: '1',
        title: 'Разработка лендинга на Webflow',
        description:
            'Требуется сверстать и натянуть на простую CMS (Wordpress/Webflow) лендинг по готовому дизайну в Figma. Анимации при скролле, интеграция формы бронирования',
        price: '45k - 60k ₽',
        postedAt: '2 часа назад',
        deadline: '28 Октября',
        isUrgent: true,
        tags: ['Frontend', 'Webflow', 'JavaScript'],
      ),
      Task(
        id: '2',
        title: 'Ребрендинг финтех-платформы',
        description:
            'Необходимо разработать новую визуальную айдентику, включая логотип, цветовую палитру и гайдлайны для использования в веб и мобильных приложениях.',
        price: '120k - 150k ₽',
        postedAt: '5 часов назад',
        deadline: '15 Ноября',
        isUrgent: false,
        tags: ['Branding', 'UI/UX', 'Fintech'],
      ),
      Task(
        id: '3',
        title: 'Создание контент-плана для соцсетей',
        description:
            'Ищем опытного SMM-специалиста для разработки стратегии и контент-плана на 3 месяца для нового бренда одежды.',
        price: '30k - 40k ₽',
        postedAt: 'Вчера',
        deadline: '1 Ноября',
        isUrgent: false,
        tags: ['Marketing', 'SMM', 'Copywriting'],
      ),
    ]);
  }

  void toggleCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  void resetFilters() {
    selectedCategories.clear();
  }

  void onSearch(String value) {
    searchQuery.value = value;
  }
}
