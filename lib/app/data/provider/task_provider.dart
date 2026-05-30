import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/values/supabase.dart';
import '../../core/errors/unauthorized_exception.dart';
import '../model/task_model.dart';

abstract interface class TaskProvider {
  Future<void> createTask(TaskModel task);
  Future<List<Map<String, dynamic>>> getMyTasks();
  Future<TaskModel> getTaskById(int id);
  Future<List<Map<String, dynamic>>> getTaskResponses(int taskId);
  Future<void> runMatchAlgorithm(int taskId);
}

class SupabaseTaskProvider implements TaskProvider {
  final supabase = Supabase.instance.client;

  @override
  Future<void> createTask(TaskModel task) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw UnauthorizedException();

    final taskData = task.toJson();
    taskData[AppSupabase.customerIdColumn] = user.id;
    // Remove null/empty fields that should be handled by DB defaults
    taskData.remove(AppSupabase.idColumn);
    taskData.remove(AppSupabase.createdAtColumn);

    await supabase.from(AppSupabase.tasksTable).insert(taskData);
  }

  @override
  Future<List<Map<String, dynamic>>> getMyTasks() async {
    final user = supabase.auth.currentUser;
    if (user == null) throw UnauthorizedException();

    final response = await supabase
        .from(AppSupabase.tasksTable)
        .select('*, ${AppSupabase.taskResponsesTable}(${AppSupabase.idColumn})')
        .eq(AppSupabase.customerIdColumn, user.id)
        .order(AppSupabase.createdAtColumn, ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Future<TaskModel> getTaskById(int id) async {
    final response = await supabase
        .from(AppSupabase.tasksTable)
        .select()
        .eq(AppSupabase.idColumn, id)
        .single();

    return TaskModel.fromJson(response);
  }

  @override
  Future<List<Map<String, dynamic>>> getTaskResponses(int taskId) async {
    final response = await supabase
        .from(AppSupabase.taskResponsesTable)
        .select('*, performer: ${AppSupabase.profilesTable}(*)')
        .eq('task_id', taskId)
        .order(AppSupabase.coincidenceColumn, ascending: false)
        .order(AppSupabase.createdAtColumn, ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Future<void> runMatchAlgorithm(int taskId) async {
    await supabase.functions.invoke('match', body: {'task_id': taskId});
  }
}
