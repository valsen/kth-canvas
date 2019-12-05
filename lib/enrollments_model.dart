// To parse this JSON data, do
//
//     final enrollments = enrollmentsFromJson(jsonString);

import 'dart:convert';

List<CanvasEnrollment> enrollmentsFromJson(String str) => List<CanvasEnrollment>.from(json.decode(str).map((x) => CanvasEnrollment.fromJson(x)));

String enrollmentsToJson(List<CanvasEnrollment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CanvasEnrollment {
  int id;
  int userId;
  int courseId;
  Role type;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic associatedUserId;
  dynamic startAt;
  dynamic endAt;
  int courseSectionId;
  int rootAccountId;
  bool limitPrivilegesToCourseSection;
  EnrollmentState enrollmentState;
  Role role;
  int roleId;
  DateTime lastActivityAt;
  dynamic lastAttendedAt;
  int totalActivityTime;
  Grades grades;
  String htmlUrl;
  User user;

  CanvasEnrollment({
    this.id,
    this.userId,
    this.courseId,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.associatedUserId,
    this.startAt,
    this.endAt,
    this.courseSectionId,
    this.rootAccountId,
    this.limitPrivilegesToCourseSection,
    this.enrollmentState,
    this.role,
    this.roleId,
    this.lastActivityAt,
    this.lastAttendedAt,
    this.totalActivityTime,
    this.grades,
    this.htmlUrl,
    this.user,
  });

  factory CanvasEnrollment.fromJson(Map<String, dynamic> json) => CanvasEnrollment(
    id: json["id"],
    userId: json["user_id"],
    courseId: json["course_id"],
    type: roleValues.map[json["type"]],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    associatedUserId: json["associated_user_id"],
    startAt: json["start_at"],
    endAt: json["end_at"],
    courseSectionId: json["course_section_id"],
    rootAccountId: json["root_account_id"],
    limitPrivilegesToCourseSection: json["limit_privileges_to_course_section"],
    enrollmentState: enrollmentStateValues.map[json["enrollment_state"]],
    role: roleValues.map[json["role"]],
    roleId: json["role_id"],
    lastActivityAt: DateTime.parse(json["last_activity_at"]),
    lastAttendedAt: json["last_attended_at"],
    totalActivityTime: json["total_activity_time"],
    grades: Grades.fromJson(json["grades"]),
    htmlUrl: json["html_url"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "course_id": courseId,
    "type": roleValues.reverse[type],
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "associated_user_id": associatedUserId,
    "start_at": startAt,
    "end_at": endAt,
    "course_section_id": courseSectionId,
    "root_account_id": rootAccountId,
    "limit_privileges_to_course_section": limitPrivilegesToCourseSection,
    "enrollment_state": enrollmentStateValues.reverse[enrollmentState],
    "role": roleValues.reverse[role],
    "role_id": roleId,
    "last_activity_at": lastActivityAt.toIso8601String(),
    "last_attended_at": lastAttendedAt,
    "total_activity_time": totalActivityTime,
    "grades": grades.toJson(),
    "html_url": htmlUrl,
    "user": user.toJson(),
  };
}

enum EnrollmentState { ACTIVE }

final enrollmentStateValues = EnumValues({
  "active": EnrollmentState.ACTIVE
});

class Grades {
  String htmlUrl;
  dynamic currentGrade;
  double currentScore;
  dynamic finalGrade;
  double finalScore;

  Grades({
    this.htmlUrl,
    this.currentGrade,
    this.currentScore,
    this.finalGrade,
    this.finalScore,
  });

  factory Grades.fromJson(Map<String, dynamic> json) => Grades(
    htmlUrl: json["html_url"],
    currentGrade: json["current_grade"],
    currentScore: json["current_score"] == null ? null : json["current_score"].toDouble(),
    finalGrade: json["final_grade"],
    finalScore: json["final_score"] == null ? null : json["final_score"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "html_url": htmlUrl,
    "current_grade": currentGrade,
    "current_score": currentScore == null ? null : currentScore,
    "final_grade": finalGrade,
    "final_score": finalScore == null ? null : finalScore,
  };
}

enum Role { STUDENT_ENROLLMENT }

final roleValues = EnumValues({
  "StudentEnrollment": Role.STUDENT_ENROLLMENT
});

class User {
  int id;
  Name name;
  DateTime createdAt;
  SortableName sortableName;
  Name shortName;
  LoginId loginId;

  User({
    this.id,
    this.name,
    this.createdAt,
    this.sortableName,
    this.shortName,
    this.loginId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: nameValues.map[json["name"]],
    createdAt: DateTime.parse(json["created_at"]),
    sortableName: sortableNameValues.map[json["sortable_name"]],
    shortName: nameValues.map[json["short_name"]],
    loginId: loginIdValues.map[json["login_id"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
    "created_at": createdAt.toIso8601String(),
    "sortable_name": sortableNameValues.reverse[sortableName],
    "short_name": nameValues.reverse[shortName],
    "login_id": loginIdValues.reverse[loginId],
  };
}

enum LoginId { VALS_KTH_SE }

final loginIdValues = EnumValues({
  "vals@kth.se": LoginId.VALS_KTH_SE
});

enum Name { VICTOR_JOSEPHSON }

final nameValues = EnumValues({
  "Victor Josephson": Name.VICTOR_JOSEPHSON
});

enum SortableName { JOSEPHSON_VICTOR }

final sortableNameValues = EnumValues({
  "Josephson, Victor": SortableName.JOSEPHSON_VICTOR
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
