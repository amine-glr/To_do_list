import 'package:to_do_app/models/task_repository.dart';
import 'package:to_do_app/screens/add_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/widgets/task_list.dart';

import 'package:to_do_app/models/task_item.dart';
import 'package:to_do_app/Database/Database.dart';
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<List<TaskItem>> _taskList;
  @override
  void initState() {
    super.initState();
    _updateTaskList();
  }
  _updateTaskList() {
    setState(() {
      _taskList = databaseHelper.instance.getTaskList();
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.add),
        onPressed: () {
          print('floating action button pressed');
          showModalBottomSheet(
              context: context, builder: (context) => AddTaskScreen());
        },
      ),

      body: FutureBuilder(

        future: _taskList,
        builder: (context, snapshot){
          final int completedTaskCount = snapshot.data
              .where((TaskItem task) => task.isDone == true)
              .toList()
              .length;
          final int incompletedTaskCount = snapshot.data
              .where((TaskItem task) => task.isDone == false)
              .toList()
              .length;
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

        else{
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 60, left: 20, right: 30, bottom: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    child: Icon(
                      Icons.list,
                      size: 30,
                      color: Colors.lightBlueAccent,
                    ),
                    backgroundColor: Colors.white,
                  ),

                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cet Todo',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3.0,
                          color: Colors.white),
                    ),
                    Text(
                      '$completedTaskCount of ${snapshot.data.length} Tasks ($incompletedTaskCount of ${snapshot.data.length} Incomplete)',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                ]
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: TaskList(),
              ),
            )
          ],
        );
        }
        }
      ),

    );
  }
}