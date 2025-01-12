import 'package:flutter/material.dart';
import 'package:todo_app/core/constants/app_dimensions.dart';

import 'package:todo_app/core/constants/colors.dart';
import 'package:todo_app/core/constants/typography.dart';
import 'package:todo_app/main.dart';

showMessage({required String message}) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        const Icon(
          Icons.info_outline,
          color: AppColors.background,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            message,
            style: AppTypography.button,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
    backgroundColor: AppColors.primaryColor.withRed(20),
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.circular(AppDimensions.textFiedlBorderRadius * 2),
    ),
    padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.paddingMedium,
        horizontal: AppDimensions.paddingLarge),
  );

  return scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
}
