import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bloc/task_bloc.dart';
import '../models/task.dart';

class AddTaskScreens extends StatefulWidget {
  AddTaskScreens({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTaskScreens> createState() => _AddTaskScreensState();
}

class _AddTaskScreensState extends State<AddTaskScreens> {
  TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Add Task',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                label: Text('Title'),
                border: OutlineInputBorder(),
              ),
              controller: _titleController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel')),
                ElevatedButton(
                    onPressed: () {
                      var task = Task(title: _titleController.text);
                      context.read<TaskBloc>().add(AddTask(task: task));
                      Navigator.pop(context);
                    },
                    child: Text('Add')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
