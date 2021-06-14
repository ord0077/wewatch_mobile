// To parse this JSON data, do
//
//     final projects = projectsFromJson(jsonString);

import 'dart:convert';

Projects projectsFromJson(String str) => Projects.fromJson(json.decode(str));

String projectsToJson(Projects data) => json.encode(data.toJson());

class Projects {
  Projects({
    this.project,
  });

  List<Project> project;

  factory Projects.fromJson(Map<String, dynamic> json) => Projects(
    project: List<Project>.from(json["project"].map((x) => Project.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "project": List<dynamic>.from(project.map((x) => x.toJson())),
  };
}

class Project {
  Project({
    this.Id,
    this.projectName,
    this.location,
  });

  int Id;
  String projectName;
  String location;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    Id: json["id"],
    projectName: json["project_name"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "id": Id,
    "project_name": projectName,
    "location": location,
  };
}
