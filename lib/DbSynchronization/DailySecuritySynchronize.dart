


import 'dart:io';
import 'dart:typed_data';

import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wewatchapp/DbControllers/DailySecurityController.dart';
import 'package:wewatchapp/data/models/dailysecurityModel.dart';
import 'package:wewatchapp/data/models/observationModel.dart';
import 'package:wewatchapp/databaseHelper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class DailySecuritySynch {
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

  Future<List<DailySecurityModel>> fetchAllInfo()async{
    final dbClient = await conn.db;
    List<DailySecurityModel> contactList = [] ;
    try {
      final maps = await dbClient.query(SqfliteDatabaseHelper.dailySecurityTable );
      for (var item in maps) {
        contactList.add(DailySecurityModel.fromMap(item));
      }
    } catch (e) {
      print(e.toString());
    }
    return contactList;
  }

  Future saveToMysqlWith(List<DailySecurityModel> contactList) async {
    for (var i = 0; i < contactList.length; i++) {
//      String img = "jpg," + new String.fromCharCodes(contactList[i].image);
      File imageFile = new File(contactList[i].attachments);
      List<int> bytes = await imageFile.readAsBytes();
      String fileExt = imageFile.path.split('.').last;
//    String basename = basename(imageFile.path);
      List<int> videoBytes = imageFile.readAsBytesSync();
      file = base64.encode(videoBytes);
      String fi = fileExt +","+ file ;

      Map<String, dynamic> data = {
        "project_id":contactList[i].projectId,
        "user_id":contactList[i].userId,
        "daily_report_elements":contactList[i].dailyReportElements,
        "guard_organization":contactList[i].guardOrganization,
        "no_staff":contactList[i].noStaff,
        "no_incidents_daily":contactList[i].noIncidentsDaily,
        "no_visitors":contactList[i].noVisitors,
        "inspections":contactList[i].inspections,
        "observations":contactList[i].observations,
        "travel_security_updates":contactList[i].travelSecurityUpdates,
        "red_flag":contactList[i].redFlag,
        "attachments":fi,
      };

      SharedPreferences userData = await SharedPreferences.getInstance();
      String tokenn = userData.getString('token');
//    String tokenn ='90|ZHVdsajU7doU6LusdhVwd2D0s9zqZAebfnUhInLT';

      String token = 'Bearer '+ tokenn;

      final uri = 'https://wewatch.ordd.tk/api/dailysecurityreport';
//    _onLoading();
      http.Response response = await http.post(
          uri, headers: { 'Content-type': 'application/json',
        'Accept': 'application/json', HttpHeaders.authorizationHeader: token },body: (json.encode(data)));


      //
      //     final response = await htpp.post('http://192.168.43.6/syncsqftomysqlflutter/load_from_sqflite_contactinfo_table_save_or_update_to_mysql.php',body: data);
      try{
        if (response.statusCode==200) {
          print("Saving Data ");
          print(contactList[i].id);

          await DailySecurityController().delete('dailySecurityTable',contactList[i].id);

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