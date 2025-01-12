import 'package:flutter/material.dart';
import 'package:todo_app/core/constants/app_dimensions.dart';
import 'package:todo_app/core/constants/colors.dart';
import 'package:todo_app/core/constants/typography.dart';

void transparentDialog(BuildContext context,
    {bool barrierDismissible = false}) {
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: AppColors.primaryColor.withOpacity(0.5),
    builder: (context) {
      return Center(
        child: Container(
          width: 140,
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingLarge,
              vertical: AppDimensions.paddingMedium),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: AppColors.focusColor,
              ),
              const SizedBox(height: 16),
              const Text(
                'Loading...',
                style: AppTypography.title1,
              ),
            ],
          ),
        ),
      );
    },
  );
}
