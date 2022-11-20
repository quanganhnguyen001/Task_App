import 'package:flutter/material.dart';
import 'package:task_app/screens/completed_task.dart';
import 'package:task_app/screens/drawer_screens.dart';
import 'package:task_app/screens/favourite_task.dart';
import 'package:task_app/screens/pending_screens.dart';

import '../widget/add_task.dart';

class TabScreens extends StatefulWidget {
  TabScreens({Key? key}) : super(key: key);

  static const name = '/tab_screens';

  @override
  State<TabScreens> createState() => _TabScreensState();
}

class _TabScreensState extends State<TabScreens> {
  final List<Map<String, dynamic>> _pageDetails = [
    {'pageName': PendingScreens(), 'title': 'Pending Task'},
    {'pageName': CompletedTask(), 'title': 'Completed Task'},
    {'pageName': FavouriteTask(), 'title': 'Favourite Task'},
  ];

  var _selectedPageIndex = 0;

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: AddTaskScreens(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageDetails[_selectedPageIndex]['title']),
        actions: [
          IconButton(
            onPressed: () {
              _addTask(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: DrawerScreens(),
      body: _pageDetails[_selectedPageIndex]['pageName'],
      floatingActionButton: _selectedPageIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                _addTask(context);
              },
              tooltip: 'Add Task',
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.incomplete_circle_sharp), label: 'Pending Task'),
          BottomNavigationBarItem(
              icon: Icon(Icons.done), label: 'Completed Task'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline), label: 'Favourite Task'),
        ],
      ),
    );
  }
}
