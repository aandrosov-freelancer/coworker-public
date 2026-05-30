import '../../data/model/category_model.dart';
import '../../data/model/task_model.dart';
import '../../data/provider/category_provider.dart';
import '../../data/provider/task_provider.dart';

class PublishTaskRepository {
  final TaskProvider taskProvider;
  final CategoryProvider categoryProvider;
  PublishTaskRepository({
    required this.taskProvider,
    required this.categoryProvider,
  });

  Future<void> publishTask(TaskModel task) => taskProvider.createTask(task);

  Future<List<CategoryModel>> fetchCategories() =>
      categoryProvider.fetchCategories();
}
