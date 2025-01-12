import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:todo_app/core/constants/app_dimensions.dart';
import 'package:todo_app/core/constants/colors.dart';
import 'package:todo_app/core/constants/typography.dart';
import 'package:todo_app/core/extensions/string_extension.dart';
import 'package:todo_app/core/utils/date_helper.dart';
import 'package:todo_app/features/tasks/model/task_model.dart';

class TaskListCardItem extends StatelessWidget {
  final Task current;
  final VoidCallback toggleTask;
  final Function(String) onSelected;
  const TaskListCardItem(
      {super.key,
      required this.current,
      required this.toggleTask,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.cardBackground,
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 1),
              color: AppColors.linkColor,
              blurRadius: 1,
            ),
            BoxShadow(
              offset: Offset(1, -1),
              color: AppColors.linkColor,
              blurRadius: 1,
            ),
          ],
          borderRadius:
              BorderRadius.circular(AppDimensions.textFiedlBorderRadius)),
      child: ListTile(
          dense: true,
          leading: Icon(
            current.isDone ? Bootstrap.check2_circle : Bootstrap.clock_fill,
            color: current.isDone ? AppColors.success : AppColors.accent,
          ),
          onTap: current.isDone ? null : toggleTask,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                current.taskName.capitalizeFirst,
                style: current.isDone
                    ? AppTypography.titleMarked
                    : AppTypography.title1,
              ),
              Text(
                DateHelper.isToday(current.deadLine)
                    ? "Today"
                    : DateHelper.isTomorrow(current.deadLine)
                        ? "Tomorrow"
                        : DateHelper.formatToDDMMYYYY(
                            current.deadLine,
                          ),
                style: AppTypography.caption,
              ),
            ],
          ),
          subtitle: Text(
            current.description,
            style: AppTypography.subtitle1,
          ),
          trailing: PopupMenuButton<String>(
            icon: Icon(
              EvaIcons.more_vertical,
              color: Colors.black,
            ),
            onSelected: (value) async {
              onSelected(value);
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<String>(
                  value: 'update',
                  child: Row(
                    children: [
                      Icon(
                        FontAwesome.pencil_solid,
                        color: AppColors.focusColor,
                        size: 20.0,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Update',
                        style: AppTypography.label,
                      ),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(
                        Bootstrap.trash,
                        color: AppColors.error,
                        size: 20.0,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Delete',
                        style: AppTypography.label,
                      ),
                    ],
                  ),
                ),
              ];
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: AppColors.secondaryColor,
            elevation: 5,
            padding: EdgeInsets.symmetric(
                vertical: AppDimensions.paddingMedium,
                horizontal: AppDimensions.paddingMedium),
          )),
    );
  }
}
