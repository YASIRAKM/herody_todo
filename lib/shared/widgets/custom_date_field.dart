import 'package:flutter/material.dart';

import 'package:todo_app/core/constants/app_dimensions.dart';
import 'package:todo_app/core/constants/typography.dart';
import 'package:todo_app/core/utils/date_helper.dart';
import 'package:todo_app/core/utils/validation.dart';

class CustomDateField extends StatefulWidget {
  final TextEditingController controller;
  final double? borderRadius;
  final double? borderWidth;
  final bool? filled;
  final String? hintText;
  final String labelText;
  final bool? validate;

  // Custom border colors
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? focusedErrorBorderColor;

  const CustomDateField({
    super.key,
    required this.controller,
    this.borderRadius,
    this.borderWidth,
    this.filled,
    this.hintText,
    required this.labelText,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.validate,
    this.focusedErrorBorderColor,
  });

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      widget.controller.text = DateHelper.formatToDDMMYYYY(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (widget.validate ?? false)
          ? (value) {
              return validateField(widget.labelText, value ?? "");
            }
          : null,
      readOnly: true,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () {
            _selectDate(context);
          },
        ),
        hintText: widget.hintText,
        labelText: widget.labelText,
        hintStyle: AppTypography.hint,
        filled: widget.filled ?? false,
        fillColor: widget.filled == true ? Colors.grey[200] : null,
        border: _buildBorder(),
        enabledBorder: _buildBorder(
          color: widget.enabledBorderColor ?? Colors.grey,
        ),
        focusedBorder: _buildBorder(
          color: widget.focusedBorderColor ?? Colors.blue,
          width: 2.0,
        ),
        errorBorder: _buildBorder(
          color: widget.errorBorderColor ?? Colors.red,
        ),
        focusedErrorBorder: _buildBorder(
          color: widget.focusedErrorBorderColor ?? Colors.red.shade700,
          width: 2.0,
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder({Color? color, double? width}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        widget.borderRadius ?? 12.0,
      ),
      borderSide: BorderSide(
        color: color ?? Colors.transparent,
        width: width ?? widget.borderWidth ?? AppDimensions.borderWidth,
      ),
    );
  }
}
