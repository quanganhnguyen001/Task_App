import 'package:flutter/material.dart';
import 'package:task_app/blocs/bloc/task_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/task.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    Key? key,
    required this.taskList,
  }) : super(key: key);

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: taskList.length,
          itemBuilder: (context, index) {
            var task = taskList[index];
            return ListTile(
              title: Text(task.title),
              trailing: Checkbox(
                value: task.isDone,
                onChanged: (value) {
                  context.read<TaskBloc>().add(UpdateTask(task: task));
                },
              ),
            );
          }),
    );
  }
}
