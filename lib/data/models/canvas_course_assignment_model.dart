// // To parse this JSON data, do
// //
// //     final assignment = assignmentFromJson(jsonString);

// import 'dart:convert';

// List<CourseAssignment> assignmentsFromJson(String str) => List<CourseAssignment>.from(json.decode(str).map((x) => CourseAssignment.fromJson(x)));

// String assignmentToJson(List<CourseAssignment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class CourseAssignment {
//   int id;
// //  String description;
//   DateTime dueAt;
//   // dynamic unlockAt;
//   // dynamic lockAt;
//   // double pointsPossible;
//   // GradingType gradingType;
//   // int assignmentGroupId;
//   // dynamic gradingStandardId;
//   // DateTime createdAt;
//   // DateTime updatedAt;
//   // bool peerReviews;
//   // bool automaticPeerReviews;
//   // int position;
//   // bool gradeGroupStudentsIndividually;
//   // bool anonymousPeerReviews;
//   // int groupCategoryId;
//   // bool postToSis;
//   // bool moderatedGrading;
//   // bool omitFromFinalGrade;
//   // bool intraGroupPeerReviews;
//   // bool anonymousInstructorAnnotations;
//   // bool anonymousGrading;
//   // bool gradersAnonymousToGraders;
//   // int graderCount;
//   // bool graderCommentsVisibleToGraders;
//   // dynamic finalGraderId;
//   // bool graderNamesVisibleToFinalGrader;
//   // int allowedAttempts;
//   // String secureParams;
//   int courseId;
//   String name;
//   List<SubmissionType> submissionTypes;
//   bool hasSubmittedSubmissions;
//   bool dueDateRequired;
//   int maxNameLength;
//   bool inClosedGradingPeriod;
//   bool isQuizAssignment;
//   bool canDuplicate;
//   dynamic originalCourseId;
//   dynamic originalAssignmentId;
//   dynamic originalAssignmentName;
//   dynamic originalQuizId;
//   WorkflowState workflowState;
//   bool muted;
//   String htmlUrl;
//   bool published;
//   bool onlyVisibleToOverrides;
//   bool lockedForUser;
//   String submissionsDownloadUrl;
//   bool anonymizeStudents;

//   CourseAssignment({
//     this.id,
// //    this.description,
//     this.dueAt,
//     this.unlockAt,
//     this.lockAt,
//     this.pointsPossible,
//     this.gradingType,
//     this.assignmentGroupId,
//     this.gradingStandardId,
//     this.createdAt,
//     this.updatedAt,
//     this.peerReviews,
//     this.automaticPeerReviews,
//     this.position,
//     this.gradeGroupStudentsIndividually,
//     this.anonymousPeerReviews,
//     this.groupCategoryId,
//     this.postToSis,
//     this.moderatedGrading,
//     this.omitFromFinalGrade,
//     this.intraGroupPeerReviews,
//     this.anonymousInstructorAnnotations,
//     this.anonymousGrading,
//     this.gradersAnonymousToGraders,
//     this.graderCount,
//     this.graderCommentsVisibleToGraders,
//     this.finalGraderId,
//     this.graderNamesVisibleToFinalGrader,
//     this.allowedAttempts,
//     this.secureParams,
//     this.courseId,
//     this.name,
//     this.submissionTypes,
//     this.hasSubmittedSubmissions,
//     this.dueDateRequired,
//     this.maxNameLength,
//     this.inClosedGradingPeriod,
//     this.isQuizAssignment,
//     this.canDuplicate,
//     this.originalCourseId,
//     this.originalAssignmentId,
//     this.originalAssignmentName,
//     this.originalQuizId,
//     this.workflowState,
//     this.muted,
//     this.htmlUrl,
//     this.published,
//     this.onlyVisibleToOverrides,
//     this.lockedForUser,
//     this.submissionsDownloadUrl,
//     this.anonymizeStudents,
//   });

//   factory CourseAssignment.fromJson(Map<String, dynamic> json) => CourseAssignment(
//     id: json["id"],
// //    description: json["description"],
//     dueAt: json["due_at"] == null ? null : DateTime.parse(json["due_at"]),
//     unlockAt: json["unlock_at"],
//     lockAt: json["lock_at"],
//     pointsPossible: json["points_possible"],
//     gradingType: gradingTypeValues.map[json["grading_type"]],
//     assignmentGroupId: json["assignment_group_id"],
//     gradingStandardId: json["grading_standard_id"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     peerReviews: json["peer_reviews"],
//     automaticPeerReviews: json["automatic_peer_reviews"],
//     position: json["position"],
//     gradeGroupStudentsIndividually: json["grade_group_students_individually"],
//     anonymousPeerReviews: json["anonymous_peer_reviews"],
//     groupCategoryId: json["group_category_id"] == null ? null : json["group_category_id"],
//     postToSis: json["post_to_sis"],
//     moderatedGrading: json["moderated_grading"],
//     omitFromFinalGrade: json["omit_from_final_grade"],
//     intraGroupPeerReviews: json["intra_group_peer_reviews"],
//     anonymousInstructorAnnotations: json["anonymous_instructor_annotations"],
//     anonymousGrading: json["anonymous_grading"],
//     gradersAnonymousToGraders: json["graders_anonymous_to_graders"],
//     graderCount: json["grader_count"],
//     graderCommentsVisibleToGraders: json["grader_comments_visible_to_graders"],
//     finalGraderId: json["final_grader_id"],
//     graderNamesVisibleToFinalGrader: json["grader_names_visible_to_final_grader"],
//     allowedAttempts: json["allowed_attempts"],
//     secureParams: json["secure_params"],
//     courseId: json["course_id"],
//     name: json["name"],
//     submissionTypes: List<SubmissionType>.from(json["submission_types"].map((x) => submissionTypeValues.map[x])),
//     hasSubmittedSubmissions: json["has_submitted_submissions"],
//     dueDateRequired: json["due_date_required"],
//     maxNameLength: json["max_name_length"],
//     inClosedGradingPeriod: json["in_closed_grading_period"],
//     isQuizAssignment: json["is_quiz_assignment"],
//     canDuplicate: json["can_duplicate"],
//     originalCourseId: json["original_course_id"],
//     originalAssignmentId: json["original_assignment_id"],
//     originalAssignmentName: json["original_assignment_name"],
//     originalQuizId: json["original_quiz_id"],
//     workflowState: workflowStateValues.map[json["workflow_state"]],
//     muted: json["muted"],
//     htmlUrl: json["html_url"],
//     published: json["published"],
//     onlyVisibleToOverrides: json["only_visible_to_overrides"],
//     lockedForUser: json["locked_for_user"],
//     submissionsDownloadUrl: json["submissions_download_url"],
//     anonymizeStudents: json["anonymize_students"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
// //    "description": description,
//     "due_at": dueAt.toIso8601String(),
//     "unlock_at": unlockAt,
//     "lock_at": lockAt,
//     "points_possible": pointsPossible,
//     "grading_type": gradingTypeValues.reverse[gradingType],
//     "assignment_group_id": assignmentGroupId,
//     "grading_standard_id": gradingStandardId,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//     "peer_reviews": peerReviews,
//     "automatic_peer_reviews": automaticPeerReviews,
//     "position": position,
//     "grade_group_students_individually": gradeGroupStudentsIndividually,
//     "anonymous_peer_reviews": anonymousPeerReviews,
//     "group_category_id": groupCategoryId == null ? null : groupCategoryId,
//     "post_to_sis": postToSis,
//     "moderated_grading": moderatedGrading,
//     "omit_from_final_grade": omitFromFinalGrade,
//     "intra_group_peer_reviews": intraGroupPeerReviews,
//     "anonymous_instructor_annotations": anonymousInstructorAnnotations,
//     "anonymous_grading": anonymousGrading,
//     "graders_anonymous_to_graders": gradersAnonymousToGraders,
//     "grader_count": graderCount,
//     "grader_comments_visible_to_graders": graderCommentsVisibleToGraders,
//     "final_grader_id": finalGraderId,
//     "grader_names_visible_to_final_grader": graderNamesVisibleToFinalGrader,
//     "allowed_attempts": allowedAttempts,
//     "secure_params": secureParams,
//     "course_id": courseId,
//     "name": name,
//     "submission_types": List<dynamic>.from(submissionTypes.map((x) => submissionTypeValues.reverse[x])),
//     "has_submitted_submissions": hasSubmittedSubmissions,
//     "due_date_required": dueDateRequired,
//     "max_name_length": maxNameLength,
//     "in_closed_grading_period": inClosedGradingPeriod,
//     "is_quiz_assignment": isQuizAssignment,
//     "can_duplicate": canDuplicate,
//     "original_course_id": originalCourseId,
//     "original_assignment_id": originalAssignmentId,
//     "original_assignment_name": originalAssignmentName,
//     "original_quiz_id": originalQuizId,
//     "workflow_state": workflowStateValues.reverse[workflowState],
//     "muted": muted,
//     "html_url": htmlUrl,
//     "published": published,
//     "only_visible_to_overrides": onlyVisibleToOverrides,
//     "locked_for_user": lockedForUser,
//     "submissions_download_url": submissionsDownloadUrl,
//     "anonymize_students": anonymizeStudents,
//   };
// }

// enum GradingType { PASS_FAIL, LETTER_GRADE }

// final gradingTypeValues = EnumValues({
//   "letter_grade": GradingType.LETTER_GRADE,
//   "pass_fail": GradingType.PASS_FAIL
// });

// enum SubmissionType { ONLINE_UPLOAD }

// final submissionTypeValues = EnumValues({
//   "online_upload": SubmissionType.ONLINE_UPLOAD
// });

// enum WorkflowState { PUBLISHED }

// final workflowStateValues = EnumValues({
//   "published": WorkflowState.PUBLISHED
// });

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
