//import 'dart:async';
////import 'dart:io';
////
////import 'package:connectivity/connectivity.dart';
////import 'package:data_connection_checker/data_connection_checker.dart';
////import 'package:flutter/material.dart';
////import 'package:flutter_easyloading/flutter_easyloading.dart';
////import 'package:fluttertoast/fluttertoast.dart';
////import 'package:wewatchapp/Connectivity.dart';
////import 'package:wewatchapp/data/syncronize.dart';
////import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';
////import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';
////
////import '../../consts.dart';
////import 'package:flutter/scheduler.dart';
////
////class Dashboard extends StatefulWidget {
////  Dashboard({Key key,}) : super(key: key);
////
////  // This widget is the home page of your application. It is stateful, meaning
////  // that it has a State object (defined below) that contains fields that affect
////  // how it looks.
////
////  // This class is the configuration for the state. It holds the values (in this
////  // case the title) provided by the parent (in this case the App widget) and
////  // used by the build method of the State. Fields in a Widget subclass are
////  // always marked "final".
////
////
////  @override
////  _Dashboard createState() => _Dashboard();
////}
////
////class _Dashboard extends State<Dashboard> {
////  int _counter = 0;
////  var scaffoldKey = GlobalKey<ScaffoldState>();
////  Timer _timer;
////  bool hasConnection = false;
////
//////  Map _source = {ConnectivityResult.none: false};
//////  MyConnectivity _connectivity = MyConnectivity.instance;
//////  Timer timer;
////
////  bool _hasNetworkConnection;
////  bool _fallbackViewOn;
////
////
////
////  @override
////  void initState() {
////    super.initState();
//////    _hasNetworkConnection = false;
//////    _fallbackViewOn = false;
////
//////    ConnectionStatusSingleton connectionStatus =
//////    ConnectionStatusSingleton.getInstance();
//////    connectionStatus.connectionChange.listen(_updateConnectivity);
////
////
//////    _connectivity.initialise();
//////    _connectivity.myStream.listen((source) {
//////      setStateIfMounted(() => _source = source);
//////    });
//////
//////    timer = Timer.periodic(Duration(seconds: 10), (Timer t) => net() );
////
////
////  }
////
////  void setStateIfMounted(f) {
////    if (mounted) setState(f);
////  }
////
//////  void _updateConnectivity(dynamic hasConnection) {
//////
//////    if (!_hasNetworkConnection) {
//////      if (!_fallbackViewOn) {
//////        print("DANIYAL");
////////        navigatorKey.currentState.pushNamed(FallbackConnection.route);
//////        setState(() {
//////          _fallbackViewOn = true;
//////          _hasNetworkConnection = hasConnection;
//////        });
//////      }
//////    } else {
//////      if (_fallbackViewOn) {
//////        syncToMysql();
////////        navigatorKey.currentState.pop(context);
//////        setState(() {
//////          _fallbackViewOn = false;
//////          _hasNetworkConnection = hasConnection;
//////        });
//////      }
//////    }
//////  }
////
////
////
//////
//////     SendtoSql() async {
//////
//////    await SyncronizationData.isInternet().then((connection){
//////      if (connection) {
//////        syncToMysql();
//////        print("Internet connection abailale");
//////      }else{
//////        print("no Internet connection abailale");
////////                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Internet")));
//////      }
//////    });
//////  }
////
//////
//////  Future syncToMysql() async{
//////    await SyncronizationData().fetchAllInfo().then((userList)async{
//////      EasyLoading.show(status: 'Dont close app. we are sync...');
//////      await SyncronizationData().saveToMysqlWith(userList);
//////      EasyLoading.showSuccess('Successfully save to mysql');
//////    });
//////  }
//////
//////  net() async{
//////    switch (_source.keys.toList()[0]) {
//////      case ConnectivityResult.wifi:
//////      case ConnectivityResult.mobile:
//////        print("DANIYAL");
//////        syncToMysql();
//////        break;
//////    }
//////  }
////
////  @override
////  Widget build(BuildContext context) {
////
//////  try {
//////    if (_source.keys.toList()[0] == ConnectivityResult.wifi ||
//////        _source.keys.toList()[0] == ConnectivityResult.mobile) {
//////      syncToMysql();
//////    }
//////    else {
//////      print("abc");
//////    }
//////  } on SocketException catch (_) {
//////    Fluttertoast.showToast(
//////        msg: "No internet connection availablee",
//////        toastLength: Toast.LENGTH_SHORT,
//////        gravity: ToastGravity.BOTTOM,
//////        timeInSecForIosWeb: 1,
//////        backgroundColor: Colors.black54,
//////        textColor: Colors.white,
//////        fontSize: 16.0
//////    );
//////
//////  }
////
//////    if(_source.keys.toList()[0] == ConnectivityResult.wifi || _source.keys.toList()[0] == ConnectivityResult.mobile ){
//////      syncToMysql();
//////    }
//////    else {
//////      print("abc");
////////    Fluttertoast.showToast(
////////    msg: "No internet connection availablee",
////////    toastLength: Toast.LENGTH_SHORT,
////////    gravity: ToastGravity.BOTTOM,
////////    timeInSecForIosWeb: 1,
////////    backgroundColor: Colors.black54,
////////    textColor: Colors.white,
////////    fontSize: 16.0
////////    );
//////    }
////
////
//////    switch (_source.keys.toList()[0]) {
//////      case ConnectivityResult.wifi:
//////      case ConnectivityResult.mobile:
//////        syncToMysql();
//////        break;
//////    }
////
////    return MaterialApp(
////      home: SafeArea(
////        child: Scaffold(
////          key: scaffoldKey,
////          drawer: Theme(
////            data: Theme.of(context).copyWith(
////                canvasColor: Color.fromRGBO(45, 87, 163, 1) //This will change the drawer background to blue.
////              //other styles
////            ),
////            child: NavDrawer(),
////          ),
////          appBar: PreferredSize(
////            preferredSize: const Size.fromHeight(70.0),
////            child: Container(
////              // color: Theme.of(context).primaryColorLight,
////              color: lightBackgroundColor,
////              child:   Stack(
////                children: <Widget>[
////                  new Center(
////                      child: new Column(
////                        children: <Widget>[
////                          Container(
////                            padding: EdgeInsets.only(top: 16.0),
////                            width: 200,
////                            child:Image(image: AssetImage('assets/images/wewatch_logo.png',)),
////
////                          )
////                        ],
////                      )),
////                  Positioned(
////                    left: 10,
////                    top: 16,
////                    child:  GestureDetector(
////
////                        onTap: (){
////                          scaffoldKey.currentState.openDrawer();
////                        },
////
////
////                        child: Image.asset(
////                          'assets/images/drawer_icon.png',
////                          height: 40,
////                          width: 40,
////                          fit: BoxFit.fitWidth,
////                        )
////                    ),
////                  ),
////
////
////                ],
////              ),
////            ),
////
////          ),
////          body:Center( child:Container( child:Column(
////            children: [
////              Text('Dashboard',
////                style: TextStyle( fontSize: 20,fontWeight:FontWeight.bold,color: Colors.blue),),
////
////              IconButton(icon: Icon(Icons.refresh_sharp), onPressed: ()async {
//////                await SyncronizationData.isInternet().then((connection){
//////                  if (connection) {
////////                    syncToMysql();
//////                    print("Internet connection abailale");
//////                  }else{
////////                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Internet")));
//////                  }
//////                });
////              })
////            ],
////          )
////
////          )),
//////      Stack(
//////        children: <Widget>[
////////          new Center(
////////              child: new Column(
////////                children: <Widget>[
////////                  Container(
////////                    padding: EdgeInsets.only(top: 20.0),
////////                    width: 200,
////////                    child:Image(image: AssetImage('assets/images/wewatch_logo.png',)),
////////
////////                  )
////////                ],
////////              )),
////////          Positioned(
////////            left: 10,
////////            top: 20,
////////            child: IconButton(
////////              icon: Icon(Icons.menu),
////////              onPressed: () => scaffoldKey.currentState.openDrawer(),
////////            ),
////////          ),
//////
//////
//////        ],
//////      ),
////          // This trailing comma makes auto-formatting nicer for build methods.
////        ),
////      ),
//////      debugShowCheckedModeBanner: false,
//////      builder: EasyLoading.init(),
////    );
////
////
////
////  }
////
//////  @override
//////  void dispose() {
//////    timer?.cancel();
//////    _connectivity.disposeStream();
//////    super.dispose();
//////  }
////}
////
//////class MyConnectivity {
//////  MyConnectivity._internal();
//////
//////  static final MyConnectivity _instance = MyConnectivity._internal();
//////
//////  static MyConnectivity get instance => _instance;
//////
//////  Connectivity connectivity = Connectivity();
//////
//////  StreamController controller = StreamController.broadcast();
//////
//////  Stream get myStream => controller.stream;
//////
//////  void initialise() async {
//////    ConnectivityResult result = await connectivity.checkConnectivity();
//////    _checkStatus(result);
//////    connectivity.onConnectivityChanged.listen((result) {
//////      _checkStatus(result);
//////    });
//////  }
//////  void _checkStatus(ConnectivityResult result) async {
//////    bool isOnline = false;
//////    try {
//////      final result = await InternetAddress.lookup('example.com');
//////      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//////        isOnline = true;
//////      } else
//////
//////
//////        isOnline = false;
//////    } on SocketException catch (_) {
//////      Fluttertoast.showToast(
//////          msg: "No internet connection availablee",
//////          toastLength: Toast.LENGTH_SHORT,
//////          gravity: ToastGravity.BOTTOM,
//////          timeInSecForIosWeb: 1,
//////          backgroundColor: Colors.black54,
//////          textColor: Colors.white,
//////          fontSize: 16.0
//////      );
//////      isOnline = false;
//////    }
//////    controller.sink.add({result: isOnline});
//////  }
//////
//////  void disposeStream() => controller.close();
//////}

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:wewatchapp/Connectivity.dart';
import 'package:wewatchapp/DbSynchronization/AccidentIncidentSynchronize.dart';
import 'package:wewatchapp/DbSynchronization/TrainingInductionSynchronize.dart';
import 'package:wewatchapp/DbSynchronization/syncronize.dart';
import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';
import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';
import 'package:http/http.dart' as http;

import '../../consts.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key,}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  int _counter = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;
  Timer timer;
  String key = '856822fd8e22db5e1ba48c0e7d69844a';
  String cityName = 'Kongens Lyngby';
//  WeatherFactory wf = WeatherFactory('856822fd8e22db5e1ba48c0e7d69844a');
  String uri = "https://api.openweathermap.org/data/2.5/weather?q=Dubai&units=metric&appid=c77442b715a725c1a34e37121bca1d5c";
  double temp  = 00;
  var icon_url = "01d.png";

  @override
  void initState() {
    super.initState();
    this.getWeather();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setStateIfMounted(() => _source = source);
    });
    startTimer();
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

    unpauseTimer();
  }

  Future checkNetThanSend() async{
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        print("USER DB");
        syncToMysql();
        break;
    }
  }

  Future getWeather () async {
    http.Response response = await http.get(uri);
    var result = jsonDecode(response.body);
    setState(() {
      this.temp = result['main']['temp'];
      this.icon_url = result["weather"][0]["icon"] +".png";
    });
    print(temp);
  }

  @override
  Widget build(BuildContext context) {


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
        margin:EdgeInsets.only(left: 20.0,right: 20.0),
                  child:Card(
                      color: Colors.blueGrey[100],
                      shadowColor: Colors.grey,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:  AssetImage('assets/images/ss.jpg'),
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,

//                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              height: 60.0,
//                              width: 40.0,
                              child:
                              Image.network('https://openweathermap.org/img/w/$icon_url',
                                  width: 70.0,
                                  fit:BoxFit.cover),
//                              Icon(
//                                Icons.cloud_queue,
//                                size: 50.0,
//                                color: Colors.white,
//                              ),
                            ),

                            Center(
                              child: Text(
                               temp.toString() !=null ? temp.round().toString()+" °C" : "--",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40.0,
                                  letterSpacing: -5,
                                ),
                              ),
                            ),

                          ],

                        ),

                      )
                  ),

                ),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(top: 50.0),
                      child: Text('User Dashboard',
                        style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: DarkBlue),),
                    )),
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

  @override
  void dispose() {
    timer?.cancel();
//    _connectivity.disposeStream();
    super.dispose();
  }
}

