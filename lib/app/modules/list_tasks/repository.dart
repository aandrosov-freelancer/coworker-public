import '../../core/values/supabase.dart';
import '../../data/provider/task_provider.dart';
import 'controller.dart';

class ListTasksRepository {
  final TaskProvider taskProvider;

  ListTasksRepository({required this.taskProvider});

  Future<List<MyTask>> fetchTasks() async {
    final data = await taskProvider.getMyTasks();
    return data.map((taskMap) {
      final responses = taskMap[AppSupabase.taskResponsesTable] as List?;
      return MyTask(
        id: taskMap[AppSupabase.idColumn],
        title: taskMap[AppSupabase.titleColumn] ?? '',
        description: taskMap[AppSupabase.descriptionColumn] ?? '',
        budget: '₽ ${taskMap[AppSupabase.budgetColumn] ?? 0}',
        responsesCount: responses?.length ?? 0,
        status: 'Активна',
      );
    }).toList();
  }
}
