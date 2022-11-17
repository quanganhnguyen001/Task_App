import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/blocs/bloc/task_bloc.dart';
import 'package:task_app/screens/home_screens.dart';
import 'package:task_app/screens/recycle_bin.dart';

class DrawerScreens extends StatelessWidget {
  const DrawerScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              color: Colors.grey,
              child: Text(
                'Task Drawer',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, HomeScreens.name),
                  child: ListTile(
                    leading: Icon(Icons.folder_special),
                    title: Text('My Task'),
                    trailing: Text('${state.allTask.length}'),
                  ),
                );
              },
            ),
            Divider(
              color: Colors.grey,
              thickness: 2,
            ),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, RecycleBin.name),
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Recycle Bin'),
                    trailing: Text('${state.removeTask.length}'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
