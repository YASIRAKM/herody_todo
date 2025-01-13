import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/constants/app_dimensions.dart';
import 'package:todo_app/core/constants/colors.dart';
import 'package:todo_app/core/constants/typography.dart';
import 'package:todo_app/core/service/responsive.dart';
import 'package:todo_app/core/utils/confirm_dialoge.dart';
import 'package:todo_app/core/utils/show_message.dart';
import 'package:todo_app/core/utils/transparent_dialoge.dart';
import 'package:todo_app/features/authentication/view_model/auth_view_model.dart';
import 'package:todo_app/features/tasks/model/task_model.dart';
import 'package:todo_app/features/tasks/view/widgets/add_task.dart';
import 'package:todo_app/features/tasks/view/widgets/filter_widget.dart';
import 'package:todo_app/features/tasks/view/widgets/task_list_card_item.dart';
import 'package:todo_app/features/tasks/view_model.dart/task_view_model.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/shared/widgets/custom_fab_button.dart';
import 'package:todo_app/shared/widgets/error_widget.dart';
import 'package:todo_app/shared/widgets/loading_widget.dart';
import 'package:todo_app/shared/widgets/no_data_widget.dart';
import 'package:todo_app/splash.dart';

class TasksView extends StatelessWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskViewModel>(
      builder: (context, taskViewModel, child) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: AppColors.background,
                title: Text(
                  "Tasks",
                  style: AppTypography.heading2,
                ),
                actions: [
                  _logoutMethod(context),
                  SizedBox(
                    width: 18,
                  )
                ],
                bottom: PreferredSize(
                    preferredSize: Size(double.maxFinite, 40),
                    child: StatusSelectWidget()),
              ),
              SliverToBoxAdapter(
                child: FutureBuilder(
                  future: taskViewModel.fetchTask(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppDimensions.paddingLarge * 10),
                        child: LoadingWidget(
                          loadingMessage: "Loading Tasks ... ",
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppDimensions.paddingLarge * 10),
                        child: ErrorViewWidget(
                          widget: TasksView(),
                          errorMessage: "Error while loading task",
                        ),
                      );
                    }
                    return snapshot.data!.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: AppDimensions.paddingLarge * 10),
                            child: NoDataWidget(
                              message: taskViewModel.showMode ==
                                      ShowMode.completed
                                  ? "No completed tasks available ."
                                  : taskViewModel.showMode == ShowMode.pending
                                      ? "No pending tasks available."
                                      : "No tasks available .",
                            ),
                          )
                        : AppResponsive.isMobile(context)
                            ? ListView.separated(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppDimensions.paddingMedium,
                                    vertical: AppDimensions.paddingSmall),
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: AppDimensions.marginMedium,
                                  );
                                },
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  Task current = snapshot.data![index];
                                  return _listCardItem(
                                      current, context, taskViewModel);
                                },
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppDimensions.paddingMedium,
                                    vertical: AppDimensions.paddingMedium),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 10,
                                        childAspectRatio:
                                            AppResponsive.isTab(context)
                                                ? 5
                                                : 7,
                                        mainAxisSpacing: 10,
                                        crossAxisCount: 2),
                                itemBuilder: (context, index) {
                                  Task current = snapshot.data![index];
                                  return _listCardItem(
                                      current, context, taskViewModel);
                                },
                                itemCount: snapshot.data!.length,
                              );
                  },
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButtonWidget(
            onPressed: () {
              _addUpdateTask(context);
            },
            icon: EvaIcons.plus_circle_outline,
            title: "Add Task",
          ),
        );
      },
    );
  }

  // task item
  TaskListCardItem _listCardItem(
      Task current, BuildContext context, TaskViewModel taskViewModel) {
    return TaskListCardItem(
      current: current,
      toggleTask: () async {
        await _toggleMethod(context, taskViewModel, current);
      },
      onSelected: (value) async {
        switch (value) {
          case 'update':
            await _addUpdateTask(context, current);
            break;
          case 'delete':
            await _deleteTaskMethod(context, taskViewModel, current);
            break;
          default:
            break;
        }
      },
    );
  }

// logout
  InkWell _logoutMethod(BuildContext context) {
    return InkWell(
        onTap: () {
          confirmDialoge(
              context: context,
              title: "Logout",
              onPressed: () async {
                transparentDialog(context);
                bool res = await context.read<AuthViewModel>().logout();
                if (res) {
                  navigatorKey.currentState!.pushAndRemoveUntil(
                    CupertinoPageRoute(
                      builder: (context) => SplashScreen(),
                    ),
                    (route) => false,
                  );
                } else {
                  navigatorKey.currentState!.pop();
                  showMessage(message: "Failed to logout");
                }
              },
              buttonText: "Logout",
              content: "Do you want to log out ?");
        },
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.error)),
          child: Icon(
            EvaIcons.log_out,
            size: 25,
            color: AppColors.error,
          ),
        ));
  }

  //Toggle task
  Future<void> _toggleMethod(
      BuildContext context, TaskViewModel taskViewModel, Task current) async {
    confirmDialoge(
        context: context,
        title: "Mark as Done",
        content: "Is this task completed ?",
        onPressed: () async {
          transparentDialog(context);
          (bool, String) res = await taskViewModel.markAsDone(current.id);
          if (res.$1) {
            navigatorKey.currentState!.pop();
            navigatorKey.currentState!.pop();
          } else {
            navigatorKey.currentState!.pop();
            showMessage(message: res.$2);
          }
        },
        buttonText: "Done");
  }

  /// delete task
  Future<void> _deleteTaskMethod(
      BuildContext context, TaskViewModel taskViewModel, Task current) async {
    confirmDialoge(
        context: context,
        title: "Delete Task",
        onPressed: () async {
          transparentDialog(context);
          (bool, String) res = await taskViewModel.deleteTask(current.id);
          if (res.$1) {
            showMessage(message: res.$2);
            navigatorKey.currentState!.pop();
            navigatorKey.currentState!.pop();
          } else {
            navigatorKey.currentState!.pop();
            showMessage(message: res.$2);
          }
        },
        content: "Do you want to delete this task ?",
        buttonText: "Delete");
  }

// add update task
  _addUpdateTask(BuildContext context, [Task? task]) {
    if (task != null && task.isDone) {
      showMessage(message: "Editing a completed task is not allowed");
    } else {
      return AppResponsive.isMobile(context)
          ? showModalBottomSheet(
              context: context,
              builder: (context) {
                return TaskAddForm(
                  task: task,
                );
              },
            )
          : showAdaptiveDialog(
              context: context,
              builder: (context) {
                return AspectRatio(
                  aspectRatio: 7.5,
                  child: AlertDialog(
                      title: TaskAddForm(
                    task: task,
                  )),
                );
              },
            );
    }
  }
}
