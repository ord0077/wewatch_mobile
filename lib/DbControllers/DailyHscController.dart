import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wewatchapp/data/models/dailyhscModel.dart';
import 'package:wewatchapp/data/models/dailysecurityModel.dart';
import 'package:wewatchapp/data/models/observationModel.dart';

import '../databaseHelper.dart';

class DailyHscController {
  final conn = SqfliteDatabaseHelper.instance;
  final String columnId = '_id';
  int id;


  Future<int> addData(DailyHscModel dailyHscModel)async{
    var dbclient = await conn.db;
    int result;
    try {
      result = await dbclient.insert(SqfliteDatabaseHelper.dailyHscTable, dailyHscModel.toMap());
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<int> delete(dailyHscTable,id) async {
    var dbclient = await conn.db;
    return await dbclient.rawDelete("DELETE FROM $dailyHscTable WHERE id = $id");
//    return await dbclient.delete(SqfliteDatabaseHelper.observationTable., where: '$ = ?', whereArgs: [observationModel]);
  }

  Future<void> DropTable() async {
    var dbclient = await conn.db;


    await dbclient.execute("DELETE FROM dailyHscTable");

  }

  Future<int> updateData(DailySecurityModel dailySecurityModel)async{
    var dbclient = await conn.db;
    int result;
    try {
      result = await dbclient.update(SqfliteDatabaseHelper.dailyHscTable, dailySecurityModel.toMap(),where: 'id=?',whereArgs: [dailySecurityModel.userId]);
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future fetchData()async{
    var dbclient = await conn.db;
    List userList = [];
    try {
      List<Map<String,dynamic>> maps = await dbclient.query(SqfliteDatabaseHelper.dailyHscTable,);
      for (var item in maps) {
        userList.add(item);
      }
    } catch (e) {
      print(e.toString());
    }
    return userList;
  }
}

