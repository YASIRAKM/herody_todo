import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/constants/app_dimensions.dart';
import 'package:todo_app/core/constants/colors.dart';
import 'package:todo_app/core/constants/typography.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/shared/widgets/custom_button.dart';

class ErrorViewWidget extends StatelessWidget {
  final String errorMessage;
  final Widget widget;

  const ErrorViewWidget({
    super.key,
    required this.errorMessage,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingLarge,
            vertical: AppDimensions.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              color: AppColors.error,
              size: 50.0,
            ),
            const SizedBox(height: 16.0),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: AppTypography.errorText,
            ),
            const SizedBox(height: 20.0),
            CustomButton(
              onPressed: () {
                navigatorKey.currentState!.pushAndRemoveUntil(
                  CupertinoDialogRoute(
                    context: context,
                    builder: (context) => widget,
                  ),
                  (route) => false,
                );
                // Handle retry or other action
              },
              text: 'Retry',
            ),
          ],
        ),
      ),
    );
  }
}
