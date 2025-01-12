import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:todo_app/core/constants/app_dimensions.dart';
import 'package:todo_app/core/constants/colors.dart';
import 'package:todo_app/core/constants/typography.dart';
import 'package:todo_app/core/utils/validation.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final double? borderRadius;
  final double? borderWidth;
  final bool? filled;
  final String? hintText;
  final String labelText;
  final IconData? prefixIcon;
  final bool? isPassword;
  final bool? validate;
  final int? maxLines;
  final bool? autofocus;

  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? focusedErrorBorderColor;

  const CustomTextField({
    super.key,
    required this.controller,
    this.borderRadius,
    this.borderWidth,
    this.filled,
    this.hintText,
    required this.labelText,
    this.prefixIcon,
    this.isPassword,
    this.validate,
    this.maxLines,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.focusedErrorBorderColor,
    this.autofocus,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autofocus ?? false,
      maxLines: widget.maxLines ?? 1,
      controller: widget.controller,
      obscureText: (widget.isPassword ?? false) ? !showPassword : false,
      obscuringCharacter: "*",
      validator: (widget.validate ?? false)
          ? (value) {
              return validateField(widget.labelText, value ?? "");
            }
          : null,
      style: AppTypography.inputField,
      decoration: InputDecoration(
        suffixIcon: (widget.isPassword ?? false)
            ? IconButton(
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                icon: Icon(
                  showPassword ? EvaIcons.eye_off : EvaIcons.eye,
                ),
              )
            : null,
        hintText: widget.hintText,
        hintStyle: AppTypography.hint,
        labelText: widget.labelText,
        labelStyle: AppTypography.label,
        prefixIcon: widget.prefixIcon == null ? null : Icon(widget.prefixIcon),
        filled: widget.filled ?? false,
        fillColor: AppColors.textFildFillColor,
        border: _buildBorder(),
        enabledBorder: _buildBorder(
          color: widget.enabledBorderColor ?? Colors.grey,
        ),
        focusedBorder: _buildBorder(
          color: widget.focusedBorderColor ?? AppColors.focusColor,
          width: 2.0,
        ),
        errorBorder: _buildBorder(
          color: widget.errorBorderColor ?? AppColors.error,
        ),
        focusedErrorBorder: _buildBorder(
          color: widget.focusedErrorBorderColor ?? AppColors.error.withAlpha(5),
          width: 2.0,
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder({Color? color, double? width}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        widget.borderRadius ?? AppDimensions.textFiedlBorderRadius,
      ),
      borderSide: BorderSide(
        color: color ?? Colors.transparent,
        width: width ?? widget.borderWidth ?? AppDimensions.borderWidth,
      ),
    );
  }
}
