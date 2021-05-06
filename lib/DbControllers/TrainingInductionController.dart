import 'package:wewatchapp/data/models/observationModel.dart';
import 'package:wewatchapp/data/models/trainingInductionModel.dart';
import 'package:wewatchapp/databaseHelper.dart';
import 'package:http/http.dart' as http;
class TrainingInductionController {
  final conn = SqfliteDatabaseHelper.instance;
  final String columnId = '_id';
  int id;


  Future<int> addData(TrainingInducModel trainingInducModel)async{
    var dbclient = await conn.db;
    int result;
    try {
      result = await dbclient.insert(SqfliteDatabaseHelper.trainingInductionTable, trainingInducModel.toMap());
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<int> delete(trainingInductionTable,id) async {
    var dbclient = await conn.db;
    return await dbclient.rawDelete("DELETE FROM $trainingInductionTable WHERE id = $id");
//    return await dbclient.delete(SqfliteDatabaseHelper.observationTable., where: '$ = ?', whereArgs: [observationModel]);
  }

  Future<void> DropTable() async {
    var dbclient = await conn.db;


    await dbclient.execute("DELETE FROM trainingInductionTable");

  }

  Future<int> updateData(TrainingInducModel trainingInducModel)async{
    var dbclient = await conn.db;
    int result;
    try {
      result = await dbclient.update(SqfliteDatabaseHelper.observationTable, trainingInducModel.toMap(),where: 'id=?',whereArgs: [trainingInducModel.userId]);
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future fetchData()async{
    var dbclient = await conn.db;
    List userList = [];
    try {
      List<Map<String,dynamic>> maps = await dbclient.query(SqfliteDatabaseHelper.trainingInductionTable,);
      for (var item in maps) {
        userList.add(item);
      }
    } catch (e) {
      print(e.toString());
    }
    return userList;
  }
}