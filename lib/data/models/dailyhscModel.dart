// To parse this JSON data, do
//
//     final dailyHscModel = dailyHscModelFromMap(jsonString);

import 'dart:convert';

DailyHscModel dailyHscModelFromMap(String str) => DailyHscModel.fromMap(json.decode(str));

String dailyHscModelToMap(DailyHscModel data) => json.encode(data.toMap());

class DailyHscModel {
  DailyHscModel({
    this.userId,
    this.projectId,
    this.name,
    this.date,
    this.contactNo,
    this.weatherConditions,
    this.workTimings,
    this.workforceSize,
    this.subcontractors,
    this.progressActivity,
    this.sessionAttendees,
    this.attachment,
    this.redFlag,
    this.incidents,
    this.incidentsRemarks,
    this.nearMisses,
    this.nearMissesRemarks,
    this.violationsNoncompliance,
    this.violationsNoncomplianceRemarks,
    this.firstAid,
    this.firstAidRemarks,
    this.environmentIncidents,
    this.environmentIncidentsRemarks,
    this.housekeeping,
    this.housekeepingRemarks,
    this.safetySigns,
    this.safetySignsRemarks,
    this.workPermit,
    this.workPermitRemarks,
    this.drumsCylinders,
    this.drumsCylindersRemarks,
    this.safetyConcerns,
    this.safetyConcernsRemarks,
    this.covidFaceMask,
    this.covidFaceMaskRemarks,
    this.covidRespiratoryHygiene,
    this.covidRespiratoryHygieneRemarks,
    this.socialDistancing,
    this.socialDistancingRemarks,
    this.cleaningDisinfecting,
    this.cleaningDisinfectingRemarks,
  });

  int userId;
  int projectId;
  String name;
  String date;
  String contactNo;
  String weatherConditions;
  String workTimings;
  String workforceSize;
  String subcontractors;
  String progressActivity;
  String sessionAttendees;
  String attachment;
  String redFlag;
  String incidents;
  String incidentsRemarks;
  String nearMisses;
  String nearMissesRemarks;
  String violationsNoncompliance;
  String violationsNoncomplianceRemarks;
  String firstAid;
  String firstAidRemarks;
  String environmentIncidents;
  String environmentIncidentsRemarks;
  String housekeeping;
  String housekeepingRemarks;
  String safetySigns;
  String safetySignsRemarks;
  String workPermit;
  String workPermitRemarks;
  String drumsCylinders;
  String drumsCylindersRemarks;
  String safetyConcerns;
  String safetyConcernsRemarks;
  String covidFaceMask;
  String covidFaceMaskRemarks;
  String covidRespiratoryHygiene;
  String covidRespiratoryHygieneRemarks;
  String socialDistancing;
  String socialDistancingRemarks;
  String cleaningDisinfecting;
  String cleaningDisinfectingRemarks;

  factory DailyHscModel.fromMap(Map<String, dynamic> json) => DailyHscModel(
    userId: json["user_id"],
    projectId: json["project_id"],
    name: json["name"],
    date: json["date"],
    contactNo: json["contact_no"],
    weatherConditions: json["weather_conditions"],
    workTimings: json["work_timings"],
    workforceSize: json["workforce_size"],
    subcontractors: json["subcontractors"],
    progressActivity: json["progress_activity"],
    sessionAttendees: json["session_attendees"],
    attachment: json["attachment"],
    redFlag: json["red_flag"],
    incidents: json["incidents"],
    incidentsRemarks: json["incidents_remarks"],
    nearMisses: json["near_misses"],
    nearMissesRemarks: json["near_misses_remarks"],
    violationsNoncompliance: json["violations_noncompliance"],
    violationsNoncomplianceRemarks: json["violations_noncompliance_remarks"],
    firstAid: json["first_aid"],
    firstAidRemarks: json["first_aid_remarks"],
    environmentIncidents: json["environment_incidents"],
    environmentIncidentsRemarks: json["environment_incidents_remarks"],
    housekeeping: json["housekeeping"],
    housekeepingRemarks: json["housekeeping_remarks"],
    safetySigns: json["safety_signs"],
    safetySignsRemarks: json["safety_signs_remarks"],
    workPermit: json["work_permit"],
    workPermitRemarks: json["work_permit_remarks"],
    drumsCylinders: json["drums_cylinders"],
    drumsCylindersRemarks: json["drums_cylinders_remarks"],
    safetyConcerns: json["safety_concerns"],
    safetyConcernsRemarks: json["safety_concerns_remarks"],
    covidFaceMask: json["covid_face_mask"],
    covidFaceMaskRemarks: json["covid_face_mask_remarks"],
    covidRespiratoryHygiene: json["covid_respiratory_hygiene"],
    covidRespiratoryHygieneRemarks: json["covid_respiratory_hygiene_remarks"],
    socialDistancing: json["social_distancing"],
    socialDistancingRemarks: json["social_distancing_remarks"],
    cleaningDisinfecting: json["cleaning_disinfecting"],
    cleaningDisinfectingRemarks: json["cleaning_disinfecting_remarks"],
  );

  Map<String, dynamic> toMap() => {
    "user_id": userId,
    "project_id": projectId,
    "name": name,
    "date": date,
    "contact_no": contactNo,
    "weather_conditions": weatherConditions,
    "work_timings": workTimings,
    "workforce_size": workforceSize,
    "subcontractors": subcontractors,
    "progress_activity": progressActivity,
    "session_attendees": sessionAttendees,
    "attachment": attachment,
    "red_flag": redFlag,
    "incidents": incidents,
    "incidents_remarks": incidentsRemarks,
    "near_misses": nearMisses,
    "near_misses_remarks": nearMissesRemarks,
    "violations_noncompliance": violationsNoncompliance,
    "violations_noncompliance_remarks": violationsNoncomplianceRemarks,
    "first_aid": firstAid,
    "first_aid_remarks": firstAidRemarks,
    "environment_incidents": environmentIncidents,
    "environment_incidents_remarks": environmentIncidentsRemarks,
    "housekeeping": housekeeping,
    "housekeeping_remarks": housekeepingRemarks,
    "safety_signs": safetySigns,
    "safety_signs_remarks": safetySignsRemarks,
    "work_permit": workPermit,
    "work_permit_remarks": workPermitRemarks,
    "drums_cylinders": drumsCylinders,
    "drums_cylinders_remarks": drumsCylindersRemarks,
    "safety_concerns": safetyConcerns,
    "safety_concerns_remarks": safetyConcernsRemarks,
    "covid_face_mask": covidFaceMask,
    "covid_face_mask_remarks": covidFaceMaskRemarks,
    "covid_respiratory_hygiene": covidRespiratoryHygiene,
    "covid_respiratory_hygiene_remarks": covidRespiratoryHygieneRemarks,
    "social_distancing": socialDistancing,
    "social_distancing_remarks": socialDistancingRemarks,
    "cleaning_disinfecting": cleaningDisinfecting,
    "cleaning_disinfecting_remarks": cleaningDisinfectingRemarks,
  };
}
