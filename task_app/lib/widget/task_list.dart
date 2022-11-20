import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/widget/task_tile.dart';
import '../models/task.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    Key? key,
    required this.taskList,
  }) : super(key: key);

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    // return Expanded(
    //   child: ListView.builder(
    //       itemCount: taskList.length,
    //       itemBuilder: (context, index) {
    //         var task = taskList[index];
    //         return TaskTile(task: task);
    //       }),
    // );
    return Expanded(
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: taskList
              .map(
                (task) => ExpansionPanelRadio(
                  value: task.id,
                  headerBuilder: (context, isOpen) {
                    return TaskTile(task: task);
                  },
                  body: ListTile(
                    title: SelectableText.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Text\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: task.title,
                          ),
                          TextSpan(
                            text: '\n\nDescription\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: task.description),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
