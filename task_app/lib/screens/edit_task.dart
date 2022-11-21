import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/services/guid_gen.dart';

import '../blocs/task_bloc/task_bloc.dart';
import '../models/task.dart';

class EditTaskSCreens extends StatelessWidget {
  EditTaskSCreens({
    Key? key,
    required this.oldTask,
  }) : super(key: key);
  final Task oldTask;

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController =
        TextEditingController(text: oldTask.title);
    TextEditingController _descriptionController =
        TextEditingController(text: oldTask.description);
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Edit Task',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  label: Text('Title'),
                  border: OutlineInputBorder(),
                ),
                controller: _titleController,
              ),
            ),
            TextField(
              autofocus: true,
              minLines: 3,
              maxLines: 5,
              decoration: InputDecoration(
                label: Text('Description'),
                border: OutlineInputBorder(),
              ),
              controller: _descriptionController,
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
                      var editTask = Task(
                          title: _titleController.text,
                          id: oldTask.id,
                          isDone: false,
                          isFavorite: oldTask.isFavorite,
                          description: _descriptionController.text,
                          date: DateTime.now().toString());
                      context
                          .read<TaskBloc>()
                          .add(EditTask(oldTask: oldTask, newTask: editTask));
                      Navigator.pop(context);
                    },
                    child: Text('Save')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
