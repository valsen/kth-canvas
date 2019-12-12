class Todo {
  final int id;
  final String title;
  final String type;
  final DateTime startAt;
  final int courseId;
  final bool active;

  Todo({this.id, this.title, this.type, this.startAt, this.courseId, this.active});

  Todo copyWith({int id, String titile, String type, DateTime startAt, int courseId, bool active}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      startAt: startAt ?? this.startAt,
      courseId: courseId ?? this.courseId,
      active: active ?? this.active
    );
  }

  factory Todo.fromUpcomingMap(Map<String, dynamic> json) => new Todo(
        id: json["id"] is int
            ? json["id"]
            : int.parse((json["id"] as String)
            .substring(11)), //remove 'assignment_'
        title: json["title"],
        type: json["type"],
        startAt: DateTime.parse(json["start_at"].toString()),
        courseId: int.parse(
            (json["context_code"] as String).substring(7)), //remove 'course_'
        active: true
    );

  factory Todo.fromAssignmentMap(Map<String, dynamic> json) => new Todo(
      id: json["id"],
      title: json["title"],
      type: "assignment",
      startAt: json["due_at"] == null ?  null : DateTime.parse(json["due_at"].toString()),
      courseId: json["course_id"],
      active: true
  );

  factory Todo.fromLocalMap(Map<String, dynamic> json) => new Todo(
      id: json["id"],
      title: json["title"],
      type: json["type"],
      startAt: DateTime.parse(json["start_at"].toString()),
      courseId: json["context_code"],
      active: json["active"] == 1 ? true : false
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "type": type,
    "start_at": startAt.toIso8601String(),
    "course_id": courseId,
    "active": active ? 1 : 0
  };

  @override
  List<Object> get props => [
    id,
  ];

}