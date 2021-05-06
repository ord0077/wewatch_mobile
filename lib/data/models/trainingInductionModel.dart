// To parse this JSON data, do
//
//     final trainingInducModel = trainingInducModelFromMap(jsonString);

import 'dart:convert';

TrainingInducModel trainingInducModelFromMap(String str) => TrainingInducModel.fromMap(json.decode(str));

String trainingInducModelToMap(TrainingInducModel data) => json.encode(data.toMap());

class TrainingInducModel {
  TrainingInducModel({
    this.id,
    this.projectId,
    this.userId,
    this.sessionType,
    this.subject,
    this.noAttendees,
    this.attachments,
  });

  int id;
  int projectId;
  int userId;
  String sessionType;
  String subject;
  int noAttendees;
  String attachments;

  factory TrainingInducModel.fromMap(Map<String, dynamic> json) => TrainingInducModel(
    id: json["id"],
    projectId: json["project_id"],
    userId: json["user_id"],
    sessionType: json["session_type"],
    subject: json["subject"],
    noAttendees: json["no_attendees"],
    attachments: json["attachments"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "project_id": projectId,
    "user_id": userId,
    "session_type": sessionType,
    "subject": subject,
    "no_attendees": noAttendees,
    "attachments": attachments,
  };
}
