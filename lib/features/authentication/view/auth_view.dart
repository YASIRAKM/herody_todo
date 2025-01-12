import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/constants/app_dimensions.dart';
import 'package:todo_app/core/constants/colors.dart';

import 'package:todo_app/core/constants/typography.dart';
import 'package:todo_app/core/service/responsive.dart';
import 'package:todo_app/core/utils/show_message.dart';
import 'package:todo_app/core/utils/transparent_dialoge.dart';
import 'package:todo_app/features/authentication/view_model/auth_view_model.dart';
import 'package:todo_app/features/authentication/widgets/reset_password.dart';
import 'package:todo_app/features/tasks/view/tasks_view.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/shared/widgets/custom_button.dart';
import 'package:todo_app/shared/widgets/custom_text_field.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final ValueNotifier<bool> isRegister = ValueNotifier(false);

  final name = TextEditingController();

  final email = TextEditingController();

  final password = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Dispose controllers to free up memory
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Consumer<AuthViewModel>(builder: (context, authViewModel, child) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium,
              vertical: AppDimensions.marginSmall),
          child: Form(
            key: formKey,
            child: Center(
              child: SizedBox(
                width: AppResponsive.isMobile(context)
                    ? double.maxFinite
                    : MediaQuery.sizeOf(context).width * .5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: AppDimensions.paddingSmall,
                  children: [
                    Text(
                      authViewModel.isRegister ? "Sign Up" : "Sign In",
                      style: AppTypography.heading1,
                    ),
                    SizedBox(
                      height: 48,
                    ),
                    CustomTextField(
                      validate: true,
                      labelText: "Email",
                      controller: email,
                      filled: true,
                      hintText: "Enter your mail",
                    ),
                    CustomTextField(
                      validate: true,
                      labelText: "Password",
                      controller: password,
                      filled: true,
                      hintText: "Enter password",
                      isPassword: true,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            AppResponsive.isMobile(context)
                                ? showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return ResetPasswordWidget();
                                    },
                                  )
                                : showAdaptiveDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: ResetPasswordWidget(),
                                      );
                                    },
                                  );
                          },
                          child: Text("Forgot password ?")),
                    ),
                    CustomButton(
                      onPressed: () async {
                        transparentDialog(context);
                        if (formKey.currentState!.validate()) {
                          if (authViewModel.isRegister) {
                            await signUpMethod(authViewModel);
                          } else {
                            await loginMethod(authViewModel);
                          }
                        } else {
                          navigatorKey.currentState!.pop();
                        }
                      },
                      text: authViewModel.isRegister ? "Sign Up" : "Sign In",
                    ),
                    TextButton(
                      onPressed: () {
                        authViewModel.switchLoginSignup();
                      },
                      child: RichText(
                        text: TextSpan(
                          text: authViewModel.isRegister
                              ? "Already hava an account ? "
                              : "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.grey[700], // Neutral text color
                            fontSize: 14.0,
                          ),
                          children: [
                            TextSpan(
                              text: authViewModel.isRegister
                                  ? "sign In"
                                  : "Sign Up",
                              style: TextStyle(
                                color: AppColors.focusColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  ///login
  Future<void> loginMethod(AuthViewModel authViewModel) async {
    (bool, String) res =
        await authViewModel.login(email.text.trim(), password.text.trim());

    if (res.$1) {
      navigatorKey.currentState!.pop();
      navigatorKey.currentState!.pushAndRemoveUntil(
        CupertinoPageRoute(
          builder: (context) => TasksView(),
        ),
        (route) => false,
      );
    } else {
      navigatorKey.currentState!.pop();
      showMessage(message: res.$2);
    }
  }

  ///sign in
  Future<void> signUpMethod(AuthViewModel authViewModel) async {
    (bool, String) res =
        await authViewModel.register(email.text.trim(), password.text.trim());
    if (res.$1) {
      navigatorKey.currentState!.pop();
      navigatorKey.currentState!.pushAndRemoveUntil(
        CupertinoPageRoute(
          builder: (context) => TasksView(),
        ),
        (route) => false,
      );
    } else {
      navigatorKey.currentState!.pop();
      showMessage(message: res.$2);
    }
  }
}
