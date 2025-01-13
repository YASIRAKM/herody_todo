import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/constants/app_dimensions.dart';
import 'package:todo_app/core/constants/typography.dart';
import 'package:todo_app/core/service/responsive.dart';
import 'package:todo_app/core/utils/show_message.dart';
import 'package:todo_app/core/utils/transparent_dialoge.dart';
import 'package:todo_app/features/authentication/view_model/auth_view_model.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/shared/widgets/custom_button.dart';
import 'package:todo_app/shared/widgets/custom_text_field.dart';

class ResetPasswordWidget extends StatefulWidget {
  const ResetPasswordWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ResetPasswordWidgetState createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  final _resetMail = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _resetMail.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppResponsive.isMobile(context)
            ? AppDimensions.paddingMedium
            : AppDimensions.paddingSmall,
        right: AppResponsive.isMobile(context)
            ? AppDimensions.paddingMedium
            : AppDimensions.paddingSmall,
        top: AppDimensions.paddingSmall,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
              SizedBox(
                height: 24,
              ),
              Text(
                "Enter your mail",
                style: AppTypography.title1,
              ),
              Text(
                "Enter your email address to reset your password. A reset link will be sent to your email.",
                style: AppTypography.bodyText,
              ),
              CustomTextField(
                controller: _resetMail,
                labelText: "Email",
                validate: true,
                filled: true,
                hintText: "Enter email for resetting password",
              ),
              CustomButton(
                text: "Reset Password",
                onPressed: () async {
                  await _resetMailValidation(context);
                },
              ),
              SizedBox(
                height: 24,
              )
            ],
          ),
        ),
      ),
    );
  }

// reset mail fuction
  Future<void> _resetMailValidation(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      transparentDialog(context);
      bool res = await context
          .read<AuthViewModel>()
          .resetPassword(_resetMail.text.trim());
      if (res) {
        navigatorKey.currentState!.pop();
        navigatorKey.currentState!.pop();
        showMessage(message: "Reset link has been sent to the mail.");
      } else {
        navigatorKey.currentState!.pop();
        showMessage(message: "Failed to send link.");
      }
    }
  }
}
