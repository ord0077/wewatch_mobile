import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
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
import 'package:wewatchapp/data/screens/client/client_dashboard.dart';
import 'package:wewatchapp/data/screens/client/projectDashboard.dart';
import 'package:wewatchapp/data/screens/user/daily_security_repo.dart';
import 'package:wewatchapp/data/widgets/Custom_Button.dart';
import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';
import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';

import '../../../Connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

   // /projectbyuserid/2

class single_projectDetails extends StatefulWidget {
  const single_projectDetails({Key key,  projectDetail,}) : super(key: key);

  @override
  _single_projectDetails createState() => _single_projectDetails();
}

class _single_projectDetails extends State<single_projectDetails> {


  var scaffoldKey = GlobalKey<ScaffoldState>();

  final ProjectRepository _projectRepo = ProjectRepository();
  final f = new DateFormat('yyyy-MM-dd');


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final ProjectListModel _listModel = ModalRoute.of(context).settings.arguments;

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
                color: Colors.blue[50],
                child:SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        // color: Colors.red,
                        width: MediaQuery.of(context).size.width/1.5,
                        padding: EdgeInsets.only(top: 20.0,),
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
                                      style: TextStyle(fontSize: 16,
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
                                      child: CachedNetworkImage(
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
                                      // Image.network('https://openweathermap.org/img/w/$icon_url',
                                      //     width: 50.0,
                                      //     fit:BoxFit.cover),
                                    ),
                                  ),
                                ],
                              ),
                            )


                        ),

                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child:Container(
                          // color: Colors.red,
                          width: MediaQuery.of(context).size.width/1.25,
                          padding: EdgeInsets.only(top: 20.0,),
                          // margin:EdgeInsets.only(left: 20.0,right: 20.0),
                          child:Card(

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
                                physics: ScrollPhysics(),
                                child: Column(

                                  children: <Widget>[
                                    SizedBox(
                                      height: 30.0,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 0.0,right: 10.0),

//            height: MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width ,
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
                                                      height: 20.0,
                                                    ),
                                                    Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Container(
                                                        margin: const EdgeInsets.only( left: 20.0),

                                                        child: Text("Project ID",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17.0),),
                                                      ),

                                                    ),

                                                    SizedBox(
                                                      height: 20.0,
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

                                                        child:Text( _listModel.id.toString() ?? '---',style: TextStyle(fontSize: 17.0)),
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
                                                      height: 20.0,
                                                    ),
                                                    Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Container(
                                                        margin: const EdgeInsets.only( left: 20.0),

                                                        child: Text("Dashboard",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17.0),),
                                                      ),

                                                    ),

                                                    SizedBox(
                                                      height: 20.0,
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

                                                        child:ElevatedButton(

                                                            style: ElevatedButton.styleFrom(
                                                              primary: DarkBlue,
                                                              onPrimary: Color.fromRGBO(32, 87, 163, 1),
                                                            ),

//                                                       ),
                                                            child: Container(
                                                              alignment: Alignment.center,
                                                              padding: const EdgeInsets.only( top: 5.0 , bottom: 5),
                                                              child: Text('Open Dashboard', style: TextStyle(color: Colors.white),),

                                                            ),

                                                            onPressed: (){
                                                              FocusScope.of(context).requestFocus(FocusNode());
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(builder: (context) => projectDashboard(),settings: RouteSettings( arguments: _listModel )),
                                                              );
                                                              //Actions
                                                            }
                                                        ),
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
                                                      height: 20.0,
                                                    ),
                                                    Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Container(
                                                        margin: const EdgeInsets.only( left: 20.0),

                                                        child: Text("Project Admin",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17.0),),
                                                      ),

                                                    ),

                                                    SizedBox(
                                                      height: 20.0,
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

                                                        child:Text( _listModel.user.name?? '----',style: TextStyle(fontSize: 17.0,),textAlign: TextAlign.right,),
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
                                                      height: 20.0,
                                                    ),
                                                    Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Container(
                                                        margin: const EdgeInsets.only( left: 20.0),

                                                        child: Text("Start Date",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17.0),),
                                                      ),

                                                    ),

                                                    SizedBox(
                                                      height: 20.0,
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

                                                        child:Text( f.format(_listModel.startDate ?? "----"),style: TextStyle(fontSize: 17.0)),
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
                                                      height: 20.0,
                                                    ),
                                                    Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Container(
                                                        margin: const EdgeInsets.only( left: 20.0),

                                                        child: Text("End Date",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17.0),),
                                                      ),

                                                    ),

                                                    SizedBox(
                                                      height: 20.0,
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

                                                        child:Text( f.format(_listModel.endDate ?? "----"),style: TextStyle(fontSize: 17.0)),
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
                                                      height: 20.0,
                                                    ),
                                                    Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Container(
                                                        margin: const EdgeInsets.only( left: 20.0),

                                                        child: Text("Location",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17.0),),
                                                      ),

                                                    ),

                                                    SizedBox(
                                                      height: 20.0,
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

                                                        child:Text( _listModel.location?? '----',style: TextStyle(fontSize: 17.0)),
                                                      ),
                                                    ),



                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),





                                        ],
                                      ),

                                      // ),

                                    )
                                  ],
                                ),
                              )


                          ),

                        ),
                      )
                    ],
                  ),
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
  _moveToPreviousScreen(BuildContext context) =>
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => client_Dashboard()),
        // (Route<dynamic> route) => false
      );
}
