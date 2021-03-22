// To parse this JSON data, do
//
//     final covidModel = covidModelFromMap(jsonString);

import 'dart:convert';

import 'dart:io';

CovidModel covidModelFromMap(String str) => CovidModel.fromMap(json.decode(str));

String covidModelToMap(CovidModel data) => json.encode(data.toMap());

class CovidModel {
  CovidModel({
    this.projectId,
    this.userId,
    this.temperature,
    this.staffName,
    this.company,
    this.remarks,
    this.image,
  });

  int projectId;
  int userId;
  String temperature;
  String staffName;
  String company;
  String remarks;
  String image;

  factory CovidModel.fromMap(Map<String, dynamic> json) => CovidModel(
    projectId: json["project_id"],
    userId: json["user_id"],
    temperature: json["temperature"],
    staffName: json["staff_name"],
    company: json["company"],
    remarks: json["remarks"],
    image: json["image"],
  );

  Map<String, dynamic> toMap() => {
    "project_id": projectId,
    "user_id": userId,
    "temperature": temperature,
    "staff_name": staffName,
    "company": company,
    "remarks": remarks,
    "image": image,
  };
}
