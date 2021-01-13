import 'package:flutter/cupertino.dart';
import 'package:to_do_app/models/task_item.dart';



class TaskRepository extends ChangeNotifier{
  List<TaskItem> tasks= [];
  TaskRepository(){
    addTask(TaskItem(title: "Cet 301 Project", isDone: false));
    addTask(TaskItem(title: "Cet 341 Project", isDone: false));
    addTask(TaskItem(title: "Sced Project", isDone: true));

  }

  int taskCount(){
    return tasks.length;
  }

  int incompleteTaskCount(){
    return
      tasks.where( (t) => !t.isDone).length;
  }


  void addTask(TaskItem task){
    tasks.add(task);
    notifyListeners();
  }
  void toggleTask(TaskItem task){
    task.isDone = !task.isDone;
    notifyListeners();
  }
  void deleteTask(TaskItem task){
    tasks.remove(task);
    notifyListeners();
  }
}