import 'package:todo_app/core/extensions/string_extension.dart';

String? validateField(label, String value) {
  if (value.isEmpty) {
    return "$label is required";
  }

  if (label == "Email" && !value.isValidEmail) {
    return "Enter a valid email";
  }

  if (label == "Password" && value.length < 6) {
    return "Password should be at least 6 characters";
  }

  return null;
}
