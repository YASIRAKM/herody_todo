import 'package:flutter/material.dart';
import 'package:todo_app/core/constants/colors.dart';

class LoadingWidget extends StatelessWidget {
  final String? loadingMessage;
  final double? size;
  final Color? color;

  const LoadingWidget({
    super.key,
    this.loadingMessage,
    this.size = 25.0,
    this.color = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(color!),
              strokeWidth: 3.0, // Customize thickness of the spinner
              value: null, // For indefinite loading
              backgroundColor: Colors.transparent, // Transparent background
            ),
          ),
          if (loadingMessage != null) ...[
            const SizedBox(height: 20.0),
            Text(
              loadingMessage!,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: color,
                letterSpacing: 1, // Add letter spacing for a smoother feel
              ),
            ),
          ],
        ],
      ),
    );
  }
}
