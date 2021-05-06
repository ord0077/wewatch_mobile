import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wewatchapp/data/models/dailysecurityModel.dart';

import '../databaseHelper.dart';

class DailySecurityController {
  final conn = SqfliteDatabaseHelper.instance;
  final String columnId = '_id';
  int id;


  Future<int> addData(DailySecurityModel dailySecurityModel)async{
    var dbclient = await conn.db;
    int result;
    try {
      result = await dbclient.insert(SqfliteDatabaseHelper.dailySecurityTable, dailySecurityModel.toMap());
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<int> delete(dailySecurityTable,id) async {
    var dbclient = await conn.db;
    return await dbclient.rawDelete("DELETE FROM $dailySecurityTable WHERE id = $id");
//    return await dbclient.delete(SqfliteDatabaseHelper.observationTable., where: '$ = ?', whereArgs: [observationModel]);
  }

  Future<void> DropTable() async {
    var dbclient = await conn.db;


    await dbclient.execute("DELETE FROM dailySecurityTable");

  }

  Future<int> updateData(DailySecurityModel dailySecurityModel)async{
    var dbclient = await conn.db;
    int result;
    try {
      result = await dbclient.update(SqfliteDatabaseHelper.dailySecurityTable, dailySecurityModel.toMap(),where: 'id=?',whereArgs: [dailySecurityModel.userId]);
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future fetchData()async{
    var dbclient = await conn.db;
    List userList = [];
    try {
      List<Map<String,dynamic>> maps = await dbclient.query(SqfliteDatabaseHelper.dailySecurityTable,);
      for (var item in maps) {
        userList.add(item);
      }
    } catch (e) {
      print(e.toString());
    }
    return userList;
  }
}

