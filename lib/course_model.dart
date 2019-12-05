// To parse this JSON data, do
//
//     final course = courseFromJson(jsonString);

import 'dart:convert';

Course courseFromJson(String str) => Course.fromJson(json.decode(str));

String courseToJson(Course data) => json.encode(data.toJson());

class Course {
  int id;
  String name;
  int accountId;
  String uuid;
  DateTime startAt;
  dynamic gradingStandardId;
  bool isPublic;
  DateTime createdAt;
  String courseCode;
  String defaultView;
  int rootAccountId;
  int enrollmentTermId;
  String license;
  dynamic gradePassbackSetting;
  dynamic endAt;
  bool publicSyllabus;
  bool publicSyllabusToAuth;
  int storageQuotaMb;
  bool isPublicToAuthUsers;
  bool applyAssignmentGroupWeights;
  Calendar calendar;
  String timeZone;
  bool blueprint;
  List<Enrollment> enrollments;
  bool hideFinalGrades;
  String workflowState;
  bool restrictEnrollmentsToCourseDates;
  String overriddenCourseVisibility;

  Course({
    this.id,
    this.name,
    this.accountId,
    this.uuid,
    this.startAt,
    this.gradingStandardId,
    this.isPublic,
    this.createdAt,
    this.courseCode,
    this.defaultView,
    this.rootAccountId,
    this.enrollmentTermId,
    this.license,
    this.gradePassbackSetting,
    this.endAt,
    this.publicSyllabus,
    this.publicSyllabusToAuth,
    this.storageQuotaMb,
    this.isPublicToAuthUsers,
    this.applyAssignmentGroupWeights,
    this.calendar,
    this.timeZone,
    this.blueprint,
    this.enrollments,
    this.hideFinalGrades,
    this.workflowState,
    this.restrictEnrollmentsToCourseDates,
    this.overriddenCourseVisibility,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json["id"],
    name: json["name"],
    accountId: json["account_id"],
    uuid: json["uuid"],
    startAt: DateTime.parse(json["start_at"]),
    gradingStandardId: json["grading_standard_id"],
    isPublic: json["is_public"],
    createdAt: DateTime.parse(json["created_at"]),
    courseCode: json["course_code"],
    defaultView: json["default_view"],
    rootAccountId: json["root_account_id"],
    enrollmentTermId: json["enrollment_term_id"],
    license: json["license"],
    gradePassbackSetting: json["grade_passback_setting"],
    endAt: json["end_at"],
    publicSyllabus: json["public_syllabus"],
    publicSyllabusToAuth: json["public_syllabus_to_auth"],
    storageQuotaMb: json["storage_quota_mb"],
    isPublicToAuthUsers: json["is_public_to_auth_users"],
    applyAssignmentGroupWeights: json["apply_assignment_group_weights"],
    calendar: Calendar.fromJson(json["calendar"]),
    timeZone: json["time_zone"],
    blueprint: json["blueprint"],
    enrollments: List<Enrollment>.from(json["enrollments"].map((x) => Enrollment.fromJson(x))),
    hideFinalGrades: json["hide_final_grades"],
    workflowState: json["workflow_state"],
    restrictEnrollmentsToCourseDates: json["restrict_enrollments_to_course_dates"],
    overriddenCourseVisibility: json["overridden_course_visibility"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "account_id": accountId,
    "uuid": uuid,
    "start_at": startAt.toIso8601String(),
    "grading_standard_id": gradingStandardId,
    "is_public": isPublic,
    "created_at": createdAt.toIso8601String(),
    "course_code": courseCode,
    "default_view": defaultView,
    "root_account_id": rootAccountId,
    "enrollment_term_id": enrollmentTermId,
    "license": license,
    "grade_passback_setting": gradePassbackSetting,
    "end_at": endAt,
    "public_syllabus": publicSyllabus,
    "public_syllabus_to_auth": publicSyllabusToAuth,
    "storage_quota_mb": storageQuotaMb,
    "is_public_to_auth_users": isPublicToAuthUsers,
    "apply_assignment_group_weights": applyAssignmentGroupWeights,
    "calendar": calendar.toJson(),
    "time_zone": timeZone,
    "blueprint": blueprint,
    "enrollments": List<dynamic>.from(enrollments.map((x) => x.toJson())),
    "hide_final_grades": hideFinalGrades,
    "workflow_state": workflowState,
    "restrict_enrollments_to_course_dates": restrictEnrollmentsToCourseDates,
    "overridden_course_visibility": overriddenCourseVisibility,
  };
}

class Calendar {
  String ics;

  Calendar({
    this.ics,
  });

  factory Calendar.fromJson(Map<String, dynamic> json) => Calendar(
    ics: json["ics"],
  );

  Map<String, dynamic> toJson() => {
    "ics": ics,
  };
}

class Enrollment {
  String type;
  String role;
  int roleId;
  int userId;
  String enrollmentState;
  bool limitPrivilegesToCourseSection;

  Enrollment({
    this.type,
    this.role,
    this.roleId,
    this.userId,
    this.enrollmentState,
    this.limitPrivilegesToCourseSection,
  });

  factory Enrollment.fromJson(Map<String, dynamic> json) => Enrollment(
    type: json["type"],
    role: json["role"],
    roleId: json["role_id"],
    userId: json["user_id"],
    enrollmentState: json["enrollment_state"],
    limitPrivilegesToCourseSection: json["limit_privileges_to_course_section"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "role": role,
    "role_id": roleId,
    "user_id": userId,
    "enrollment_state": enrollmentState,
    "limit_privileges_to_course_section": limitPrivilegesToCourseSection,
  };
}
