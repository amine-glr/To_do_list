
class TaskItem {
  String title;
  bool isDone;
  int id;

  TaskItem({this.title, this.id,  this.isDone});
  TaskItem.withId({this.id, this.title,  this.isDone });

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['status'] = isDone;
    return map;
  }

  factory TaskItem.fromMap(Map<String, dynamic> map) {
    return TaskItem.withId(
        id: map['id'],
        title: map['title'],
        isDone: map['isDone']);
  }
}