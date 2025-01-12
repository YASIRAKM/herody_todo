import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/constants/colors.dart';
import 'package:todo_app/core/constants/strings.dart';
import 'package:todo_app/core/constants/typography.dart';
import 'package:todo_app/core/service/shared_preferences_helper.dart';
import 'package:todo_app/features/authentication/view/auth_view.dart';
import 'package:todo_app/features/authentication/view_model/auth_view_model.dart';
import 'package:todo_app/features/tasks/view/tasks_view.dart';
import 'package:todo_app/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    final authProvider = Provider.of<AuthViewModel>(context, listen: false);
    await Future.delayed(Duration(seconds: 3));
    String userId =
        await SharedPrefHelper.getValue(AppStringContants.userIdKey) ?? "";
    if (authProvider.user != null && userId.isNotEmpty) {
      navigatorKey.currentState!.pushAndRemoveUntil(
        CupertinoPageRoute(
          builder: (context) => TasksView(),
        ),
        (route) => false,
      );
    } else {
      navigatorKey.currentState!.pushAndRemoveUntil(
        CupertinoPageRoute(
          builder: (context) => AuthView(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "TO DO App",
              style: AppTypography.splashText,
            ),
            CupertinoActivityIndicator(
              color: AppColors.secondaryColor,
              animating: true,
            )
          ],
        ),
      ),
    );
  }
}
