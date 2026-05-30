import 'dart:async';
import 'package:get/get.dart';
import '../../data/model/task_model.dart';
import 'entities/task_response_entity.dart';
import 'repository.dart';

class TaskDetailsController extends GetxController with StateMixin<TaskModel> {
  final TaskDetailsRepository _repository;

  TaskDetailsController(this._repository);

  final RxList<TaskResponseEntity> responses = <TaskResponseEntity>[].obs;
  final RxBool isLoadingResponses = false.obs;
  final RxBool isMatching = false.obs;
  final RxString categoryTitle = ''.obs;

  Timer? _shuffleTimer;

  int get taskId => Get.arguments as int;

  @override
  void onInit() {
    super.onInit();
    _fetchTask();
  }

  Future<void> _fetchTask() async {
    change(null, status: RxStatus.loading());
    try {
      final task = await _repository.getTaskById(taskId);
      await _fetchCategory(task.categoryId);
      await _fetchResponses();
      change(task, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> _fetchCategory(int categoryId) async {
    try {
      final category = await _repository.getCategoryById(categoryId);
      categoryTitle.value = category.title;
    } catch (e) {
      categoryTitle.value = 'Unknown';
    }
  }

  Future<void> _fetchResponses() async {
    isLoadingResponses.value = true;
    try {
      final fetchedResponses = await _repository.getTaskResponses(taskId);
      responses.assignAll(fetchedResponses);
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    } finally {
      isLoadingResponses.value = false;
    }
  }

  Future<void> runMatchAlgorithm() async {
    isMatching.value = true;
    _startShuffling();
    try {
      await _repository.runMatchAlgorithm(taskId);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      _stopShuffling();
      await _fetchResponses();
      isMatching.value = false;
    }
  }

  void _startShuffling() {
    _shuffleTimer?.cancel();
    _shuffleTimer = Timer.periodic(const Duration(milliseconds: 400), (_) {
      final List<TaskResponseEntity> shuffled = List.from(responses)..shuffle();
      responses.assignAll(shuffled);
    });
  }

  void _stopShuffling() {
    _shuffleTimer?.cancel();
    _shuffleTimer = null;
  }

  @override
  void onClose() {
    _shuffleTimer?.cancel();
    super.onClose();
  }
}
