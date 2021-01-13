import 'package:to_do_app/models/task_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'task_tile.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class TaskList extends StatelessWidget {
  const TaskList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskRepository>(
      builder: (context, taskRepository, child) {
        return ListView.builder(
            itemCount: taskRepository.taskCount(),
            itemBuilder: (context, index) {
              var task = taskRepository.tasks[index];
              return TaskTile(
                title: task.title,
                isDone: task.isDone,
                onCheckboxClicked: (value) {
                  taskRepository.toggleTask(task);
                },
                onLongPress: () async {
                  if (Platform.isIOS)
                    await showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: Text('Confirmation'),
                          content: Text(
                              'Are you sure to delete ${task.title}?\nThis action is unreversible!'),
                          actions: [
                            CupertinoDialogAction(
                              child: Text('Yes'),
                              onPressed: () {
                                taskRepository.deleteTask(task);
                                Navigator.of(context).pop();
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ));
                  else {
                    await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Confirmation'),
                          content: Text(
                              'Are you sure to delete ${task.title}?\nThis action is unreversible!'),
                          actions: [
                            FlatButton(
                              child: Text('Yes'),
                              onPressed: () {
                                taskRepository.deleteTask(task);
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ));
                  }
                },
              );
            });
      },
    );
  }
}