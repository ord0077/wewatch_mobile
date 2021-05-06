import 'package:wewatchapp/data/models/accidentModel.dart';
import 'package:wewatchapp/data/models/observationModel.dart';
import 'package:wewatchapp/data/models/trainingInductionModel.dart';
import 'package:wewatchapp/databaseHelper.dart';
import 'package:http/http.dart' as http;
class AccidentIncidentController {
  final conn = SqfliteDatabaseHelper.instance;
  final String columnId = '_id';
  int id;


  Future<int> addData(AccidentModel accidentModel)async{
    var dbclient = await conn.db;
    int result;
    try {
      result = await dbclient.insert(SqfliteDatabaseHelper.accidentIncidentTable, accidentModel.toMap());
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<int> delete(accidentIncidentTable ,id) async {
    var dbclient = await conn.db;
    return await dbclient.rawDelete("DELETE FROM $accidentIncidentTable WHERE id = $id");
//    return await dbclient.delete(SqfliteDatabaseHelper.observationTable., where: '$ = ?', whereArgs: [observationModel]);
  }

  Future<void> DropTable() async {
    var dbclient = await conn.db;


    await dbclient.execute("DELETE FROM accidentIncidentTable");

  }

  Future<int> updateData(AccidentModel accidentModel)async{
    var dbclient = await conn.db;
    int result;
    try {
      result = await dbclient.update(SqfliteDatabaseHelper.accidentIncidentTable, accidentModel.toMap(),where: 'id=?',whereArgs: [accidentModel.userId]);
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future fetchData()async{
    var dbclient = await conn.db;
    List userList = [];
    try {
      List<Map<String,dynamic>> maps = await dbclient.query(SqfliteDatabaseHelper.accidentIncidentTable,);
      for (var item in maps) {
        userList.add(item);
      }
    } catch (e) {
      print(e.toString());
    }
    return userList;
  }
}