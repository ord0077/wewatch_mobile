import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wewatchapp/DbSynchronization/AccidentIncidentSynchronize.dart';
import 'package:wewatchapp/DbSynchronization/Covid19Synchronize.dart';
import 'package:wewatchapp/DbSynchronization/DailyHscSynchronize.dart';
import 'package:wewatchapp/DbSynchronization/DailySecuritySynchronize.dart';
import 'package:wewatchapp/DbSynchronization/DailySiteVisitorSynchronize.dart';
import 'package:wewatchapp/DbSynchronization/TrainingInductionSynchronize.dart';
import 'package:wewatchapp/DbSynchronization/syncronize.dart';
import 'package:wewatchapp/consts.dart';
import 'package:wewatchapp/data/models/projectsModel.dart';
import 'package:wewatchapp/data/repositories/projectsRepository.dart';
import 'package:wewatchapp/data/screens/user/daily_security_repo.dart';
import 'package:wewatchapp/data/widgets/Custom_Button.dart';
import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';
import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';

import '../../../Connectivity.dart';
import 'wwmanager_Drawer.dart';
import 'package:http/http.dart' as http;

class wwmanager_Dashboard extends StatefulWidget {
  wwmanager_Dashboard({Key key,}) : super(key: key);

  @override
  _wwmanager_Dashboard createState() => _wwmanager_Dashboard();
}

class _wwmanager_Dashboard extends State<wwmanager_Dashboard> {
  int _counter = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;
  Timer timer;
  double lat = 55.0111;
  double lon = 15.0569;
  String uri = "https://api.openweathermap.org/data/2.5/weather?q=Dubai&units=metric&appid=c77442b715a725c1a34e37121bca1d5c";
  String temp  = "- -";
  var icon_url = "01d.png";
  final ProjectRepository _projectRepo = ProjectRepository();

  @override
  void initState() {
    super.initState();
    this.getWeather();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setStateIfMounted(() => _source = source);
    });
    startTimer();
    CheckInternet();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => checkNetThanSend() );

  }
  void pauseTimer() {
    if (timer != null) timer.cancel();
  }

  void unpauseTimer() => startTimer();



  Future getWeather () async {
    http.Response response = await http.get(Uri.parse(uri));
    var result = jsonDecode(response.body);
    setState(() {
      var tem = result['main']['temp'];
      tem =tem.round();
      this.temp = tem.toString();

      this.icon_url = result["weather"][0]["icon"] +".png";
    });
    print(temp);
  }

  Future syncToMysql() async{
    pauseTimer();

    await SyncronizationData().fetchAllInfo().then((userList)async{
//      EasyLoading.show(status: 'Dont close app. we are sync...');
      await SyncronizationData().saveToMysqlWith(userList);
//      EasyLoading.showSuccess('Successfully save to mysql');

    });
    await TrainingInductionSync().fetchAllInfo().then((userList)async{
//      EasyLoading.show(status: 'Dont close app. we are sync...');
      await TrainingInductionSync().saveToMysqlWith(userList);
//      EasyLoading.showSuccess('Successfully save to mysql');

    });

    await AccidentIncidentSynchronize().fetchAllInfo().then((userList)async{
//      EasyLoading.show(status: 'Dont close app. we are sync...');
      await AccidentIncidentSynchronize().saveToMysqlWith(userList);
//      EasyLoading.showSuccess('Successfully save to mysql');

    });

    await Covid19Sync().fetchAllInfo().then((userList)async{
//      EasyLoading.show(status: 'Dont close app. we are sync...');
      await Covid19Sync().saveToMysqlWith(userList);
//      EasyLoading.showSuccess('Successfully save to mysql');

    });

    await DailySiteVisitorSyn().fetchAllInfo().then((userList)async{
//      EasyLoading.show(status: 'Dont close app. we are sync...');
      await DailySiteVisitorSyn().saveToMysqlWith(userList);
//      EasyLoading.showSuccess('Successfully save to mysql');

    });

//    await DailySecuritySynch().fetchAllInfo().then((userList)async{
////      EasyLoading.show(status: 'Dont close app. we are sync...');
//      await DailySecuritySynch().saveToMysqlWith(userList);
////      EasyLoading.showSuccess('Successfully save to mysql');
//
//    });

//    await DailyHscSync().fetchAllInfo().then((userList)async{
////      EasyLoading.show(status: 'Dont close app. we are sync...');
//      await DailyHscSync().saveToMysqlWith(userList);
////      EasyLoading.showSuccess('Successfully save to mysql');
//
//    });
    unpauseTimer();
  }

  Future checkNetThanSend() async{
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        print("MANAGER DB");
        syncToMysql();
        break;
    }
  }

  CheckInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        projectMethod();
      }
    } on SocketException catch (_) {
      print('not connected');
      Fluttertoast.showToast(
          msg: "No internet connection available",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  projectMethod() async {

    Future<Projects> projectResponse = _projectRepo.GetProjectList() ;
    projectResponse.then((Projects) async {
      SharedPreferences projectData = await SharedPreferences.getInstance();
      String projectJSON = jsonEncode(Projects);

      projectData.setString(projectKey, projectJSON);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          drawer: Theme(
            data: Theme.of(context).copyWith(
                canvasColor: Color.fromRGBO(45, 87, 163, 1) //This will change the drawer background to blue.
              //other styles
            ),
            child: NavDrawer(),
          ),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: Container(
              // color: Theme.of(context).primaryColorLight,
              color: lightBackgroundColor,
              child:   Stack(
                children: <Widget>[
                  new Center(
                      child: new Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 16.0),
                            width: 200,
                            child:Image(image: AssetImage('assets/images/wewatch_logo.png',)),

                          )
                        ],
                      )),
                  Positioned(
                    left: 10,
                    top: 16,
                    child:  GestureDetector(

                        onTap: (){
                          scaffoldKey.currentState.openDrawer();
                        },


                        child: Image.asset(
                          'assets/images/drawer_icon.png',
                          height: 40,
                          width: 40,
                          fit: BoxFit.fitWidth,
                        )
                    ),
                  ),


                ],
              ),
            ),
          ),
          body: Container(
            child: Column(
              children: [
                Container(
        // margin:EdgeInsets.only(left: 20.0,right: 20.0),
                  child:Card(
                      color: Colors.white,
                    shadowColor: Colors.white,
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:  AssetImage('assets/images/weather_bg.png'),
                                fit: BoxFit.fill,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,

//                          crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [


                              Container(
                                height: 60.0,
//                              width: 40.0,
                                child:
                                Image.network('https://openweathermap.org/img/w/$icon_url',
                                    width: 50.0,
                                    fit:BoxFit.cover),
//                              Icon(
//                                Icons.cloud_queue,
//                                size: 50.0,
//                                color: Colors.white,
//                              ),
                              ),

                              Center(
                                child: Text(
                                  temp.toString() !=null ? temp +" °C" : "--",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 25.0,
                                    letterSpacing: -2,
                                  ),
                                ),
                              ),

                            ],

                          ),
                        ],
                      )

                  ),

                ),

                Align(
                    alignment: Alignment.center,
                    child:Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50.0),
                          child: Text('Manager Dashboard',
                            style: TextStyle(fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: DarkBlue),),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary:DarkBlue,
                              onPrimary: Color.fromRGBO(32, 87, 163, 1),
                            ),
                            child: Container(
                              width: 200.0,

                              child: Row(

                                children: <Widget>[
                                  Icon(Icons.refresh,color: Colors.white,),
                                  SizedBox(width: 10.0,),
                                  Text('Refresh project list', style: TextStyle(color: Colors.white),),
                                ],
                              ),
                            ),

                            onPressed:(){
                              CheckInternet();
                            }
                        ),
                      ],
                    ),
                )
              ],
            ),
          ),


        )
//        Align(
//          alignment: Alignment.topCenter,
//          child: Card(
//            child: Column(
//              mainAxisSize: MainAxisSize.min,
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: <Widget>[
//                Container(
//                  padding: EdgeInsets.only(top: 16.0),
//                  width: 200,
//                  child:Image(image: AssetImage('assets/images/wewatch_logo.png',)),
//
//                ),
//                Text(  "Temparature:"  + temp.toString() !=null ? temp.toString()+"°C" : "--"),
//              ],
//            ),
//          ),
//        ),

//      Stack(
//        children: <Widget>[
////          new Center(
////              child: new Column(
////                children: <Widget>[
////                  Container(
////                    padding: EdgeInsets.only(top: 20.0),
////                    width: 200,
////                    child:Image(image: AssetImage('assets/images/wewatch_logo.png',)),
////
////                  )
////                ],
////              )),
////          Positioned(
////            left: 10,
////            top: 20,
////            child: IconButton(
////              icon: Icon(Icons.menu),
////              onPressed: () => scaffoldKey.currentState.openDrawer(),
////            ),
////          ),
//
//
//        ],
//      ),
      // This trailing comma makes auto-formatting nicer for build methods.

    );

  }
}
