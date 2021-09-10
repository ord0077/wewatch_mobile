// To parse this JSON data, do
//
//     final viewAccidentModel = viewAccidentModelFromMap(jsonString);

import 'dart:convert';

ViewAccidentModel viewAccidentModelFromMap(String str) => ViewAccidentModel.fromMap(json.decode(str));

String viewAccidentModelToMap(ViewAccidentModel data) => json.encode(data.toMap());

class ViewAccidentModel {
  ViewAccidentModel({
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
  String prevPageUrl;
  int to;
  int total;

  factory ViewAccidentModel.fromMap(Map<String, dynamic> json) => ViewAccidentModel(
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
    this.createdAt,
    this.updatedAt,
    this.project,
  });

  int id;
  int userId;
  int projectId;
  String location;
  String  reportedDate;
  String reportedTime;
  String categoryIncident;
  String typeInjury;
  String typeIncident;
  dynamic other;
  dynamic fatality;
  dynamic describeIncident;
  dynamic immediateAction;
  String attachment;
  String createdAt;
  DateTime updatedAt;
  Project project;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
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
    createdAt: json["created_at"],
    updatedAt: DateTime.parse(json["updated_at"]),
    project: Project.fromMap(json["project"]),
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
    "created_at": createdAt,
    "updated_at": updatedAt.toIso8601String(),
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
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toMap() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
