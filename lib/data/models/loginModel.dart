// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    LoginModel({
        this.token,
        this.user,
        // this.project,
        this.userId,
    });

    String token;
    User user;
    // List<Project> project = [];
    int userId;

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        token: json["token"],
        user: User.fromJson(json["user"]),
        // project:json["project"] == null ? null : List<Project>.from(json["project"].map((x) => Project.fromJson(x))),

        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
        // "project" : project == null ? null : List<dynamic>.from(project.map((x) => x.toJson())),
         "user_id": userId,
    };
}

// class Project {
//     Project({
//         this.projectId,
//         this.projectName,
//         this.location,
//         this.user,
//         this.zones,
//     });
//
//     int projectId;
//     String projectName;
//     String location;
//     dynamic user;
//     List<dynamic> zones;
//
//     factory Project.fromJson(Map<String, dynamic> json) => Project(
//         projectId: json["project_id"],
//         projectName: json["project_name"],
//         location: json["location"],
//         user: json["user"],
//         zones: List<dynamic>.from(json["zones"].map((x) => x)),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "project_id": projectId,
//         "project_name": projectName,
//         "location": location,
//         "user": user,
//         "zones": List<dynamic>.from(zones.map((x) => x)),
//     };
// }

class User {
    User({
        this.id,
        this.parentId,
        this.roleId,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.isactive,
        this.currentTeamId,
        this.profilePhotoPath,
        this.createdAt,
        this.updatedAt,
        this.userType,
        this.profilePhotoUrl,
        this.role,
        this.admin,
    });

    int id;
    dynamic parentId;
    int roleId;
    String name;
    String email;
    dynamic emailVerifiedAt;
    bool isactive;
    dynamic currentTeamId;
    dynamic profilePhotoPath;
    DateTime createdAt;
    DateTime updatedAt;
    String userType;
    String profilePhotoUrl;
    Role role;
    dynamic admin;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        parentId: json["parent_id"],
        roleId: json["role_id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        isactive: json["isactive"],
        currentTeamId: json["current_team_id"],
        profilePhotoPath: json["profile_photo_path"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userType: json["user_type"],
        profilePhotoUrl: json["profile_photo_url"],
        role: Role.fromJson(json["role"]),
        admin: json["admin"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "role_id": roleId,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "isactive": isactive,
        "current_team_id": currentTeamId,
        "profile_photo_path": profilePhotoPath,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_type": userType,
        "profile_photo_url": profilePhotoUrl,
        "role": role.toJson(),
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

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
    };
}
