class Todo {
  final int id;
  final String title;

  Todo({this.id, this.title});

  factory Todo.fromMap(Map<String, dynamic> json) => new Todo(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
  };
}