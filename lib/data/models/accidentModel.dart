// To parse this JSON data, do
//
//     final accidentModel = accidentModelFromMap(jsonString);

import 'dart:convert';

AccidentModel accidentModelFromMap(String str) => AccidentModel.fromMap(json.decode(str));

String accidentModelToMap(AccidentModel data) => json.encode(data.toMap());

class AccidentModel {
  AccidentModel({
    this.id,
    this.userId,
    this.projectId,
    this.location,
    this.reportedDate,
    this.reportedTime,
    this.categoryIncident,
    this.typeInjury,
    this.typeIncident,
    this.other,
    this.fatality,
    this.describeIncident,
    this.immediateAction,
    this.attachment,
  });
  int id;
  int userId;
  int projectId;
  String location;
  String reportedDate;
  String reportedTime;
  String categoryIncident;
  String typeInjury;
  String typeIncident;
  String other;
  String fatality;
  String describeIncident;
  String immediateAction;
  String attachment;
//  xyz
  factory AccidentModel.fromMap(Map<String, dynamic> json) => AccidentModel(
    id: json["id"],
    userId: json["user_id"],
    projectId: json["project_id"],
    location: json["location"],
    reportedDate: json["reported_date"],
    reportedTime: json["reported_time"],
    categoryIncident: json["category_incident"],
    typeInjury: json["type_injury"],
    typeIncident: json["type_incident"],
    other: json["other"],
    fatality: json["fatality"],
    describeIncident: json["describe_incident"],
    immediateAction: json["immediate_action"],
    attachment: json["attachment"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "project_id": projectId,
    "location": location,
    "reported_date": reportedDate,
    "reported_time": reportedTime,
    "category_incident": categoryIncident,
    "type_injury": typeInjury,
    "type_incident": typeIncident,
    "other": other,
    "fatality": fatality,
    "describe_incident": describeIncident,
    "immediate_action": immediateAction,
    "attachment": attachment,
  };
}
