import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
import 'package:wewatchapp/data/screens/user/daily_security_repo.dart';
import 'package:wewatchapp/data/widgets/Custom_Button.dart';
import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';
import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';

import '../../../Connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';


class client_Dashboard extends StatefulWidget {
  client_Dashboard({Key key,}) : super(key: key);

  @override
  _client_Dashboard createState() => _client_Dashboard();
}

class _client_Dashboard extends State<client_Dashboard> {


  var scaffoldKey = GlobalKey<ScaffoldState>();
  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;
  // Timer timer;
  String Lat = '';
  String Long = '';
  String temp  = "- -";
  var icon_url = "01d.png";
  final ProjectRepository _projectRepo = ProjectRepository();

  // List data;
  // List<ProjectListModel> _projectListModel;
  Future<List<ProjectListModel>> _projectlList;
  ProjectListModel projectList = ProjectListModel();


  @override
  void initState() {
    super.initState();
      // getData();
    _projectlList= this.getData();

    this.getWeather();
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

  // void setStateIfMounted(f) {
  //   if (mounted) setState(f);
  // }

  // startTimer() {
  //   timer = Timer.periodic(Duration(seconds: 5), (Timer t) => checkNetThanSend() );
  //
  // }
  // void pauseTimer() {
  //   if (timer != null) timer.cancel();
  // }

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

  Future<List<ProjectListModel>> getData() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenn = ( prefs.getString('token'));
    int id = (prefs.getInt(('user_id')));

    String token = 'Bearer '+ tokenn;
//    final apiUrl = 'https://orangeroomdigital.com/sscp/public/api/btl_records';
    final apiUrl = baseURL + 'projectbyuserid/'+ id.toString();
    List<ProjectListModel> records = [];

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        var result = await http.get(
          Uri.parse(apiUrl), headers: { 'Content-type': 'application/json',
          'Accept': 'application/json',HttpHeaders.authorizationHeader: token},);


        var response = json.decode(result.body);
//        print(response);
//        List<Datum> data = [];
//        data= response;
//        dbHelper.save(data);

//         List<District> dis = [];


        for (var u in response) {
          ProjectListModel Item = ProjectListModel( id: u['id'],projectName: u['project_name'] ,projectLogo: u["project_logo"], user: User(name: u["user"]["name"]),startDate:  DateTime.tryParse(u["start_date"]),endDate: DateTime.tryParse(u["end_date"]) ,location: u["location"] );

          records.add(Item);
//          List<Datum> data = [];
//          data= records;
//          dbHelper.save(Item);
          print(records);
//      dis.add(d);

        }

      }
    } on SocketException catch (_) {

      print('not connected');
    }
//    print("${_btlModel.data[0].taskTitle}");
    return records ;



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
                                child: CachedNetworkImage(
                                  imageUrl: "https://openweathermap.org/img/w/$icon_url",
                                  // progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  //     SizedBox(
                                  //       child: CircularProgressIndicator(),
                                  //       height: 3.0,
                                  //       width: 10.0,
                                  //
                                  //     ),
                                  errorWidget: (context, url, error) => Icon(Icons.error,color: DarkBlue,),
                                ),
                                // Image.network('https://openweathermap.org/img/w/$icon_url',
                                //     width: 50.0,
                                //     fit:BoxFit.cover),
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
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 15.0,left: 15.0,bottom: 15.0),
                    child: Text(' Project List',
                      style: TextStyle(fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: DarkBlue),),
                  ),
                ),
                Expanded(child:
                    SingleChildScrollView(

                      physics: ScrollPhysics(),
                      // child: Scrollbar(
                        child:Column(

                          children: [


                            FutureBuilder<List<ProjectListModel>>(

                              future: _projectlList,
                              builder: (BuildContext context, AsyncSnapshot snapshot) {
                                if( snapshot.connectionState == ConnectionState.waiting)
                                  return Center(
                                      child:SpinKitFadingCircle(
                                        color: DarkBlue,
                                        size: 70.0,)

                                  );
                                else if(snapshot.hasError){
                                  return Center(
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,

                                          children: <Widget>[
                                            Text("Problem in fetching data ..!",  style: TextStyle(height: 2, fontSize:20),),
                                            Text("Try again later",  style: TextStyle(height: 2, fontSize: 20),),

                                          ],
                                        ),
                                      )
                                  );
                                }
                                else {
                                  if (snapshot.hasData && snapshot.data.isNotEmpty) {
                                    List<ProjectListModel> data = snapshot.data;
//              final f = new DateFormat('yyyy-MM-dd');

//              print(_p_address(snapshot.data[0]));
                                    return Container(
                                      width: MediaQuery.of(context).size.width/2,
                                      child:
                                          Scrollbar(
                                            child: ListView.builder(
                                                physics: NeverScrollableScrollPhysics(),

                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemCount: data.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  return Container(

                                                    // height: 60.0,
                                                    child: ElevatedButton(

                                                      style: ElevatedButton.styleFrom(
                                                        primary:DarkBlue,
                                                        onPrimary: Color.fromRGBO(32, 87, 163, 1),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => single_projectDetails(),settings: RouteSettings( arguments: projectList =data[index] )),
                                                        );
                                                      },
                                                      child: Container(
                                                          padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                                                          // width: MediaQuery.of(context).size.width/2,
                                                          child:Column(
                                                            children: [
                                                              Text(data[index].projectName, style: TextStyle(color: Colors.white),)

                                                            ],
                                                          )
                                                      ),


                                                    ),
                                                  );
                                                }
                                            ),
                                          ),

                                    ) ;


                                  }

                                  else {
                                    return Center(child: SpinKitFadingCircle(
                                      color:DarkBlue,
                                      size: 50.0,)
                                    );
                                  }
                                }
                              },


                            ),
                            ///
                          ],
                        ),
                      // ),

                    )

                )
                // Align(
                //   alignment: Alignment.center,
                //   child:


                // )
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
