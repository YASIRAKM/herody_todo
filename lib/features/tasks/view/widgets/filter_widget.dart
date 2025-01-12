import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/constants/app_dimensions.dart';
import 'package:todo_app/core/service/responsive.dart';

import 'package:todo_app/features/tasks/view/widgets/status_select_button.dart';
import 'package:todo_app/features/tasks/view_model.dart/task_view_model.dart';


class StatusSelectWidget extends StatelessWidget {
  StatusSelectWidget({
    super.key,
  });
  final date = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Consumer<TaskViewModel>(builder: (context, taskViewModel, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium),
          child: Column(
            children: [
            
              Row(
                mainAxisAlignment: AppResponsive.isMobile(context)
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                spacing: AppResponsive.isMobile(context) ? 12 : 24,
                children: [
                  StatuSModeFilterButton(
                    isSelected: taskViewModel.showMode == ShowMode.all,
                    title: "All",
                    onPressed: () {
                      taskViewModel.changeStatus(ShowMode.all);
                    },
                  ),
                  StatuSModeFilterButton(
                    isSelected: taskViewModel.showMode == ShowMode.pending,
                    title: "Pending",
                    onPressed: () {
                      taskViewModel.changeStatus(ShowMode.pending);
                    },
                  ),
                  StatuSModeFilterButton(
                    isSelected: taskViewModel.showMode == ShowMode.completed,
                    title: "Completed",
                    onPressed: () {
                      taskViewModel.changeStatus(ShowMode.completed);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      });
    });
  }
}
