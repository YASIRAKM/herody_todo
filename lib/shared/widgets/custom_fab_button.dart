
import 'package:flutter/material.dart';
import 'package:todo_app/core/constants/app_dimensions.dart';
import 'package:todo_app/core/constants/colors.dart';
import 'package:todo_app/core/constants/typography.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String title;
  const FloatingActionButtonWidget({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius:
            BorderRadius.circular(AppDimensions.textFiedlBorderRadius * 3),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: AppColors.secondaryColor,
              size: 30,
            ),
            Text(
              title,
              style: AppTypography.button,
            ),
          ],
        ),
      ),
    );
  }
}