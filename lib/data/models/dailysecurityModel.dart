// To parse this JSON data, do
//
//     final dailySecurityModel = dailySecurityModelFromMap(jsonString);

import 'dart:convert';

DailySecurityModel dailySecurityModelFromMap(String str) => DailySecurityModel.fromMap(json.decode(str));

String dailySecurityModelToMap(DailySecurityModel data) => json.encode(data.toMap());

class DailySecurityModel {
  DailySecurityModel({
    this.id,
    this.projectId,
    this.userId,
    this.dailyReportElements,
    this.guardOrganization,
    this.noStaff,
    this.noIncidentsDaily,
    this.noVisitors,
    this.inspections,
    this.observations,
    this.travelSecurityUpdates,
    this.redFlag,
    this.attachments,
  });

  int id;
  int projectId;
  int userId;
  String dailyReportElements;
  String guardOrganization;
  int noStaff;
  int noIncidentsDaily;
  int noVisitors;
  String inspections;
  String observations;
  String travelSecurityUpdates;
  dynamic redFlag;
  String attachments;

  factory DailySecurityModel.fromMap(Map<String, dynamic> json) => DailySecurityModel(
    id: json["id"],
    projectId: json["project_id"],
    userId: json["user_id"],
    dailyReportElements: json["daily_report_elements"],
    guardOrganization: json["guard_organization"],
    noStaff: json["no_staff"],
    noIncidentsDaily: json["no_incidents_daily"],
    noVisitors: json["no_visitors"],
    inspections: json["inspections"],
    observations: json["observations"],
    travelSecurityUpdates: json["travel_security_updates"],
    redFlag: json["red_flag"],
    attachments: json["attachments"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "project_id": projectId,
    "user_id": userId,
    "daily_report_elements": dailyReportElements,
    "guard_organization": guardOrganization,
    "no_staff": noStaff,
    "no_incidents_daily": noIncidentsDaily,
    "no_visitors": noVisitors,
    "inspections": inspections,
    "observations": observations,
    "travel_security_updates": travelSecurityUpdates,
    "red_flag": redFlag,
    "attachments": attachments,
  };
}
