import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/blocs/switch_bloc/switch_bloc.dart';

import 'package:task_app/screens/pending_screens.dart';
import 'package:task_app/screens/recycle_bin.dart';
import 'package:task_app/screens/tab_screens.dart';

import '../blocs/task_bloc/task_bloc.dart';

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
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, TabScreens.name),
                  child: ListTile(
                    leading: Icon(Icons.folder_special),
                    title: Text('My Task'),
                    trailing: Text('${state.pendingTask.length}'),
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
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, RecycleBin.name),
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Recycle Bin'),
                    trailing: Text('${state.removeTask.length}'),
                  ),
                );
              },
            ),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                return Switch(
                    value: state.switchValue,
                    onChanged: (newValue) {
                      newValue
                          ? context.read<SwitchBloc>().add(SwitchOnEvent())
                          : context.read<SwitchBloc>().add(SwitchOffEvent());
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
