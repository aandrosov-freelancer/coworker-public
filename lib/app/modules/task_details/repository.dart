import '../../data/model/category_model.dart';
import '../../data/model/task_model.dart';
import '../../data/provider/category_provider.dart';
import '../../data/provider/task_provider.dart';
import 'entities/task_response_entity.dart';

class TaskDetailsRepository {
  final TaskProvider _taskProvider;
  final CategoryProvider _categoryProvider;

  TaskDetailsRepository(this._taskProvider, this._categoryProvider);

  Future<TaskModel> getTaskById(int id) => _taskProvider.getTaskById(id);

  Future<CategoryModel> getCategoryById(int id) =>
      _categoryProvider.getCategoryById(id);

  Future<List<TaskResponseEntity>> getTaskResponses(int taskId) async {
    final response = await _taskProvider.getTaskResponses(taskId);
    return response.map((json) => TaskResponseEntity.fromJson(json)).toList();
  }

  Future<void> runMatchAlgorithm(int taskId) =>
      _taskProvider.runMatchAlgorithm(taskId);
}
