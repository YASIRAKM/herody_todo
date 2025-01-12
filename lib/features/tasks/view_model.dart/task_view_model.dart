import 'package:flutter/material.dart';
import 'package:todo_app/data/repository/task_repository.dart';
import 'package:todo_app/features/tasks/model/task_model.dart';

enum ShowMode { all, completed, pending }

class TaskViewModel extends ChangeNotifier {
  ShowMode _showMode = ShowMode.all;

  ShowMode get showMode => _showMode;

  changeStatus(ShowMode showMode) {
    _showMode = showMode;
    notifyListeners();
  }

  Future<(bool, String)> addTask(Task task) async {
    try {
      (bool, String) res = await TaskRepository.addTask(task: task);
      notifyListeners();
      return res;
    } catch (e) {
      return (false, e.toString());
    }
  }

  Future<List<Task>> fetchTask() async {
    try {
      List<Task> tasks = await TaskRepository.getTasks() ?? [];

      return tasks.where(
        (e) {
          bool statusMatch = _showMode == ShowMode.pending
              ? e.isDone == false
              : _showMode == ShowMode.completed
                  ? e.isDone == true
                  : e.isDone == true || e.isDone == false;

          return statusMatch;
        },
      ).toList();
    } catch (e) {
      return [];
    }
  }

  Future<(bool, String)> markAsDone(String taskId) async {
    try {
      (bool, String) res = await TaskRepository.markTaskAsDone(taskId: taskId);
      notifyListeners();
      return res;
    } catch (e) {
      return (false, e.toString());
    }
  }

  Future<(bool, String)> updateTask(Task task) async {
    try {
      (bool, String) res =
          await TaskRepository.updateTaskDetails(updatedTask: task);
      notifyListeners();
      return res;
    } catch (e) {
      return (false, e.toString());
    }
  }

  Future<(bool, String)> deleteTask(String taskId) async {
    try {
      (bool, String) res = await TaskRepository.deleteTask(taskId: taskId);
      notifyListeners();
      return res;
    } catch (e) {
      return (false, e.toString());
    }
  }
}
