import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/constants/app_dimensions.dart';
import 'package:todo_app/core/constants/typography.dart';
import 'package:todo_app/core/service/responsive.dart';
import 'package:todo_app/core/utils/confirm_dialoge.dart';
import 'package:todo_app/core/utils/date_helper.dart';
import 'package:todo_app/core/utils/show_message.dart';
import 'package:todo_app/core/utils/transparent_dialoge.dart';
import 'package:todo_app/features/tasks/model/task_model.dart';
import 'package:todo_app/features/tasks/view_model.dart/task_view_model.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/shared/widgets/custom_button.dart';
import 'package:todo_app/shared/widgets/custom_date_field.dart';
import 'package:todo_app/shared/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class TaskAddForm extends StatefulWidget {
  Task? task;
  TaskAddForm({super.key, this.task});

  @override
  State<TaskAddForm> createState() => _TaskAddFormState();
}

class _TaskAddFormState extends State<TaskAddForm> {
  final taskName = TextEditingController();

  final description = TextEditingController();
  final deadline = TextEditingController();
  var title = "Add Todo";
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.task != null) {
      taskName.text = widget.task!.taskName;
      description.text = widget.task!.description;
      deadline.text = DateHelper.formatToDDMMYYYY(widget.task!.deadLine);
      title = "Update Todo";
    }

    super.initState();
  }

  @override
  void dispose() {
    taskName.dispose();
    description.dispose();
    deadline.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppResponsive.isMobile(context)
            ? AppDimensions.paddingMedium
            : AppDimensions.paddingSmall,
        right: AppResponsive.isMobile(context)
            ? AppDimensions.paddingMedium
            : AppDimensions.paddingSmall,
        top: AppDimensions.paddingSmall,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
              Text(
                title,
                style: AppTypography.heading2,
              ),
              CustomTextField(
                controller: taskName,
                labelText: "Task name",
                validate: true,
                hintText: "Task",
              ),
              CustomTextField(
                controller: description,
                labelText: "Description",
                validate: true,
                maxLines: 3,
                hintText: "Description ...",
              ),
              CustomDateField(
                controller: deadline,
                labelText: "Deadline",
                hintText: DateHelper.formatToDDMMYYYY(DateTime.now()),
                validate: true,
              ),
              CustomButton(
                  text: title,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      if (widget.task != null) {
                        await updateTask(context);
                      } else {
                        await addTaskMethod(context);
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateTask(BuildContext context) async {
    confirmDialoge(
        context: context,
        title: "Update Task",
        content: "Do you want to update the this task ?",
        onPressed: () async {
          transparentDialog(context);
          Task task = Task(
              id: widget.task!.id,
              taskName: taskName.text,
              description: description.text,
              deadLine: DateHelper.parseFromDDMMYYYY(deadline.text),
              isDone: false,
              createdAt: widget.task!.createdAt);
          (bool, String) res =
              await context.read<TaskViewModel>().updateTask(task);
          if (res.$1) {
            navigatorKey.currentState!.pop();
            navigatorKey.currentState!.pop();
            navigatorKey.currentState!.pop();
            taskName.clear();
            description.clear();
            showMessage(message: "Task Updated");
          } else {
            navigatorKey.currentState!.pop();
            showMessage(message: res.$2);
          }
        },
        buttonText: "Update");
  }

/*Add Task */
  Future<void> addTaskMethod(BuildContext context) async {
    transparentDialog(context);
    Task task = Task(
        deadLine: DateHelper.parseFromDDMMYYYY(deadline.text),
        id: "",
        taskName: taskName.text,
        description: description.text,
        isDone: false,
        createdAt: DateTime.now());
    (bool, String) res = await context.read<TaskViewModel>().addTask(task);
    if (res.$1) {
      navigatorKey.currentState!.pop();
      navigatorKey.currentState!.pop();
      taskName.clear();
      description.clear();
      showMessage(message: "Task added");
    } else {
      navigatorKey.currentState!.pop();
      showMessage(message: res.$2);
    }
  }
}
