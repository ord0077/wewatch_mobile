import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_paginator/flutter_paginator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
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
import 'package:wewatchapp/data/models/view_Covid19_Model.dart';
import 'package:wewatchapp/data/repositories/projectsRepository.dart';
import 'package:wewatchapp/data/screens/client/projectDashboard.dart';
import 'package:wewatchapp/data/screens/user/daily_security_repo.dart';
import 'package:wewatchapp/data/widgets/Custom_Button.dart';
import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';
import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';



class view_covid19_report extends StatefulWidget {
  view_covid19_report({Key key,}) : super(key: key);

  @override
  _view_covid19_report createState() => _view_covid19_report();
}

class _view_covid19_report extends State<view_covid19_report> {
  GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();


  var scaffoldKey = GlobalKey<ScaffoldState>();

  final ProjectRepository _projectRepo = ProjectRepository();
  int progId ;
  ProjectListModel _projectListModel = ProjectListModel();

  int progress = 0;
  ReceivePort receivePort = ReceivePort();
  @override
  void initState() {
    // IsolateNameServer.registerPortWithName(receivePort.sendPort, "downloading");
    // receivePort..listen((message) {
    //   if(mounted) {
    //     setState(() {
    //       progress = message;
    //     });
    //   }
    // });
    // FlutterDownloader.registerCallback(downloadCallBack);

    super.initState();
  }

  // static downloadCallBack(id, status, progress){
  //   SendPort sendPort = IsolateNameServer.lookupPortByName('downloading');
  //   sendPort.send(progress);
  // }

  @override
  void dispose() {

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final ProjectListModel _listModel = ModalRoute.of(context).settings.arguments;
    progId = _listModel.id;
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
              body:
              Container(
                color: Colors.blue[50],
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      // color: Colors.red,
                      width: MediaQuery.of(context).size.width/1.5,
                      padding: EdgeInsets.only(top: 10.0,),
                      // margin:EdgeInsets.only(left: 20.0,right: 20.0),
                      child:Card(

                          color: Colors.white,
                          shadowColor: Colors.white,
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            side: new BorderSide(color: DarkBlue, width: 2.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          elevation: 5,
                          // margin: EdgeInsets.all(30),
                          child:

                          Padding(
                            padding: EdgeInsets.only(top: 15.0,bottom: 15.0,right: 10.0,left: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child:  Text(_listModel.projectName ?? '----',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: DarkBlue),),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: double.infinity,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child:  Container(
                                    height: 40.0,
                                    width: 40.0,
                                    child:
                                    CachedNetworkImage(
                                      imageUrl: _listModel.projectLogo,
                                      // progressIndicatorBuilder: (context, url, downloadProgress) =>
                                      //     SizedBox(
                                      //       child: CircularProgressIndicator(),
                                      //       height: 3.0,
                                      //       width: 10.0,
                                      //
                                      //     ),
                                      errorWidget: (context, url, error) => Icon(Icons.error_outline,color: DarkBlue,),
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          )


                      ),

                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10.0,),
                      margin: EdgeInsets.only(bottom: 10.0,),

                      child:Text('Covid-19 Report',
                        style: TextStyle(fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: DarkBlue),),
                    ),
                    //////here
                    Expanded( child: Scrollbar(
                      child:  Paginator.listView(
                        key: paginatorGlobalKey,
                        pageLoadFuture: sendPagesDataRequest,
                        pageItemsGetter: listItemsGetter,
                        listItemBuilder: listItemBuilder,
                        loadingWidgetBuilder: loadingWidgetMaker,
                        errorWidgetBuilder: errorWidgetMaker,
                        emptyListWidgetBuilder: emptyListWidgetMaker,
                        totalItemsGetter: totalPagesGetter,
                        pageErrorChecker: pageErrorChecker,
                        scrollPhysics: BouncingScrollPhysics(),
                      ),)
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

        )
    );


  }

  void _requestDownload(String link) async {

    final status = await Permission.storage.request();


    if(status.isGranted){
      final baseStorage = await getApplicationDocumentsDirectory();
      final taskId = await FlutterDownloader.enqueue(
        url: 'https://wewatch.ordd.tk/uploads/covid/attach_6130dc9039fc5.docx',
        savedDir: baseStorage.path,
        fileName: "file",
        // showNotification: true, // show download progress in status bar (for Android)
        // openFileFromNotification: true, // click on notification to open downloaded file (for Android)
      );
    }else{
      print("no permission");
    }

  }

  _moveToPreviousScreen(BuildContext context) =>
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => projectDashboard(),settings: RouteSettings( arguments: _projectListModel )),
        // (Route<dynamic> route) => false
      );

  Future<ViewCovid19Model> sendPagesDataRequest(int page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenn = ( prefs.getString('token'));
    int id = (prefs.getInt(('user_id')));


    String token = 'Bearer '+ tokenn;
    String apiUrl = Uri.encodeFull( baseURL +"covid/project/" + progId.toString() +"?page=$page");
    print('page ${page}');
    try {

      http.Response response =  await http.get(
        Uri.parse(apiUrl), headers: { 'Content-type': 'application/json',
        'Accept': 'application/json',HttpHeaders.authorizationHeader: token},);
      print('body ${response.body}');

      /*String responseString = '''
      {"current_page": 1,
"data": [
    { "id": 1, "title": "Germa", "likes": 5, "image": "https://picsum.photos/250?image=8"},
    { "id": 2, "title": "Jepun", "likes": 3, "image": "https://picsum.photos/250?image=9"}
    ],
 "first_page_url": "https:/API_URL?page=1",
 "from": 1,
 "last_page": 30,
 "last_page_url": "https:/API_URLpage=30",
 "next_page_url": "https:/API_URL?page=2"
}
      ''';*/

      ViewCovid19Model viewCovid19Model = viewCovid19ModelFromMap(response.body);
      return viewCovid19Model;
    } catch (e) {
      if (e is IOException) {
        // return ViewAccidentModel.withError(
        //     'Please check your internet connection.');
      } else {
        print(e.toString());
        // return CountriesData.withError('Something went wrong.');
      }
    }
  }

  List<dynamic> listItemsGetter(ViewCovid19Model viewCovid19Model) {
    List<Datum> list = [];
    viewCovid19Model.data.forEach((value) {
      list.add(value);
    });
    return list;
  }

  Widget listItemBuilder(Datum, int index) {
    return
      Container(
          margin: const EdgeInsets.only(left: 40.0,right: 40.0),
          child:
          Card(

              color: Colors.white,
              shadowColor: Colors.white,
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              elevation: 5,
              // margin: EdgeInsets.all(30),
              child:

              SingleChildScrollView(
                child: Column(
                  children: <Widget>[

                    Container(
                      padding: const EdgeInsets.only(left: 0.0,right: 10.0),
//            height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width ,
                      // child: Form(
                      // key: _formKey,
                      // autovalidate: false,
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: const EdgeInsets.only( left: 20.0),

                                        child: Text("Body temperature ",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15.0),),
                                      ),

                                    ),

                                    SizedBox(
                                        height: 10.0                              ),

                                  ],
                                ),
                              ),

                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child:  Container(
                                        margin: const EdgeInsets.only( right: 20.0),

                                        child:Text( Datum.temperature ??"----" ,style: TextStyle(fontSize: 15.0)),
                                      ),
                                    ),



                                  ],
                                ),
                              ),

                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: const EdgeInsets.only( left: 20.0),

                                        child: Text("Staff Name",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15.0),),
                                      ),

                                    ),

                                    SizedBox(
                                      height: 10.0,
                                    ),

                                  ],
                                ),
                              ),

                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child:  Container(
                                        margin: const EdgeInsets.only( right: 20.0),

                                        child:Text( Datum.staffName ??"----",style: TextStyle(fontSize: 15.0)),
                                      ),
                                    ),



                                  ],
                                ),
                              ),

                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: const EdgeInsets.only( left: 20.0),

                                        child: Text("Company Name",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15.0),),
                                      ),

                                    ),

                                    SizedBox(
                                      height: 10.0,
                                    ),

                                  ],
                                ),
                              ),

                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child:  Container(
                                        margin: const EdgeInsets.only( right: 20.0),

                                        child:Text( Datum.company ??"----",style: TextStyle(fontSize: 15.0)),
                                      ),
                                    ),



                                  ],
                                ),
                              ),

                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: const EdgeInsets.only( left: 20.0),

                                        child: Text("Remarks",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15.0),),
                                      ),

                                    ),

                                    SizedBox(
                                      height: 10.0,
                                    ),

                                  ],
                                ),
                              ),

                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child:  Container(
                                        margin: const EdgeInsets.only( right: 20.0),

                                        child:Text( Datum.remarks ??"----",style: TextStyle(fontSize: 15.0)),
                                      ),
                                    ),



                                  ],
                                ),
                              ),

                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: const EdgeInsets.only( left: 20.0,right: 20.0),

                                      child: Text("Attachment",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15.0),),
                                    ),

                                  ),

                                ],
                              )),
                              Expanded(child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                        width: MediaQuery.of(context).size.width/5,
                                        height: MediaQuery.of(context).size.height/5,
                                        child:  FullScreenWidget(
                                          child: Center(
                                            child:
                                            // ElevatedButton.icon(
                                            //   icon: Icon(
                                            //     Icons.favorite,
                                            //     color: Colors.pink,
                                            //     size: 24.0,
                                            //   ),
                                            //   label: Text('Elevated'),
                                            //   onPressed: () {
                                            //     print('Pressed');
                                            //     String a = Datum.image;
                                            //     _requestDownload(a);
                                            //   },
                                            //   style: ElevatedButton.styleFrom(
                                            //     shape: new RoundedRectangleBorder(
                                            //       borderRadius: new BorderRadius.circular(20.0),
                                            //     ),
                                            //   ),
                                            // )
                                            Hero(
                                              tag: 'tagImage $index',
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(16),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl: Datum.image,
                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                      SizedBox(
                                                        child: CircularProgressIndicator(),
                                                        height: 10.0,
                                                        width: 10.0,

                                                      ),

                                                  errorWidget: (context, url, error) => Icon(Icons.error_outline,color: DarkBlue,),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )

                                    ),
                                  ),

                                ],
                              ))
                            ],
                          )



                        ],
                      ),

                      // ),

                    )
                  ],
                ),
              )

          )
      );

  }

  Widget loadingWidgetMaker() {
    return Container(
      alignment: Alignment.center,
      height: 160.0,
      child: CircularProgressIndicator(),
    );
  }

  Widget errorWidgetMaker(ViewCovid19Model viewCovid19Model, retryListener) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("error"),
        ),
        FlatButton(
          onPressed: retryListener,
          child: Text('Retry'),
        )
      ],
    );
  }

  Widget emptyListWidgetMaker(ViewCovid19Model viewCovid19Model) {
    return Center(
      child: Text('No records in the list !',style: TextStyle(fontSize: 15.0)),
    );
  }

  int totalPagesGetter(ViewCovid19Model viewCovid19Model) {
    return viewCovid19Model.total;
  }

  bool pageErrorChecker(ViewCovid19Model viewCovid19Model) {
    // return viewAccidentModel.statusCode != 200;
    return false;
  }
}
