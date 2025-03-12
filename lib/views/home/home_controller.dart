import 'package:flutter/foundation.dart';
import 'package:todolist/models/task_model.dart';
import 'package:todolist/services/api.dart';

class HomeController extends ChangeNotifier {
  APIService apiService = APIService();
  List<TaskModel> taskList = [];

  HomeController() {
    fetchTaskList();
  }

  Future<void> fetchTaskList() async {
    notifyListeners();

    try {
      final response = await apiService.get('/');
      final tasks = (response['tasks'] as List);

      taskList = tasks.map((task) => TaskModel.fromJson(task)).toList();
    } catch (error) {
      print("Error on fetch tasks: $error");
    } finally {
      notifyListeners();
    }
  }

  Future<void> _postTaskList() async {
    try {
      final Object taskResponse = {
        "tasks": taskList.map((task) => task.toJson()).toList(),
      };

      await apiService.post('/', taskResponse);
    } catch (error) {
      print("Error on Update Tasks: $error");
    } finally {
      notifyListeners();
    }
  }

  void updateTask(TaskModel taskUpdated) {
    taskList =
        taskList
            .map((task) => task.id == taskUpdated.id ? taskUpdated : task)
            .toList();
    _postTaskList();
  }

  void deleteTask(TaskModel taskToDelete) {
    taskList = taskList.where((task) => task.id != taskToDelete.id).toList();
    _postTaskList();
  }

  void insertTask(String description) {
    final newId = taskList.last.id + 1;
    final newTask = TaskModel(id: newId, description: description);

    taskList.add(newTask);
    _postTaskList();
  }
}
