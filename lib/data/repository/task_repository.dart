import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_app/core/constants/strings.dart';
import 'package:todo_app/core/service/shared_preferences_helper.dart';
import 'package:todo_app/data/api/api_end_points.dart';
import 'package:todo_app/features/tasks/model/task_model.dart';

class TaskRepository {
  /// Add a task to the user's task list
  static Future<(bool, String)> addTask({required Task task}) async {
    try {
      String userId =
          await SharedPrefHelper.getValue(AppStringContants.userIdKey) ?? "";
      String authToken =
          await SharedPrefHelper.getValue(AppStringContants.tokenKey) ?? "";

      final url =
          "${ApiEndPoints.realTimeDbUrl}/$userId/tasks.json?auth=$authToken";

      final res = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(task.toMap()),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        return (true, "Task added successfully");
      } else {
        return (false, "Failed to add task. Code: ${res.statusCode}");
      }
    } catch (e) {
      return (false, "Error: ${e.toString()}");
    }
  }

  /// Get tasks assigned to the user
  static Future<List<Task>?> getTasks() async {
    try {
      String userId =
          await SharedPrefHelper.getValue(AppStringContants.userIdKey) ?? "";
      String authToken =
          await SharedPrefHelper.getValue(AppStringContants.tokenKey) ?? "";

      final url =
          "${ApiEndPoints.realTimeDbUrl}/$userId/tasks.json?auth=$authToken";

      final res = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (res.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(res.body);

        List<Task> tasks = [];
        data.forEach((key, value) {
          tasks.add(Task.fromMap(key, value));
        });

        return tasks;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Mark a task as done (set isDone to true)
  static Future<(bool, String)> markTaskAsDone({
    required String taskId,
  }) async {
    try {
      String userId =
          await SharedPrefHelper.getValue(AppStringContants.userIdKey) ?? "";
      String authToken =
          await SharedPrefHelper.getValue(AppStringContants.tokenKey) ?? "";

      final url =
          "${ApiEndPoints.realTimeDbUrl}/$userId/tasks/$taskId.json?auth=$authToken";

      Map<String, dynamic> updatedTask = {
        "isDone": true, // Mark as done
      };

      final res = await http.patch(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(updatedTask),
      );

      if (res.statusCode == 200) {
        return (true, "Task marked as done successfully");
      } else {
        return (false, "Failed to mark task as done. Code: ${res.statusCode}");
      }
    } catch (e) {
      return (false, "Error: ${e.toString()}");
    }
  }

  /// Update a task details
  static Future<(bool, String)> updateTaskDetails({
    required Task updatedTask,
  }) async {
    try {
      String userId =
          await SharedPrefHelper.getValue(AppStringContants.userIdKey) ?? "";
      String authToken =
          await SharedPrefHelper.getValue(AppStringContants.tokenKey) ?? "";

      final url =
          "${ApiEndPoints.realTimeDbUrl}/$userId/tasks/${updatedTask.id}.json?auth=$authToken";

      final res = await http.patch(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: updatedTask.toJson(),
      );

      if (res.statusCode == 200) {
        return (true, "Task details updated successfully");
      } else {
        return (false, "Failed to update task. Code: ${res.statusCode}");
      }
    } catch (e) {
      return (false, "Error: ${e.toString()}");
    }
  }

  /// Delete a task by its ID
  static Future<(bool, String)> deleteTask({required String taskId}) async {
    try {
      String userId =
          await SharedPrefHelper.getValue(AppStringContants.userIdKey) ?? "";
      String authToken =
          await SharedPrefHelper.getValue(AppStringContants.tokenKey) ?? "";

      final url =
          "${ApiEndPoints.realTimeDbUrl}/$userId/tasks/$taskId.json?auth=$authToken";

      final res = await http.delete(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (res.statusCode == 200) {
        return (true, "Task deleted successfully");
      } else {
        return (false, "Failed to delete task. Code: ${res.statusCode}");
      }
    } catch (e) {
      return (false, "Error: ${e.toString()}");
    }
  }
}
