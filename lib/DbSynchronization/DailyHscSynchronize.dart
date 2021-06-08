


import 'dart:io';
import 'dart:typed_data';

import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wewatchapp/DbControllers/DailyHscController.dart';
import 'package:wewatchapp/data/models/dailyhscModel.dart';
import 'package:wewatchapp/data/models/dailysecurityModel.dart';
import 'package:wewatchapp/data/models/observationModel.dart';
import 'package:wewatchapp/databaseHelper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class DailyHscSync {
  static Database _db;
  String file ;
  static Future<bool> isInternet()async{

    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult == ConnectivityResult.mobile){
      if(await DataConnectionChecker().hasConnection ){
        print("Mobile Data detected & internet connection confirmed");
        return true;
      } else {
        print("No internet");
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi){
      if ( await DataConnectionChecker().hasConnection){
        print("wifi data detected & internet connection confirmed");
        return true;
      } else {
        print( "no internet wifi");
        return false;
      }
    } else{
      print("Neither mobile data or wifi detected");
      return false;
    }

  }

  Future<bool> connectivityChecker() async {
    var connected = false;
    print("Checking internet...");
    try {
      final result = await InternetAddress.lookup('google.com');
      final result2 = await InternetAddress.lookup('facebook.com');
      if ((result.isNotEmpty && result[0].rawAddress.isNotEmpty) ||
          (result2.isNotEmpty && result2[0].rawAddress.isNotEmpty) ) {
        print('connected..');
        connected = true;
      } else {
        print("not connected from else..");
        connected = false;
      }
    } on SocketException catch (_) {
      print('not connected...');
      connected = false;
    }
    return connected;
  }

  final conn = SqfliteDatabaseHelper.instance;

  Future<List<DailyHscModel>> fetchAllInfo()async{
    final dbClient = await conn.db;
    List<DailyHscModel> contactList = [] ;
    try {
      final maps = await dbClient.query(SqfliteDatabaseHelper.dailyHscTable );
      for (var item in maps) {
        contactList.add(DailyHscModel.fromMap(item));
      }
    } catch (e) {
      print(e.toString());
    }
    return contactList;
  }

  Future saveToMysqlWith(List<DailyHscModel> contactList) async {
    for (var i = 0; i < contactList.length; i++) {
//      String img = "jpg," + new String.fromCharCodes(contactList[i].image);
      File imageFile = new File(contactList[i].attachment);
      List<int> bytes = await imageFile.readAsBytes();
      String fileExt = imageFile.path.split('.').last;
//    String basename = basename(imageFile.path);
      List<int> videoBytes = imageFile.readAsBytesSync();
      file = base64.encode(videoBytes);
      String fi = fileExt +","+ file ;

      Map<String, dynamic> data = {
        "project_id":contactList[i].projectId,
        "user_id":contactList[i].userId,
        "name":contactList[i].name,
        "date":contactList[i].date,
        "contact_no":contactList[i].contactNo,
        "weather_conditions":contactList[i].weatherConditions,
        "work_timings":contactList[i].workTimings,
        "workforce_size":contactList[i].workforceSize,
        "subcontractors":contactList[i].subcontractors,
        "progress_activity":contactList[i].progressActivity,
        "session_attendees":contactList[i].sessionAttendees,
        "red_flag":contactList[i].redFlag,
        "incidents":contactList[i].incidents,
        "incidents_remarks":contactList[i].incidentsRemarks,
        "near_misses":contactList[i].nearMisses,
        "near_misses_remarks":contactList[i].nearMissesRemarks,
        "violations_noncompliance":contactList[i].violationsNoncompliance,
        "violations_noncompliance_remarks":contactList[i].violationsNoncomplianceRemarks,
        "first_aid":contactList[i].firstAid,
        "first_aid_remarks":contactList[i].firstAidRemarks,
        "environment_incidents":contactList[i].environmentIncidents,
        "environment_incidents_remarks":contactList[i].environmentIncidentsRemarks,
        "housekeeping":contactList[i].housekeeping,
        "housekeeping_remarks":contactList[i].housekeepingRemarks,
        "safety_signs":contactList[i].safetySigns,
        "safety_signs_remarks":contactList[i].safetySignsRemarks,
        "work_permit":contactList[i].workPermit,
        "work_permit_remarks":contactList[i].workPermitRemarks,
        "drums_cylinders":contactList[i].drumsCylinders,
        "drums_cylinders_remarks":contactList[i].drumsCylindersRemarks,
        "safety_concerns":contactList[i].safetyConcerns,
        "safety_concerns_remarks":contactList[i].safetyConcernsRemarks,
        "covid_face_mask":contactList[i].covidFaceMask,
        "covid_face_mask_remarks":contactList[i].covidFaceMaskRemarks,
        "covid_respiratory_hygiene":contactList[i].covidRespiratoryHygiene,
        "covid_respiratory_hygiene_remarks":contactList[i].covidRespiratoryHygieneRemarks,
        "social_distancing":contactList[i].socialDistancing,
        "social_distancing_remarks":contactList[i].socialDistancingRemarks,
        "cleaning_disinfecting":contactList[i].cleaningDisinfecting,
        "cleaning_disinfecting_remarks":contactList[i].cleaningDisinfectingRemarks,
        "attachment":fi,
      };

      SharedPreferences userData = await SharedPreferences.getInstance();
      String tokenn = userData.getString('token');
//    String tokenn ='90|ZHVdsajU7doU6LusdhVwd2D0s9zqZAebfnUhInLT';

      String token = 'Bearer '+ tokenn;

      final uri = 'https://wewatch.ordd.tk/api/hsereport';
//    _onLoading();
      http.Response response = await http.post(
          Uri.parse(uri), headers: { 'Content-type': 'application/json',
        'Accept': 'application/json', HttpHeaders.authorizationHeader: token },body: (json.encode(data)));


      //
      //     final response = await htpp.post('http://192.168.43.6/syncsqftomysqlflutter/load_from_sqflite_contactinfo_table_save_or_update_to_mysql.php',body: data);
      try{
        if (response.statusCode==200) {
          print("Saving Data ");
          print(contactList[i].id);

          await DailyHscController().delete('dailyHscTable',contactList[i].id);

          print("deleted entry");

        } else{
          print(response.statusCode);
        }
      }on SocketException catch (e) {
//        return;
        print("No net");
      } catch (e) {
        //for other errors
        print('error ${e.toString()}');
      }

    }

  }
}