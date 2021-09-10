// To parse this JSON data, do
//
//     final viewSiteVisitorsModel = viewSiteVisitorsModelFromMap(jsonString);

import 'dart:convert';

ViewSiteVisitorsModel viewSiteVisitorsModelFromMap(String str) => ViewSiteVisitorsModel.fromMap(json.decode(str));

String viewSiteVisitorsModelToMap(ViewSiteVisitorsModel data) => json.encode(data.toMap());

class ViewSiteVisitorsModel {
  ViewSiteVisitorsModel({
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

  factory ViewSiteVisitorsModel.fromMap(Map<String, dynamic> json) => ViewSiteVisitorsModel(
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
    this.companyName,
    this.driverContact,
    this.visitReason,
    this.carAttachment,
    this.idAttachment,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int projectId;
  int userId;
  String companyName;
  String driverContact;
  String visitReason;
  String carAttachment;
  String idAttachment;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    projectId: json["project_id"],
    userId: json["user_id"],
    companyName: json["company_name"],
    driverContact: json["driver_contact"],
    visitReason: json["visit_reason"],
    carAttachment: json["car_attachment"],
    idAttachment: json["id_attachment"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
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
