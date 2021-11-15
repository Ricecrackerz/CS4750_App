class TodoModel {
  final int id;
  final int taskId;
  final String title;
  final int isChecked;
  TodoModel({this.id, this.taskId, this.title, this.isChecked});

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'taskId' : taskId,
      'title' : title,
      'isChecked': isChecked,
    };
  }
}