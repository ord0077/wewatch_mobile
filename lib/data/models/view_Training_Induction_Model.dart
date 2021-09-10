// To parse this JSON data, do
//
//     final viewTrainingInductionModel = viewTrainingInductionModelFromMap(jsonString);

import 'dart:convert';

ViewTrainingInductionModel viewTrainingInductionModelFromMap(String str) => ViewTrainingInductionModel.fromMap(json.decode(str));

String viewTrainingInductionModelToMap(ViewTrainingInductionModel data) => json.encode(data.toMap());

class ViewTrainingInductionModel {
  ViewTrainingInductionModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory ViewTrainingInductionModel.fromMap(Map<String, dynamic> json) => ViewTrainingInductionModel(
    currentPage: json["current_page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromMap(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toMap() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links.map((x) => x.toMap())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  Datum({
    this.id,
    this.projectId,
    this.userId,
    this.sessionType,
    this.subject,
    this.noAttendees,
    this.attachments,
    this.createdAt,
    this.updatedAt,
    this.project,
  });

  int id;
  int projectId;
  int userId;
  String sessionType;
  String subject;
  int noAttendees;
  String attachments;
  String createdAt;
  String updatedAt;
  Project project;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    projectId: json["project_id"],
    userId: json["user_id"],
    sessionType: json["session_type"],
    subject: json["subject"],
    noAttendees: json["no_attendees"],
    attachments: json["attachments"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    project: Project.fromMap(json["project"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "project_id": projectId,
    "user_id": userId,
    "session_type": sessionType,
    "subject": subject,
    "no_attendees": noAttendees,
    "attachments": attachments,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "project": project.toMap(),
  };
}

class Project {
  Project({
    this.id,
    this.projectName,
    this.user,
    this.zones,
  });

  int id;
  String projectName;
  dynamic user;
  List<Zone> zones;

  factory Project.fromMap(Map<String, dynamic> json) => Project(
    id: json["id"],
    projectName: json["project_name"],
    user: json["user"],
    zones: List<Zone>.from(json["zones"].map((x) => Zone.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "project_name": projectName,
    "user": user,
    "zones": List<dynamic>.from(zones.map((x) => x.toMap())),
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

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String url;
  String label;
  bool active;

  factory Link.fromMap(Map<String, dynamic> json) => Link(
    url: json["url"] == null ? null : json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toMap() => {
    "url": url == null ? null : url,
    "label": label,
    "active": active,
  };
}
