class Task {
  int id;
  String title;
  bool isDone;
  Task({this.id = 0, required this.title, required this.isDone});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
    };
  }
}
