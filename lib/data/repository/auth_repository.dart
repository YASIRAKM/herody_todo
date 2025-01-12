import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/core/constants/strings.dart';
import 'package:todo_app/core/service/shared_preferences_helper.dart';
import 'package:todo_app/data/api/api_end_points.dart';

class AuthRepository {
  static Future<(bool, String)> saveUserDetails(User user) async {
    try {
      String? authToken = await user.getIdToken();

      if (authToken == null || user.uid.isEmpty) {
        return (false, "Invalid token or user UID");
      }

      final url =
          "${ApiEndPoints.realTimeDbUrl}/${user.uid}.json?auth=$authToken";

      Map<String, dynamic> params = {
        "email": user.email,
        "tasks": [],
      };

      final res = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(params),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        SharedPrefHelper.saveValue(AppStringContants.tokenKey, authToken);
        SharedPrefHelper.saveValue(AppStringContants.userIdKey, user.uid);
        return (true, "User details saved successfully");
      } else {
        return (false, "Failed to save user details. Code: ${res.statusCode}");
      }
    } catch (e) {
      return (false, "Error: ${e.toString()}");
    }
  }
}
