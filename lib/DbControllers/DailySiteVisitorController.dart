import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wewatchapp/data/models/projectSiteVisitorModel.dart';

import '../databaseHelper.dart';

class DailySiteVisitorController {
  final conn = SqfliteDatabaseHelper.instance;
  final String columnId = '_id';
  int id;


  Future<int> addData(ProjectvisitorModel projectvisitorModel)async{
    var dbclient = await conn.db;
    int result;
    try {
      result = await dbclient.insert(SqfliteDatabaseHelper.dailySiteVisitorTable, projectvisitorModel.toMap());
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<int> delete(dailySiteVisitorTable,id) async {
    var dbclient = await conn.db;
    return await dbclient.rawDelete("DELETE FROM $dailySiteVisitorTable WHERE id = $id");
  }

  Future<void> DropTable() async {
    var dbclient = await conn.db;


    await dbclient.execute("DELETE FROM dailySiteVisitorTable");

  }

  Future<int> updateData(ProjectvisitorModel projectvisitorModel)async{
    var dbclient = await conn.db;
    int result;
    try {
      result = await dbclient.update(SqfliteDatabaseHelper.dailySiteVisitorTable, projectvisitorModel.toMap(),where: 'id=?',whereArgs: [projectvisitorModel.userId]);
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future fetchData()async{
    var dbclient = await conn.db;
    List userList = [];
    try {
      List<Map<String,dynamic>> maps = await dbclient.query(SqfliteDatabaseHelper.dailySiteVisitorTable,);
      for (var item in maps) {
        userList.add(item);
      }
    } catch (e) {
      print(e.toString());
    }
    return userList;
  }
}

