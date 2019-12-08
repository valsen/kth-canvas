// To parse this JSON data, do
//
//     final upcomingEvent = upcomingEventFromJson(jsonString);

import 'dart:convert';

List<UpcomingEvent> upcomingEventsFromJson(String str) => List<UpcomingEvent>.from(json.decode(str).map((x) => UpcomingEvent.fromJson(x)));

String upcomingEventToJson(List<UpcomingEvent> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UpcomingEvent {
  String title;
  String description;
  WorkflowState workflowState;
  DateTime createdAt;
  DateTime updatedAt;
  bool allDay;
  DateTime allDayDate;
  dynamic id;
  Type type;
  Assignment assignment;
  String htmlUrl;
  String contextCode;
  DateTime endAt;
  DateTime startAt;
  String url;
  dynamic comments;
  dynamic locationAddress;
  String locationName;
  int childEventsCount;
  String allContextCodes;
  dynamic parentEventId;
  bool hidden;
  List<dynamic> childEvents;
  List<dynamic> duplicates;

  UpcomingEvent({
    this.title,
    this.description,
    this.workflowState,
    this.createdAt,
    this.updatedAt,
    this.allDay,
    this.allDayDate,
    this.id,
    this.type,
    this.assignment,
    this.htmlUrl,
    this.contextCode,
    this.endAt,
    this.startAt,
    this.url,
    this.comments,
    this.locationAddress,
    this.locationName,
    this.childEventsCount,
    this.allContextCodes,
    this.parentEventId,
    this.hidden,
    this.childEvents,
    this.duplicates,
  });

  factory UpcomingEvent.fromJson(Map<String, dynamic> json) => UpcomingEvent(
    title: json["title"],
    description: json["description"] == null ? null : json["description"],
    workflowState: workflowStateValues.map[json["workflow_state"]],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    allDay: json["all_day"],
    allDayDate: json["all_day_date"] == null ? null : DateTime.parse(json["all_day_date"]),
    id: json["id"],
    type: typeValues.map[json["type"]],
    assignment: json["assignment"] == null ? null : Assignment.fromJson(json["assignment"]),
    htmlUrl: json["html_url"],
    contextCode: json["context_code"],
    endAt: DateTime.parse(json["end_at"]),
    startAt: DateTime.parse(json["start_at"]),
    url: json["url"],
    comments: json["comments"],
    locationAddress: json["location_address"],
    locationName: json["location_name"] == null ? null : json["location_name"],
    childEventsCount: json["child_events_count"] == null ? null : json["child_events_count"],
    allContextCodes: json["all_context_codes"] == null ? null : json["all_context_codes"],
    parentEventId: json["parent_event_id"],
    hidden: json["hidden"] == null ? null : json["hidden"],
    childEvents: json["child_events"] == null ? null : List<dynamic>.from(json["child_events"].map((x) => x)),
    duplicates: json["duplicates"] == null ? null : List<dynamic>.from(json["duplicates"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description == null ? null : description,
    "workflow_state": workflowStateValues.reverse[workflowState],
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "all_day": allDay,
    "all_day_date": allDayDate == null ? null : "${allDayDate.year.toString().padLeft(4, '0')}-${allDayDate.month.toString().padLeft(2, '0')}-${allDayDate.day.toString().padLeft(2, '0')}",
    "id": id,
    "type": typeValues.reverse[type],
    "assignment": assignment == null ? null : assignment.toJson(),
    "html_url": htmlUrl,
    "context_code": contextCode,
    "end_at": endAt.toIso8601String(),
    "start_at": startAt.toIso8601String(),
    "url": url,
    "comments": comments,
    "location_address": locationAddress,
    "location_name": locationName == null ? null : locationName,
    "child_events_count": childEventsCount == null ? null : childEventsCount,
    "all_context_codes": allContextCodes,
    "parent_event_id": parentEventId,
    "hidden": hidden == null ? null : hidden,
    "child_events": childEvents == null ? null : List<dynamic>.from(childEvents.map((x) => x)),
    "duplicates": duplicates == null ? null : List<dynamic>.from(duplicates.map((x) => x)),
  };
}


class Assignment {
  int id;
  String description;
  DateTime dueAt;
  DateTime unlockAt;
  DateTime lockAt;
  double pointsPossible;
  String gradingType;
  int assignmentGroupId;
  int gradingStandardId;
  DateTime createdAt;
  DateTime updatedAt;
  bool peerReviews;
  bool automaticPeerReviews;
  int position;
  bool gradeGroupStudentsIndividually;
  bool anonymousPeerReviews;
  int groupCategoryId;
  bool postToSis;
  bool moderatedGrading;
  bool omitFromFinalGrade;
  bool intraGroupPeerReviews;
  bool anonymousInstructorAnnotations;
  bool anonymousGrading;
  bool gradersAnonymousToGraders;
  int graderCount;
  bool graderCommentsVisibleToGraders;
  dynamic finalGraderId;
  bool graderNamesVisibleToFinalGrader;
  int allowedAttempts;
  String secureParams;
  int courseId;
  String name;
  List<String> submissionTypes;
  bool hasSubmittedSubmissions;
  bool dueDateRequired;
  int maxNameLength;
  bool inClosedGradingPeriod;
  bool isQuizAssignment;
  bool canDuplicate;
  dynamic originalCourseId;
  dynamic originalAssignmentId;
  dynamic originalAssignmentName;
  dynamic originalQuizId;
  WorkflowState workflowState;
  bool muted;
  String htmlUrl;
  bool published;
  bool onlyVisibleToOverrides;
  bool lockedForUser;
  String submissionsDownloadUrl;
  bool anonymizeStudents;
  List<String> allowedExtensions;

  Assignment({
    this.id,
    this.description,
    this.dueAt,
    this.unlockAt,
    this.lockAt,
    this.pointsPossible,
    this.gradingType,
    this.assignmentGroupId,
    this.gradingStandardId,
    this.createdAt,
    this.updatedAt,
    this.peerReviews,
    this.automaticPeerReviews,
    this.position,
    this.gradeGroupStudentsIndividually,
    this.anonymousPeerReviews,
    this.groupCategoryId,
    this.postToSis,
    this.moderatedGrading,
    this.omitFromFinalGrade,
    this.intraGroupPeerReviews,
    this.anonymousInstructorAnnotations,
    this.anonymousGrading,
    this.gradersAnonymousToGraders,
    this.graderCount,
    this.graderCommentsVisibleToGraders,
    this.finalGraderId,
    this.graderNamesVisibleToFinalGrader,
    this.allowedAttempts,
    this.secureParams,
    this.courseId,
    this.name,
    this.submissionTypes,
    this.hasSubmittedSubmissions,
    this.dueDateRequired,
    this.maxNameLength,
    this.inClosedGradingPeriod,
    this.isQuizAssignment,
    this.canDuplicate,
    this.originalCourseId,
    this.originalAssignmentId,
    this.originalAssignmentName,
    this.originalQuizId,
    this.workflowState,
    this.muted,
    this.htmlUrl,
    this.published,
    this.onlyVisibleToOverrides,
    this.lockedForUser,
    this.submissionsDownloadUrl,
    this.anonymizeStudents,
    this.allowedExtensions,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
    id: json["id"],
    description: json["description"],
    dueAt: DateTime.parse(json["due_at"]),
    unlockAt: json["unlock_at"] == null ? null : DateTime.parse(json["unlock_at"]),
    lockAt: json["lock_at"] == null ? null : DateTime.parse(json["lock_at"]),
    pointsPossible: json["points_possible"],
    gradingType: json["grading_type"],
    assignmentGroupId: json["assignment_group_id"],
    gradingStandardId: json["grading_standard_id"] == null ? null : json["grading_standard_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    peerReviews: json["peer_reviews"],
    automaticPeerReviews: json["automatic_peer_reviews"],
    position: json["position"],
    gradeGroupStudentsIndividually: json["grade_group_students_individually"],
    anonymousPeerReviews: json["anonymous_peer_reviews"],
    groupCategoryId: json["group_category_id"] == null ? null : json["group_category_id"],
    postToSis: json["post_to_sis"],
    moderatedGrading: json["moderated_grading"],
    omitFromFinalGrade: json["omit_from_final_grade"],
    intraGroupPeerReviews: json["intra_group_peer_reviews"],
    anonymousInstructorAnnotations: json["anonymous_instructor_annotations"],
    anonymousGrading: json["anonymous_grading"],
    gradersAnonymousToGraders: json["graders_anonymous_to_graders"],
    graderCount: json["grader_count"],
    graderCommentsVisibleToGraders: json["grader_comments_visible_to_graders"],
    finalGraderId: json["final_grader_id"],
    graderNamesVisibleToFinalGrader: json["grader_names_visible_to_final_grader"],
    allowedAttempts: json["allowed_attempts"],
    secureParams: json["secure_params"],
    courseId: json["course_id"],
    name: json["name"],
    submissionTypes: List<String>.from(json["submission_types"].map((x) => x)),
    hasSubmittedSubmissions: json["has_submitted_submissions"],
    dueDateRequired: json["due_date_required"],
    maxNameLength: json["max_name_length"],
    inClosedGradingPeriod: json["in_closed_grading_period"],
    isQuizAssignment: json["is_quiz_assignment"],
    canDuplicate: json["can_duplicate"],
    originalCourseId: json["original_course_id"],
    originalAssignmentId: json["original_assignment_id"],
    originalAssignmentName: json["original_assignment_name"],
    originalQuizId: json["original_quiz_id"],
    workflowState: workflowStateValues.map[json["workflow_state"]],
    muted: json["muted"],
    htmlUrl: json["html_url"],
    published: json["published"],
    onlyVisibleToOverrides: json["only_visible_to_overrides"],
    lockedForUser: json["locked_for_user"],
    submissionsDownloadUrl: json["submissions_download_url"],
    anonymizeStudents: json["anonymize_students"],
    allowedExtensions: json["allowed_extensions"] == null ? null : List<String>.from(json["allowed_extensions"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "due_at": dueAt.toIso8601String(),
    "unlock_at": unlockAt == null ? null : unlockAt.toIso8601String(),
    "lock_at": lockAt == null ? null : lockAt.toIso8601String(),
    "points_possible": pointsPossible,
    "grading_type": gradingType,
    "assignment_group_id": assignmentGroupId,
    "grading_standard_id": gradingStandardId == null ? null : gradingStandardId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "peer_reviews": peerReviews,
    "automatic_peer_reviews": automaticPeerReviews,
    "position": position,
    "grade_group_students_individually": gradeGroupStudentsIndividually,
    "anonymous_peer_reviews": anonymousPeerReviews,
    "group_category_id": groupCategoryId == null ? null : groupCategoryId,
    "post_to_sis": postToSis,
    "moderated_grading": moderatedGrading,
    "omit_from_final_grade": omitFromFinalGrade,
    "intra_group_peer_reviews": intraGroupPeerReviews,
    "anonymous_instructor_annotations": anonymousInstructorAnnotations,
    "anonymous_grading": anonymousGrading,
    "graders_anonymous_to_graders": gradersAnonymousToGraders,
    "grader_count": graderCount,
    "grader_comments_visible_to_graders": graderCommentsVisibleToGraders,
    "final_grader_id": finalGraderId,
    "grader_names_visible_to_final_grader": graderNamesVisibleToFinalGrader,
    "allowed_attempts": allowedAttempts,
    "secure_params": secureParams,
    "course_id": courseId,
    "name": name,
    "submission_types": List<dynamic>.from(submissionTypes.map((x) => x)),
    "has_submitted_submissions": hasSubmittedSubmissions,
    "due_date_required": dueDateRequired,
    "max_name_length": maxNameLength,
    "in_closed_grading_period": inClosedGradingPeriod,
    "is_quiz_assignment": isQuizAssignment,
    "can_duplicate": canDuplicate,
    "original_course_id": originalCourseId,
    "original_assignment_id": originalAssignmentId,
    "original_assignment_name": originalAssignmentName,
    "original_quiz_id": originalQuizId,
    "workflow_state": workflowStateValues.reverse[workflowState],
    "muted": muted,
    "html_url": htmlUrl,
    "published": published,
    "only_visible_to_overrides": onlyVisibleToOverrides,
    "locked_for_user": lockedForUser,
    "submissions_download_url": submissionsDownloadUrl,
    "anonymize_students": anonymizeStudents,
    "allowed_extensions": allowedExtensions == null ? null : List<dynamic>.from(allowedExtensions.map((x) => x)),
  };
}

enum WorkflowState { PUBLISHED, ACTIVE }

final workflowStateValues = EnumValues({
  "active": WorkflowState.ACTIVE,
  "published": WorkflowState.PUBLISHED
});

enum Type { ASSIGNMENT, EVENT }

final typeValues = EnumValues({
  "assignment": Type.ASSIGNMENT,
  "event": Type.EVENT
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
