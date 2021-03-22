import 'package:flutter/material.dart';
import 'package:wewatchapp/consts.dart';
import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';
import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';

import 'wwmanager_Drawer.dart';


class wwmanager_Dashboard extends StatefulWidget {
  wwmanager_Dashboard({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _wwmanager_Dashboard createState() => _wwmanager_Dashboard();
}

class _wwmanager_Dashboard extends State<wwmanager_Dashboard> {
  int _counter = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();


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
      body:Center( child:Container(
        child: Text('Manager Dashboard',
          style: TextStyle( fontSize: 20,fontWeight:FontWeight.bold,color: Colors.blue),),
      )),
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
    ),
    );

  }
}
