import 'package:flutter/cupertino.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:todo_app/core/constants/colors.dart';
import 'package:todo_app/core/constants/typography.dart';

class NoDataWidget extends StatelessWidget {
  final String? message;
  final double? iconSize;
  final Color? iconColor;

  const NoDataWidget({
    super.key,
    this.message = "No data available",
    this.iconSize = 50.0,
    this.iconColor = AppColors.textFildFillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            EvaIcons.inbox_outline,
            size: iconSize,
            color: iconColor,
          ),
          const SizedBox(height: 10.0),
          Text(
            message!,
            textAlign: TextAlign.center,
            style: AppTypography.dialogSubTitle,
          ),
        ],
      ),
    );
  }
}
