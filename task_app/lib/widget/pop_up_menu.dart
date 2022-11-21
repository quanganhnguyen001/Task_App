import 'package:flutter/material.dart';

import '../models/task.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({
    Key? key,
    required this.cancelOrDelete,
    required this.favorite,
    required this.task,
    required this.editTask,
  }) : super(key: key);
  final VoidCallback cancelOrDelete;
  final VoidCallback favorite;
  final VoidCallback editTask;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: task.isDeleted == false
            ? ((context) => [
                  PopupMenuItem(
                    child: TextButton.icon(
                        onPressed: editTask,
                        icon: Icon(Icons.edit),
                        label: Text('Edit')),
                    onTap: null,
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                        onPressed: null,
                        icon: task.isFavorite == false
                            ? Icon(Icons.bookmark_add_outlined)
                            : Icon(Icons.bookmark_remove),
                        label: task.isFavorite == false
                            ? Text('Add to Bookmarks')
                            : Text('Remove from Bookmarks')),
                    onTap: favorite,
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.delete),
                        label: Text('Delete')),
                    onTap: cancelOrDelete,
                  ),
                ])
            : (context) => [
                  PopupMenuItem(
                    child: TextButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.restore_from_trash),
                        label: Text('Restore')),
                    onTap: cancelOrDelete,
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.delete_forever),
                        label: Text('Delete Forever')),
                    onTap: cancelOrDelete,
                  ),
                ]);
  }
}
