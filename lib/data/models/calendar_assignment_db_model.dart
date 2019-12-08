class DBAssignment {
  final String id;

  DBAssignment({this.id});

  factory DBAssignment.fromMap(Map<String, dynamic> json) => new DBAssignment(
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
  };
}