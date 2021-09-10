import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wewatchapp/DbSynchronization/AccidentIncidentSynchronize.dart';
import 'package:wewatchapp/DbSynchronization/Covid19Synchronize.dart';
import 'package:wewatchapp/DbSynchronization/DailyHscSynchronize.dart';
import 'package:wewatchapp/DbSynchronization/DailySecuritySynchronize.dart';
import 'package:wewatchapp/DbSynchronization/DailySiteVisitorSynchronize.dart';
import 'package:wewatchapp/DbSynchronization/TrainingInductionSynchronize.dart';
import 'package:wewatchapp/DbSynchronization/syncronize.dart';
import 'package:wewatchapp/consts.dart';
import 'package:wewatchapp/data/models/projectListModel.dart';
import 'package:wewatchapp/data/models/projectsModel.dart';
import 'package:wewatchapp/data/repositories/projectsRepository.dart';
import 'package:wewatchapp/data/screens/client/single_projectDetails.dart';
import 'package:wewatchapp/data/screens/client/view_accident_incident_report.dart';
import 'package:wewatchapp/data/screens/client/view_covid19_report.dart';
import 'package:wewatchapp/data/screens/client/view_observation_report.dart';
import 'package:wewatchapp/data/screens/client/view_site_visitors_report.dart';
import 'package:wewatchapp/data/screens/client/view_training_induction_report.dart';
import 'package:wewatchapp/data/screens/user/daily_security_repo.dart';
import 'package:wewatchapp/data/widgets/Custom_Button.dart';
import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';
import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';

import '../../../Connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';


class projectDashboard extends StatefulWidget {
  projectDashboard({Key key,}) : super(key: key);

  @override
  _projectDashboard createState() => _projectDashboard();
}

class _projectDashboard extends State<projectDashboard> {


  var scaffoldKey = GlobalKey<ScaffoldState>();
  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;
  Timer timer ;
  String Lat = '';
  String Long = '';
  String temp  = "- -";
  var icon_url = "01d.png";
  final ProjectRepository _projectRepo = ProjectRepository();
   ProjectListModel _projectListModel = ProjectListModel();


  @override
  void initState() {
    super.initState();
    // this.getWeather();
    // _connectivity.initialise();
    // _connectivity.myStream.listen((source) {
    //   setStateIfMounted(() => _source = source);
    // });
    //
    // startTimer();
    CheckInternet();

  }

  @override
  void dispose() {
    // timer.cancel();
    super.dispose();
  }
  //
  // void setStateIfMounted(f) {
  //   if (mounted) setState(f);
  // }
  //
  // startTimer() {
  //   timer = Timer.periodic(Duration(seconds: 5), (Timer t) => checkNetThanSend() );
  //
  // }
  // void pauseTimer() {
  //   if (timer != null) timer.cancel();
  // }
  //
  // void unpauseTimer() => startTimer();

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  Future getWeather() async {

    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        Position position = await _determinePosition();
        // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        setState(() {
          Lat= position.latitude.toString();
          Long = position.longitude.toString();
          print(Lat);
          print(Long);

        });

        String uri ="https://api.openweathermap.org/data/2.5/weather?lat=$Lat&lon=$Long&units=metric&appid=c77442b715a725c1a34e37121bca1d5c";


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
    } on Exception catch (_) {
      print('error');
    }

  }

//   Future syncToMysql() async{
//     pauseTimer();
//
//     await SyncronizationData().fetchAllInfo().then((userList)async{
// //      EasyLoading.show(status: 'Dont close app. we are sync...');
//       await SyncronizationData().saveToMysqlWith(userList);
// //      EasyLoading.showSuccess('Successfully save to mysql');
//
//     });
//     await TrainingInductionSync().fetchAllInfo().then((userList)async{
// //      EasyLoading.show(status: 'Dont close app. we are sync...');
//       await TrainingInductionSync().saveToMysqlWith(userList);
// //      EasyLoading.showSuccess('Successfully save to mysql');
//
//     });
//
//     await AccidentIncidentSynchronize().fetchAllInfo().then((userList)async{
// //      EasyLoading.show(status: 'Dont close app. we are sync...');
//       await AccidentIncidentSynchronize().saveToMysqlWith(userList);
// //      EasyLoading.showSuccess('Successfully save to mysql');
//
//     });
//
//     await Covid19Sync().fetchAllInfo().then((userList)async{
// //      EasyLoading.show(status: 'Dont close app. we are sync...');
//       await Covid19Sync().saveToMysqlWith(userList);
// //      EasyLoading.showSuccess('Successfully save to mysql');
//
//     });
//
//     await DailySiteVisitorSyn().fetchAllInfo().then((userList)async{
// //      EasyLoading.show(status: 'Dont close app. we are sync...');
//       await DailySiteVisitorSyn().saveToMysqlWith(userList);
// //      EasyLoading.showSuccess('Successfully save to mysql');
//
//     });
//
// //    await DailySecuritySynch().fetchAllInfo().then((userList)async{
// ////      EasyLoading.show(status: 'Dont close app. we are sync...');
// //      await DailySecuritySynch().saveToMysqlWith(userList);
// ////      EasyLoading.showSuccess('Successfully save to mysql');
// //
// //    });
//
// //    await DailyHscSync().fetchAllInfo().then((userList)async{
// ////      EasyLoading.show(status: 'Dont close app. we are sync...');
// //      await DailyHscSync().saveToMysqlWith(userList);
// ////      EasyLoading.showSuccess('Successfully save to mysql');
// //
// //    });
//     unpauseTimer();
//   }

  // Future checkNetThanSend() async{
  //   switch (_source.keys.toList()[0]) {
  //     case ConnectivityResult.wifi:
  //     case ConnectivityResult.mobile:
  //       print("MANAGER DB");
  //
  //       // syncToMysql();
  //       break;
  //   }
  // }

  CheckInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');


        // projectMethod();
      }
    } catch (e) {
      if(e is SocketException){
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
      else if(e is TimeoutException){
        //treat TimeoutException
        print("Timeout exception: ${e.toString()}");
      }
      else print("Unhandled exception: ${e.toString()}");
    }

  }

  // projectMethod() async {
  //   Future<Projects> projectResponse ;
  //   projectResponse = _projectRepo.GetProjectList()  ;
  //   projectResponse.then((Projects) async {
  //     SharedPreferences projectData = await SharedPreferences.getInstance();
  //     String projectJSON = jsonEncode(Projects);
  //
  //     projectData.setString(projectKey, projectJSON);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final ProjectListModel _listModel = ModalRoute.of(context).settings.arguments;
    _projectListModel = _listModel;

    return WillPopScope (
        onWillPop: () {
          return _moveToPreviousScreen(context);
        },
        child: new SafeArea(
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
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.only(top: 10.0,right: 20.0,left: 20.0 ,bottom: 10.0),
                  color: Colors.blue[50],

                  child: SingleChildScrollView(
                      child:
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/1,
                            height: 40.0,
                            margin: EdgeInsets.only(top: 10.0,right: 20.0,left: 20.0),
                            child: Text(_listModel.projectName, style: TextStyle(color: Colors.black87,fontWeight:FontWeight.w500, fontSize: 25.0),),

                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/1,
                            height: 30.0,
                            margin: EdgeInsets.only(top: 10.0,right: 20.0,left: 20.0),
                            child: Text('Dashboard', style: TextStyle(color: Colors.black87,fontWeight:FontWeight.w500, fontSize: 21.0),),

                          ),
                          Column(

                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width/1,
                                height: 60.0,
                                margin: EdgeInsets.only(top: 20.0,right: 20.0,left: 20.0),
                                child: ElevatedButton(

                                    style: ElevatedButton.styleFrom(
                                      primary: AccidentColor,
                                      onPrimary: Colors.grey,
                                    ),

//                                                       ),
                                    child: Container(
                                      child: Text('Accident Incident Report', style: TextStyle(color: Colors.white,fontSize: 16.0),),

                                    ),

                                    onPressed: (){
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => view_accident_incident_report(),settings: RouteSettings( arguments: _listModel )),
                                      );
                                      //Actions
                                    }
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width/1,
                                height: 60.0,
                                margin: EdgeInsets.only(top: 20.0,right: 20.0,left: 20.0),
                                child: ElevatedButton(

                                    style: ElevatedButton.styleFrom(
                                      primary: CovidColor,
                                      onPrimary: Colors.grey,
                                    ),

//                                                       ),
                                    child: Container(
                                      child: Text('Covid-19 Report', style: TextStyle(color: Colors.white,fontSize: 16.0),),

                                    ),

                                    onPressed: (){
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => view_covid19_report(),settings: RouteSettings( arguments: _listModel )),
                                      );
                                    }
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width/1,
                                height: 60.0,
                                margin: EdgeInsets.only(top: 20.0,right: 20.0,left: 20.0),
                                child: ElevatedButton(

                                    style: ElevatedButton.styleFrom(
                                      primary: TrainingColor,
                                      onPrimary: Colors.grey,
                                    ),

//                                                       ),
                                    child: Container(
                                      child: Text('Training Induction Report', style: TextStyle(color: Colors.white,fontSize: 16.0),),

                                    ),

                                    onPressed: (){
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => view_training_induction_report(),settings: RouteSettings( arguments: _listModel )),
                                      );
                                    }
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width/1,
                                height: 60.0,
                                margin: EdgeInsets.only(top: 20.0,right: 20.0,left: 20.0),
                                child: ElevatedButton(

                                    style: ElevatedButton.styleFrom(
                                      primary: SiteColor,
                                      onPrimary: Colors.grey,
                                    ),

//                                                       ),
                                    child: Container(
                                      child: Text('Site Visitors Report', style: TextStyle(color: Colors.white,fontSize: 16.0),),

                                    ),

                                    onPressed: (){
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => view_site_visitors_report(),settings: RouteSettings( arguments: _listModel )),
                                      );
                                    }
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width/1,
                                height: 60.0,
                                margin: EdgeInsets.only(top: 20.0,right: 20.0,left: 20.0),
                                child: ElevatedButton(

                                    style: ElevatedButton.styleFrom(
                                      primary: ObservationColor,
                                      onPrimary: Colors.grey,
                                    ),

//                                                       ),
                                    child: Container(
                                      child: Text('Observation Report', style: TextStyle(color: Colors.white,fontSize: 16.0),),

                                    ),

                                    onPressed: (){
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => view_observation_report(),settings: RouteSettings( arguments: _listModel )),
                                      );
                                    }
                                ),
                              ),
//                               Container(
//                                 width: MediaQuery.of(context).size.width/1,
//                                 height: 60.0,
//                                 margin: EdgeInsets.only(top: 20.0,right: 20.0,left: 20.0),
//                                 child: ElevatedButton(
//
//                                     style: ElevatedButton.styleFrom(
//                                       primary: SecurityColor,
//                                       onPrimary: Colors.grey,
//                                     ),
//
// //                                                       ),
//                                     child: Container(
//                                       child: Text('Daily Security Report', style: TextStyle(color: Colors.white,fontSize: 16.0),),
//
//                                     ),
//
//                                     onPressed: (){
//                                       FocusScope.of(context).requestFocus(FocusNode());
//                                       // Navigator.push(
//                                       //   context,
//                                       //   MaterialPageRoute(builder: (context) => projectDashboard()),
//                                       // );
//                                       //Actions
//                                     }
//                                 ),
//                               ),
//                               Container(
//                                 width: MediaQuery.of(context).size.width/1,
//                                 height: 60.0,
//                                 margin: EdgeInsets.only(top: 20.0,right: 20.0,left: 20.0),
//                                 child: ElevatedButton(
//
//                                     style: ElevatedButton.styleFrom(
//                                       primary: HSEColor,
//                                       onPrimary: Colors.grey,
//                                     ),
//
// //                                                       ),
//                                     child: Container(
//                                       child: Text('Daily HSE Report', style: TextStyle(color: Colors.white,fontSize: 16.0),),
//
//                                     ),
//
//                                     onPressed: (){
//                                       FocusScope.of(context).requestFocus(FocusNode());
//                                       // Navigator.push(
//                                       //   context,
//                                       //   MaterialPageRoute(builder: (context) => projectDashboard()),
//                                       // );
//                                       //Actions
//                                     }
//                                 ),
//                               ),
                            ],
                          )




                        ],
                      )
                  ),
                )


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

        )
    );


  }
  _moveToPreviousScreen(BuildContext context) =>
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => single_projectDetails(),settings: RouteSettings( arguments: _projectListModel )),
              // (Route<dynamic> route) => false
      );
}
