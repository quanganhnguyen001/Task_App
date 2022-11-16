import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/blocs/bloc/task_bloc.dart';
import 'package:task_app/models/task.dart';

import '../widget/add_task.dart';
import '../widget/task_list.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({Key? key}) : super(key: key);

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: AddTaskScreens(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Task> taskList = state.allTask;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tasks App'),
            actions: [
              IconButton(
                onPressed: () {
                  _addTask(context);
                },
                icon: const Icon(Icons.add),
              )
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text(
                    'Tasks:',
                  ),
                ),
              ),
              TaskList(taskList: taskList),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _addTask(context);
            },
            tooltip: 'Add Task',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
