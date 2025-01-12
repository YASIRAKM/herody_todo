import 'package:flutter/material.dart';
import 'colors.dart';

class AppTypography {
  // Slash
  static const TextStyle splashText = TextStyle(
    fontSize: 32.0,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    color: AppColors.secondaryColor,
  );
  // Headings
  static const TextStyle heading1 = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

// dialoge Texts
  static const dialogeTitle = TextStyle(
      color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold);
  static const dialogSubTitle = TextStyle(
      color: AppColors.linkColor, fontSize: 12, fontWeight: FontWeight.w300);
  // Titles
  static const TextStyle title1 = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
  static const TextStyle titleMarked = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
      decoration: TextDecoration.lineThrough);

  static const TextStyle subtitle1 = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  // Body Text

  static const TextStyle bodyText = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // Caption
  static const TextStyle caption = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w300,
    color: AppColors.textSecondary,
  );

  // Buttons
  static const TextStyle button = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: AppColors.buttonText,
  );

  // Input Field (TextFormField)
  static const TextStyle inputField = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  // Labels
  static const TextStyle label = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );
  //hints
  static const TextStyle hint = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    color: AppColors.textHint,
  );
  //error text
  static const TextStyle errorText = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: AppColors.error,
  );
}
