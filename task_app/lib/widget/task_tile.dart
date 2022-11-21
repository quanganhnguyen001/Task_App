import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_app/screens/edit_task.dart';
import 'package:task_app/widget/pop_up_menu.dart';

import '../blocs/task_bloc/task_bloc.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  void _removeOrDelete(BuildContext context, Task task) {
    task.isDeleted!
        ? context.read<TaskBloc>().add(DeleteTask(task: task))
        : context.read<TaskBloc>().add(RemoveTask(task: task));
  }

  void _editTask(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: EditTaskSCreens(
              oldTask: task,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                task.isFavorite == false
                    ? Icon(Icons.star_outline)
                    : Icon(Icons.star),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            decoration: task.isDone!
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                      Text(DateFormat()
                          .add_yMMMMd()
                          .add_Hms()
                          .format(DateTime.parse(task.date))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: task.isDeleted == false
                    ? (value) {
                        context.read<TaskBloc>().add(UpdateTask(task: task));
                      }
                    : null,
              ),
              PopUpMenu(
                cancelOrDelete: () {
                  _removeOrDelete(context, task);
                },
                task: task,
                favorite: () {
                  context.read<TaskBloc>().add(MarkFavorite(task: task));
                },
                editTask: () {
                  _editTask(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
