import 'package:flutter/material.dart';
import 'package:todo_app/core/constants/app_dimensions.dart';
import 'package:todo_app/core/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool invertedColors;
  const CustomButton(
      {required this.text,
      required this.onPressed,
      this.invertedColors = false,
      super.key});
  final primaryColor = AppColors.buttonPrimary;
  final accentColor = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        style: ButtonStyle(
            elevation: WidgetStateProperty.all(0),
            alignment: Alignment.center,
            side: WidgetStateProperty.all(
                BorderSide(width: 1, color: primaryColor)),
            padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLarge)),
            backgroundColor: WidgetStateProperty.all(
                invertedColors ? accentColor : primaryColor),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.buttonBorderRadius)),
            )),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingSmall),
          child: Text(
            text,
            style: TextStyle(
                color: invertedColors ? primaryColor : accentColor,
                fontSize: 16),
          ),
        ));
  }
}
