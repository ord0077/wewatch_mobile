// To parse this JSON data, do
//
//     final projectvisitorModel = projectvisitorModelFromMap(jsonString);

import 'dart:convert';

ProjectvisitorModel projectvisitorModelFromMap(String str) => ProjectvisitorModel.fromMap(json.decode(str));

String projectvisitorModelToMap(ProjectvisitorModel data) => json.encode(data.toMap());

class ProjectvisitorModel {
  ProjectvisitorModel({
    this.id,
    this.projectId,
    this.userId,
    this.companyName,
    this.driverContact,
    this.visitReason,
    this.carAttachment,
    this.idAttachment,
  });

  int id;
  int projectId;
  int userId;
  String companyName;
  String driverContact;
  String visitReason;
  String carAttachment;
  String idAttachment;

  factory ProjectvisitorModel.fromMap(Map<String, dynamic> json) => ProjectvisitorModel(
    id: json["id"],
    projectId: json["project_id"],
    userId: json["user_id"],
    companyName: json["company_name"],
    driverContact: json["driver_contact"],
    visitReason: json["visit_reason"],
    carAttachment: json["car_attachment"],
    idAttachment: json["id_attachment"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "project_id": projectId,
    "user_id": userId,
    "company_name": companyName,
    "driver_contact": driverContact,
    "visit_reason": visitReason,
    "car_attachment": carAttachment,
    "id_attachment": idAttachment,
  };
}
