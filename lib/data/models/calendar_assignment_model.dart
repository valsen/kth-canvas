// To parse this JSON data, do
//
//     final calendarAssignment = calendarAssignmentFromJson(jsonString);

import 'dart:convert';

List<CalendarAssignment> calendarAssignmentsFromJson(String str) => List<CalendarAssignment>.from(json.decode(str).map((x) => CalendarAssignment.fromJson(x)));

String calendarAssignmentToJson(List<CalendarAssignment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CalendarAssignment {
  String title;
//  WorkflowState workflowState;
//  DateTime createdAt;
//  DateTime updatedAt;
//  bool allDay;
  DateTime allDayDate;
  String id;
//  Type type;
  Assignment assignment;
//  String htmlUrl;
//  ContextCode contextCode;
//  DateTime endAt;
//  DateTime startAt;
//  String url;
//  LockInfo lockInfo;

  CalendarAssignment({
    this.title,
//    this.workflowState,
//    this.createdAt,
//    this.updatedAt,
//    this.allDay,
    this.allDayDate,
    this.id,
//    this.type,
    this.assignment,
//    this.htmlUrl,
//    this.contextCode,
//    this.endAt,
//    this.startAt,
//    this.url,
//    this.lockInfo,
  });

  factory CalendarAssignment.fromJson(Map<String, dynamic> json) {
    return CalendarAssignment(
      title: json["title"],
//      workflowState: workflowStateValues.map[json["workflow_state"]],
//      createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime(1900),
//      updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : DateTime(1900),
//      allDay: json["all_day"],
      allDayDate: json["all_day_date"] != null ? DateTime.parse(json["all_day_date"]) : DateTime(1900),
      id: json["id"],
//      type: typeValues.map[json["type"]],
      assignment: Assignment.fromJson(json["assignment"]),
//      htmlUrl: json["html_url"],
//      contextCode: contextCodeValues.map[json["context_code"]],
//      endAt: json["end_at"] != null ? DateTime.parse(json["end_at"]) : DateTime(1900),
//      startAt: json["start_at"] != null ? DateTime.parse(json["start_at"]) : DateTime(1900),
//      url: json["url"],
//      lockInfo: json["lock_info"] == null ? null : LockInfo.fromJson(
//          json["lock_info"]),
    );
  }


  Map<String, dynamic> toJson() => {
    "title": title,
//    "workflow_state": workflowStateValues.reverse[workflowState],
//    "created_at": createdAt.toIso8601String(),
//    "updated_at": updatedAt.toIso8601String(),
//    "all_day": allDay,
    "all_day_date": "${allDayDate.year.toString().padLeft(4, '0')}-${allDayDate.month.toString().padLeft(2, '0')}-${allDayDate.day.toString().padLeft(2, '0')}",
    "id": id,
//    "type": typeValues.reverse[type],
    "assignment": assignment.toJson(),
//    "html_url": htmlUrl,
//    "context_code": contextCodeValues.reverse[contextCode],
//    "end_at": endAt.toIso8601String(),
//    "start_at": startAt.toIso8601String(),
//    "url": url,
//    "lock_info": lockInfo == null ? null : lockInfo.toJson(),
  };
}

class Assignment {
  int id;
//  String description;
  DateTime dueAt;
//  DateTime unlockAt;
//  dynamic lockAt;
//  double pointsPossible;
//  GradingType gradingType;
//  int assignmentGroupId;
//  dynamic gradingStandardId;
//  DateTime createdAt;
//  DateTime updatedAt;
//  bool peerReviews;
//  bool automaticPeerReviews;
//  int position;
//  bool gradeGroupStudentsIndividually;
//  bool anonymousPeerReviews;
//  int groupCategoryId;
//  bool postToSis;
//  bool moderatedGrading;
//  bool omitFromFinalGrade;
//  bool intraGroupPeerReviews;
//  bool anonymousInstructorAnnotations;
//  bool anonymousGrading;
//  bool gradersAnonymousToGraders;
//  int graderCount;
//  bool graderCommentsVisibleToGraders;
//  dynamic finalGraderId;
//  bool graderNamesVisibleToFinalGrader;
//  int allowedAttempts;
//  String secureParams;
//  int courseId;
//  String name;
//  List<SubmissionType> submissionTypes;
//  bool hasSubmittedSubmissions;
//  bool dueDateRequired;
//  int maxNameLength;
//  bool inClosedGradingPeriod;
  bool userSubmitted;
//  bool isQuizAssignment;
//  bool canDuplicate;
//  dynamic originalCourseId;
//  dynamic originalAssignmentId;
//  dynamic originalAssignmentName;
//  dynamic originalQuizId;
//  WorkflowState workflowState;
//  bool muted;
//  String htmlUrl;
//  bool published;
//  bool onlyVisibleToOverrides;
//  bool lockedForUser;
//  String submissionsDownloadUrl;
//  bool anonymizeStudents;
//  LockInfo lockInfo;
//  List<String> allowedExtensions;
//  String lockExplanation;

  Assignment({
    this.id,
//    this.description,
    this.dueAt,
//    this.unlockAt,
//    this.lockAt,
//    this.pointsPossible,
//    this.gradingType,
//    this.assignmentGroupId,
//    this.gradingStandardId,
//    this.createdAt,
//    this.updatedAt,
//    this.peerReviews,
//    this.automaticPeerReviews,
//    this.position,
//    this.gradeGroupStudentsIndividually,
//    this.anonymousPeerReviews,
//    this.groupCategoryId,
//    this.postToSis,
//    this.moderatedGrading,
//    this.omitFromFinalGrade,
//    this.intraGroupPeerReviews,
//    this.anonymousInstructorAnnotations,
//    this.anonymousGrading,
//    this.gradersAnonymousToGraders,
//    this.graderCount,
//    this.graderCommentsVisibleToGraders,
//    this.finalGraderId,
//    this.graderNamesVisibleToFinalGrader,
//    this.allowedAttempts,
//    this.secureParams,
//    this.courseId,
//    this.name,
//    this.submissionTypes,
//    this.hasSubmittedSubmissions,
//    this.dueDateRequired,
//    this.maxNameLength,
//    this.inClosedGradingPeriod,
    this.userSubmitted,
//    this.isQuizAssignment,
//    this.canDuplicate,
//    this.originalCourseId,
//    this.originalAssignmentId,
//    this.originalAssignmentName,
//    this.originalQuizId,
//    this.workflowState,
//    this.muted,
//    this.htmlUrl,
//    this.published,
//    this.onlyVisibleToOverrides,
//    this.lockedForUser,
//    this.submissionsDownloadUrl,
//    this.anonymizeStudents,
//    this.lockInfo,
//    this.allowedExtensions,
//    this.lockExplanation,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
    id: json["id"],
//    description: json["description"] == null ? null : json["description"],
    dueAt: json["due_at"] != null ? DateTime.parse(json["due_at"]) : DateTime(1900),
//    unlockAt: json["unlock_at"] == null ? null : DateTime.parse(json["unlock_at"]),
//    lockAt: json["lock_at"],
//    pointsPossible: json["points_possible"],
//    gradingType: gradingTypeValues.map[json["grading_type"]],
//    assignmentGroupId: json["assignment_group_id"],
//    gradingStandardId: json["grading_standard_id"],
//    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime(1900),
//    updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : DateTime(1900),
//    peerReviews: json["peer_reviews"],
//    automaticPeerReviews: json["automatic_peer_reviews"],
//    position: json["position"],
//    gradeGroupStudentsIndividually: json["grade_group_students_individually"],
//    anonymousPeerReviews: json["anonymous_peer_reviews"],
//    groupCategoryId: json["group_category_id"] == null ? null : json["group_category_id"],
//    postToSis: json["post_to_sis"],
//    moderatedGrading: json["moderated_grading"],
//    omitFromFinalGrade: json["omit_from_final_grade"],
//    intraGroupPeerReviews: json["intra_group_peer_reviews"],
//    anonymousInstructorAnnotations: json["anonymous_instructor_annotations"],
//    anonymousGrading: json["anonymous_grading"],
//    gradersAnonymousToGraders: json["graders_anonymous_to_graders"],
//    graderCount: json["grader_count"],
//    graderCommentsVisibleToGraders: json["grader_comments_visible_to_graders"],
//    finalGraderId: json["final_grader_id"],
//    graderNamesVisibleToFinalGrader: json["grader_names_visible_to_final_grader"],
//    allowedAttempts: json["allowed_attempts"],
//    secureParams: json["secure_params"],
//    courseId: json["course_id"],
//    name: json["name"],
//    submissionTypes: List<SubmissionType>.from(json["submission_types"].map((x) => submissionTypeValues.map[x])),
//    hasSubmittedSubmissions: json["has_submitted_submissions"],
//    dueDateRequired: json["due_date_required"],
//    maxNameLength: json["max_name_length"],
//    inClosedGradingPeriod: json["in_closed_grading_period"],
    userSubmitted: json["user_submitted"],
//    isQuizAssignment: json["is_quiz_assignment"],
//    canDuplicate: json["can_duplicate"],
//    originalCourseId: json["original_course_id"],
//    originalAssignmentId: json["original_assignment_id"],
//    originalAssignmentName: json["original_assignment_name"],
//    originalQuizId: json["original_quiz_id"],
//    workflowState: workflowStateValues.map[json["workflow_state"]],
//    muted: json["muted"],
//    htmlUrl: json["html_url"],
//    published: json["published"],
//    onlyVisibleToOverrides: json["only_visible_to_overrides"],
//    lockedForUser: json["locked_for_user"],
//    submissionsDownloadUrl: json["submissions_download_url"],
//    anonymizeStudents: json["anonymize_students"],
//    lockInfo: json["lock_info"] == null ? null : LockInfo.fromJson(json["lock_info"]),
//    allowedExtensions: json["allowed_extensions"] == null ? null : List<String>.from(json["allowed_extensions"].map((x) => x)),
//    lockExplanation: json["lock_explanation"] == null ? null : json["lock_explanation"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
//    "description": description == null ? null : description,
    "due_at": dueAt.toIso8601String(),
//    "unlock_at": unlockAt == null ? null : unlockAt.toIso8601String(),
//    "lock_at": lockAt,
//    "points_possible": pointsPossible,
//    "grading_type": gradingTypeValues.reverse[gradingType],
//    "assignment_group_id": assignmentGroupId,
//    "grading_standard_id": gradingStandardId,
//    "created_at": createdAt.toIso8601String(),
//    "updated_at": updatedAt.toIso8601String(),
//    "peer_reviews": peerReviews,
//    "automatic_peer_reviews": automaticPeerReviews,
//    "position": position,
//    "grade_group_students_individually": gradeGroupStudentsIndividually,
//    "anonymous_peer_reviews": anonymousPeerReviews,
//    "group_category_id": groupCategoryId == null ? null : groupCategoryId,
//    "post_to_sis": postToSis,
//    "moderated_grading": moderatedGrading,
//    "omit_from_final_grade": omitFromFinalGrade,
//    "intra_group_peer_reviews": intraGroupPeerReviews,
//    "anonymous_instructor_annotations": anonymousInstructorAnnotations,
//    "anonymous_grading": anonymousGrading,
//    "graders_anonymous_to_graders": gradersAnonymousToGraders,
//    "grader_count": graderCount,
//    "grader_comments_visible_to_graders": graderCommentsVisibleToGraders,
//    "final_grader_id": finalGraderId,
//    "grader_names_visible_to_final_grader": graderNamesVisibleToFinalGrader,
//    "allowed_attempts": allowedAttempts,
//    "secure_params": secureParams,
//    "course_id": courseId,
//    "name": name,
//    "submission_types": List<dynamic>.from(submissionTypes.map((x) => submissionTypeValues.reverse[x])),
//    "has_submitted_submissions": hasSubmittedSubmissions,
//    "due_date_required": dueDateRequired,
//    "max_name_length": maxNameLength,
//    "in_closed_grading_period": inClosedGradingPeriod,
    "user_submitted": userSubmitted,
//    "is_quiz_assignment": isQuizAssignment,
//    "can_duplicate": canDuplicate,
//    "original_course_id": originalCourseId,
//    "original_assignment_id": originalAssignmentId,
//    "original_assignment_name": originalAssignmentName,
//    "original_quiz_id": originalQuizId,
//    "workflow_state": workflowStateValues.reverse[workflowState],
//    "muted": muted,
//    "html_url": htmlUrl,
//    "published": published,
//    "only_visible_to_overrides": onlyVisibleToOverrides,
//    "locked_for_user": lockedForUser,
//    "submissions_download_url": submissionsDownloadUrl,
//    "anonymize_students": anonymizeStudents,
//    "lock_info": lockInfo == null ? null : lockInfo.toJson(),
//    "allowed_extensions": allowedExtensions == null ? null : List<dynamic>.from(allowedExtensions.map((x) => x)),
//    "lock_explanation": lockExplanation == null ? null : lockExplanation,
  };
}

enum GradingType { PASS_FAIL, LETTER_GRADE }

final gradingTypeValues = EnumValues({
  "letter_grade": GradingType.LETTER_GRADE,
  "pass_fail": GradingType.PASS_FAIL
});

class LockInfo {
  DateTime unlockAt;
  String assetString;

  LockInfo({
    this.unlockAt,
    this.assetString,
  });

  factory LockInfo.fromJson(Map<String, dynamic> json) => LockInfo(
    unlockAt: json["unlock_at"] != null ? DateTime.parse(json["unlock_at"]) : DateTime(1900),
    assetString: json["asset_string"],
  );

  Map<String, dynamic> toJson() => {
    "unlock_at": unlockAt.toIso8601String(),
    "asset_string": assetString,
  };
}

enum SubmissionType { ONLINE_UPLOAD }

final submissionTypeValues = EnumValues({
  "online_upload": SubmissionType.ONLINE_UPLOAD
});

// enum WorkflowState { PUBLISHED }

// final workflowStateValues = EnumValues({
//   "published": WorkflowState.PUBLISHED
// });

enum ContextCode { COURSE_16720 }

final contextCodeValues = EnumValues({
  "course_16720": ContextCode.COURSE_16720
});

enum Type { ASSIGNMENT }

final typeValues = EnumValues({
  "assignment": Type.ASSIGNMENT
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
