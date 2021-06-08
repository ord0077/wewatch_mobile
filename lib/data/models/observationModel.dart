// To parse this JSON data, do
//
//     final observationModel = observationModelFromMap(jsonString);

import 'dart:convert';

ObservationModel observationModelFromMap(String str) => ObservationModel.fromMap(json.decode(str));

String observationModelToMap(ObservationModel data) => json.encode(data.toMap());

class ObservationModel {
  ObservationModel({
    this.id,
    this.projectId,
    this.userId,
    this.observationDescription,
    this.location,
    this.action,
    this.report,
    this.attachments,
  });

  int id;
  int projectId;
  int userId;
  String observationDescription;
  String location;
  String action;
  String report;
  String attachments;

  factory ObservationModel.fromMap(Map<String, dynamic> json) => ObservationModel(
    id: json["id"],
    projectId: json["project_id"],
    userId: json["user_id"],
    observationDescription: json["observation_description"],
    location: json["location"],
    action: json["action"],
    report: json["report"],
    attachments: json["attachments"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "project_id": projectId,
    "user_id": userId,
    "observation_description": observationDescription,
    "location": location,
    "action": action,
    "report": report,
    "attachments": attachments,
  };
}
