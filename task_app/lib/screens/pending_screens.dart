import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task_app/models/task.dart';
import 'package:task_app/screens/drawer_screens.dart';

import '../blocs/task_bloc/task_bloc.dart';
import 'add_task.dart';
import '../widget/task_list.dart';

class PendingScreens extends StatelessWidget {
  const PendingScreens({Key? key}) : super(key: key);
  static const name = '/task_screens';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Task> taskList = state.pendingTask;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text(
                  'Pending Task: ${taskList.length}',
                ),
              ),
            ),
            TaskList(taskList: taskList),
          ],
        );
      },
    );
  }
}
