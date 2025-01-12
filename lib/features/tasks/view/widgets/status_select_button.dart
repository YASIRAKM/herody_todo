import 'package:flutter/material.dart';
import 'package:todo_app/core/constants/app_dimensions.dart';
import 'package:todo_app/core/constants/colors.dart';
import 'package:todo_app/core/constants/typography.dart';

class StatuSModeFilterButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool isSelected;
  const StatuSModeFilterButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(
        title,
        style: isSelected ? AppTypography.button : AppTypography.bodyText,
      ),
      onPressed: onPressed,
      clipBehavior: Clip.none,
      side: BorderSide.none,
      backgroundColor:
          isSelected ? AppColors.buttonPrimary : AppColors.textFildFillColor,
      shape: ContinuousRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppDimensions.buttonBorderRadius)),
    );

  }
}
