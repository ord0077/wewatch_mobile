import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wewatchapp/data/models/covid19Model.dart';


import '../databaseHelper.dart';

class Covid19Controller {
  final conn = SqfliteDatabaseHelper.instance;
  final String columnId = '_id';
  int id;


  Future<int> addData(CovidModel covidModel)async{
    var dbclient = await conn.db;
    int result;
    try {
      result = await dbclient.insert(SqfliteDatabaseHelper.covid19Table, covidModel.toMap());
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<int> delete(covid19Table,id) async {
    var dbclient = await conn.db;
    return await dbclient.rawDelete("DELETE FROM $covid19Table WHERE id = $id");
//    return await dbclient.delete(SqfliteDatabaseHelper.observationTable., where: '$ = ?', whereArgs: [observationModel]);
  }

  Future<void> DropTable() async {
    var dbclient = await conn.db;


    await dbclient.execute("DELETE FROM covid19Table");

  }

  Future<int> updateData(CovidModel covidModel)async{
    var dbclient = await conn.db;
    int result;
    try {
      result = await dbclient.update(SqfliteDatabaseHelper.covid19Table, covidModel.toMap(),where: 'id=?',whereArgs: [covidModel.userId]);
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future fetchData()async{
    var dbclient = await conn.db;
    List userList = [];
    try {
      List<Map<String,dynamic>> maps = await dbclient.query(SqfliteDatabaseHelper.covid19Table,);
      for (var item in maps) {
        userList.add(item);
      }
    } catch (e) {
      print(e.toString());
    }
    return userList;
  }
}

