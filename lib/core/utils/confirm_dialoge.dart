import 'package:flutter/material.dart';
import 'package:todo_app/core/constants/app_dimensions.dart';

import 'package:todo_app/core/constants/colors.dart';
import 'package:todo_app/core/constants/typography.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/shared/widgets/custom_button.dart';

Future<dynamic> confirmDialoge({
  required BuildContext context,
  required String title,
  String content = "",
  required VoidCallback onPressed,
  required String buttonText,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(AppDimensions.textFiedlBorderRadius)),
          child: Container(
            width: 300,
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius:
                    BorderRadius.circular(AppDimensions.textFiedlBorderRadius),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(12, 26),
                      blurRadius: 50,
                      spreadRadius: 0,
                      color: Colors.grey.withOpacity(.1)),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Text(title, style: AppTypography.dialogeTitle),
                const SizedBox(
                  height: 3.5,
                ),
                Text(content, style: AppTypography.dialogSubTitle),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                        text: "Cnacel",
                        onPressed: () {
                          navigatorKey.currentState!.pop();
                        },
                        invertedColors: true),
                    CustomButton(
                      text: buttonText,
                      onPressed: onPressed,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}
