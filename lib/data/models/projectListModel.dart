// To parse this JSON data, do
//
//     final projectListModel = projectListModelFromMap(jsonString);

import 'dart:convert';

List<ProjectListModel> projectListModelFromMap(String str) => List<ProjectListModel>.from(json.decode(str).map((x) => ProjectListModel.fromMap(x)));

String projectListModelToMap(List<ProjectListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ProjectListModel {
  ProjectListModel({
    this.id,
    this.userId,
    this.projectName,
    this.projectLogo,
    this.location,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.zones,
  });

  int id;
  int userId;
  String projectName;
  String projectLogo;
  String location;
  DateTime startDate;
  DateTime endDate;
  DateTime createdAt;
  DateTime updatedAt;
  User user;
  List<Zone> zones;

  factory ProjectListModel.fromMap(Map<String, dynamic> json) => ProjectListModel(
    id: json["id"],
    userId: json["user_id"],
    projectName: json["project_name"],
    projectLogo: json["project_logo"],
    location: json["location"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: User.fromMap(json["user"]),
    zones: List<Zone>.from(json["zones"].map((x) => Zone.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "project_name": projectName,
    "project_logo": projectLogo,
    "location": location,
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user": user.toMap(),
    "zones": List<dynamic>.from(zones.map((x) => x.toMap())),
  };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.roleId,
    this.profilePhotoUrl,
    this.role,
    this.admin,
  });

  int id;
  String name;
  String email;
  int roleId;
  String profilePhotoUrl;
  Role role;
  dynamic admin;

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    roleId: json["role_id"],
    profilePhotoUrl: json["profile_photo_url"],
    role: Role.fromMap(json["role"]),
    admin: json["admin"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "role_id": roleId,
    "profile_photo_url": profilePhotoUrl,
    "role": role.toMap(),
    "admin": admin,
  };
}

class Role {
  Role({
    this.id,
    this.role,
  });

  int id;
  String role;

  factory Role.fromMap(Map<String, dynamic> json) => Role(
    id: json["id"],
    role: json["role"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "role": role,
  };
}

class Zone {
  Zone({
    this.projectId,
    this.zoneName,
  });

  int projectId;
  String zoneName;

  factory Zone.fromMap(Map<String, dynamic> json) => Zone(
    projectId: json["project_id"],
    zoneName: json["zone_name"],
  );

  Map<String, dynamic> toMap() => {
    "project_id": projectId,
    "zone_name": zoneName,
  };
}
