//import 'package:expansion_tile_card/expansion_tile_card.dart';
//import 'package:flutter/material.dart';
//import 'package:wewatchapp/data/login/loginScreen.dart';
//import 'package:wewatchapp/data/screens/guard/project_site_visitor.dart';
//import 'package:wewatchapp/data/screens/user/accident_incident_report.dart';
//import 'file:///C:/Users/user/AndroidStudioProjects/wewatch_app/lib/data/screens/guard/covid_19.dart';
//import 'package:wewatchapp/data/screens/user/daily_hsc_report.dart';
//import 'package:wewatchapp/data/screens/user/daily_security_repo.dart';
//import 'package:wewatchapp/data/screens/user/observation_form.dart';
//import 'package:wewatchapp/data/screens/user/training_induction_form.dart';
//class wwmangerDrawer extends StatefulWidget {
//  wwmangerDrawer({Key key, this.title}) : super(key: key);
//
//  // This widget is the home page of your application. It is stateful, meaning
//  // that it has a State object (defined below) that contains fields that affect
//  // how it looks.
//
//  // This class is the configuration for the state. It holds the values (in this
//  // case the title) provided by the parent (in this case the App widget) and
//  // used by the build method of the State. Fields in a Widget subclass are
//  // always marked "final".
//
//  final String title;
//
//  @override
//  _wwmangerDrawer createState() => _wwmangerDrawer();
//}
//
//class _wwmangerDrawer extends State<wwmangerDrawer> {
////class NavDrawer extends StatelessWidget {
//  bool _isExpanded = false;
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Drawer(
//
//      child: ListView(
//
//        children: <Widget>[
//          DrawerHeader(
//            child:Row(
//          children: [
//          Container(
////          alignment: Alignment.topLeft,
//          height: 50,
////          width: MediaQuery.of(context).size.width,
//          child: Image.asset(
//            "assets/images/menu-icon.png",
//          )),
//      Container(
//        padding: EdgeInsets.only(left: 10.0,right: 10.0),
//        child:Text("Testing User",style: TextStyle(color: Colors.white,fontSize: 18.0)),
//      ),
//      Container(
//
//          padding: EdgeInsets.only(left: 10.0,right: 10.0),
//        child:CircleAvatar(
//          radius:25.0,
//          child: Icon(Icons.face_rounded,size: 50.0,),
//        )
//    )
//        ],
//      ),
//            decoration: BoxDecoration(
//              color: Colors.transparent,
//            ),
//          ),
//          const Divider(
//            color: Colors.white,
//            height: 10,
//            thickness: 2,
//            indent: 20,
//            endIndent: 0,
//          ),
//          ExpansionTile(
////            backgroundColor: Colors.white,
//            leading: Icon(Icons.insert_drive_file,color: Colors.white,) ,
//          title: Text("Contractor Security Brief Register",style: TextStyle(color: Colors.white,fontSize: 14.0),),
//            children: <Widget>[
//              const Divider(
//                color: Colors.white,
//                height: 10,
//                thickness: 2,
//                indent: 20,
//                endIndent: 0,
//              ),
//              ListTile(
//                leading: Icon(Icons.add,color: Colors.white,),
//                title: Text('Add Record',style: TextStyle(color: Colors.white,fontSize: 14.0),),
//                trailing: Icon(Icons.keyboard_arrow_right,color: Colors.white,),
//                onTap: () {
//
//                  // Update the state of the app.
//                  // ...
//                },
//              ),
//              const Divider(
//                color: Colors.white,
//                height: 10,
//                thickness: 2,
//                indent: 20,
//                endIndent: 0,
//              ),
//              ListTile(
//                leading: Icon(Icons.insert_drive_file,color: Colors.white,),
//                title: Text('Record List',style: TextStyle(color: Colors.white,fontSize: 14.0),),
//                trailing: Icon(Icons.keyboard_arrow_right,color: Colors.white,),
//                onTap: () {
//                  // Update the state of the app.
//                  // ...
//                },
//              ),
//
//            ],
//          ),
//          const Divider(
//            color: Colors.white,
//            height: 10,
//            thickness: 2,
//            indent: 20,
//            endIndent: 0,
//          ),
//          ListTile(
//            leading: Icon(Icons.insert_drive_file,color: Colors.white,),
//            title: Text('Accident /  Incident Report',style: TextStyle(color: Colors.white,fontSize: 14.0),),
//            trailing: Icon(Icons.keyboard_arrow_right,color: Colors.white,),
//            onTap: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => AccidentIncidentReport()),
//              );
//              // Update the state of the app.
//              // ...
//            },
//          ),
//          const Divider(
//            color: Colors.white,
//            height: 10,
//            thickness: 2,
//            indent: 20,
//            endIndent: 0,
//          ),
//          ListTile(
//            leading: Icon(Icons.insert_drive_file,color: Colors.white,),
//            title: Text('Project Site Visitors Daily Register',style: TextStyle(color: Colors.white,fontSize: 14.0),),
//            trailing: Icon(Icons.keyboard_arrow_right,color: Colors.white,),
//            onTap: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => project_site_reg()),
//              );
//              // Update the state of the app.
//              // ...
//            },
//          ),
//          const Divider(
//            color: Colors.white,
//            height: 10,
//            thickness: 2,
//            indent: 20,
//            endIndent: 0,
//          ),
//          ListTile(
//            leading: Icon(Icons.insert_drive_file,color: Colors.white,),
//            title: Text('Project Daily Security Report',style: TextStyle(color: Colors.white,fontSize: 14.0),),
//            trailing: Icon(Icons.keyboard_arrow_right,color: Colors.white,),
//            onTap: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => DailySecurityReport()),
//              );
//              // Update the state of the app.
//              // ...
//            },
//          ),
//          const Divider(
//            color: Colors.white,
//            height: 10,
//            thickness: 2,
//            indent: 20,
//            endIndent: 0,
//          ),
////          ListTile(
////            leading: Icon(Icons.insert_drive_file,color: Colors.white,),
////            title: Text('Bomb Threat Form',style: TextStyle(color: Colors.white,fontSize: 14.0),),
////            trailing: Icon(Icons.keyboard_arrow_right,color: Colors.white,),
////            onTap: () {
////              // Update the state of the app.
////              // ...
////            },
////          ),
////          const Divider(
////            color: Colors.white,
////            height: 10,
////            thickness: 2,
////            indent: 20,
////            endIndent: 0,
////          ),
////          ListTile(
////            leading: Icon(Icons.insert_drive_file,color: Colors.white,),
////            title: Text('WW Tool Box Talk',style: TextStyle(color: Colors.white,fontSize: 14.0),),
////            trailing: Icon(Icons.keyboard_arrow_right,color: Colors.white,),
////            onTap: () {
////
////              // Update the state of the app.
////              // ...
////            },
////          ),
////          const Divider(
////            color: Colors.white,
////            height: 10,
////            thickness: 2,
////            indent: 20,
////            endIndent: 0,
////          ),
////          ListTile(
////            leading: Icon(Icons.insert_drive_file,color: Colors.white,),
////            title: Text('Pre & Post Event Safety Inspection Checklist',style: TextStyle(color: Colors.white,fontSize: 14.0),),
////            trailing: Icon(Icons.keyboard_arrow_right,color: Colors.white,),
////            onTap: () {
////              // Update the state of the app.
////              // ...
////            },
////          ),
////          const Divider(
////            color: Colors.white,
////            height: 10,
////            thickness: 2,
////            indent: 20,
////            endIndent: 0,
////          ),
//          ListTile(
//            leading: Icon(Icons.insert_drive_file,color: Colors.white,),
//            title: Text('Covid 19 Temp Register',style: TextStyle(color: Colors.white,fontSize: 14.0),),
//            trailing: Icon(Icons.keyboard_arrow_right,color: Colors.white,),
//            onTap: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => covid_19_reg()),
//              );
//              // Update the state of the app.
//              // ...
//            },
//          ),
//          const Divider(
//            color: Colors.white,
//            height: 10,
//            thickness: 2,
//            indent: 20,
//            endIndent: 0,
//          ),
//          ListTile(
//            leading: Icon(Icons.insert_drive_file,color: Colors.white,),
//            title: Text('Daily HSC Report',style: TextStyle(color: Colors.white,fontSize: 14.0),),
//            trailing: Icon(Icons.keyboard_arrow_right,color: Colors.white,),
//            onTap: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => DailyHscReport()),
//              );
//              // Update the state of the app.
//              // ...
//            },
//          ),
//          const Divider(
//            color: Colors.white,
//            height: 10,
//            thickness: 2,
//            indent: 20,
//            endIndent: 0,
//          ),
//          ListTile(
//            leading: Icon(Icons.insert_drive_file,color: Colors.white,),
//            title: Text('Observation Form',style: TextStyle(color: Colors.white,fontSize: 14.0),),
//            trailing: Icon(Icons.keyboard_arrow_right,color: Colors.white,),
//            onTap: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => ObservationForm()),
//              );
//              // Update the state of the app.
//              // ...
//            },
//          ),
//          const Divider(
//            color: Colors.white,
//            height: 10,
//            thickness: 2,
//            indent: 20,
//            endIndent: 0,
//          ),
//
//          ListTile(
//            leading: Icon(Icons.insert_drive_file,color: Colors.white,),
//            title: Text('Training Induction Form',style: TextStyle(color: Colors.white,fontSize: 14.0),),
//            trailing: Icon(Icons.keyboard_arrow_right,color: Colors.white,),
//            onTap: () {
////              Navigator.push(
////                context,
////                MaterialPageRoute(builder: (context) => training_induction_form()),
////              );
//              // Update the state of the app.
//              // ...
//            },
//          ),
//          const Divider(
//            color: Colors.white,
//            height: 10,
//            thickness: 2,
//            indent: 20,
//            endIndent: 0,
//          ),
//          ListTile(
//            leading: Icon(Icons.logout,color: Colors.white,),
//            title: Text('Logout',style: TextStyle(color: Colors.white,fontSize: 14.0),),
////            trailing: Icon(Icons.keyboard_arrow_right,color: Colors.white,),
//            onTap: () {
//              _exitApp(context);
//              // Update the state of the app.
//              // ...
//            },
//          ),
//
//
//        ],
//      ),
//    );
////    return Drawer(
////      child: ListView(
////        padding: EdgeInsets.zero,
////        children: <Widget>[
////          DrawerHeader(
////            child: Text(
////              'WeWatch',
////              style: TextStyle(color: Colors.white, fontSize: 25),
////            ),
////            decoration: BoxDecoration(
////              color: Color.fromRGBO(45, 87, 163, 1),
//////                image: DecorationImage(
//////                    fit: BoxFit.fill,
//////                    image: AssetImage('assets/images/cover.jpg'))
////            ),
////          ),
////          ExpansionTile(
////            onExpansionChanged: (b) {
////              setState(() {
////                _isExpanded = !_isExpanded; //using set state just to exemplify
////              });
////            },
////            title: Text('Expand items'),
////            trailing: Padding(
////              padding: const EdgeInsets.only(right: 100),
////              child: Icon(_isExpanded
////                  ? Icons.keyboard_arrow_up
////                  : Icons.keyboard_arrow_down),
////            ),
////            children: <Widget>[
////              Padding(
////                padding: const EdgeInsets.only(left: 30, right: 60),
////                child: ExpansionTile(
////                  title: Text('First child'),
////                ),
////              ),
////              Padding(
////                padding: const EdgeInsets.only(left: 30, right: 60),
////                child: ExpansionTile(
////                  title: Text('Second child'),
////                ),
////              ),
////            ],
////          ),
////
////
////          ListTile(
////            leading: Icon(Icons.input),
////            title: Text('Welcome'),
////            onTap: () => {},
////          ),
////          ListTile(
////            leading: Icon(Icons.verified_user),
////            title: Text('Profile'),
////            onTap: () => {Navigator.of(context).pop()},
////          ),
////          ListTile(
////            leading: Icon(Icons.settings),
////            title: Text('Settings'),
////            onTap: () => {Navigator.of(context).pop()},
////          ),
////          ListTile(
////            leading: Icon(Icons.border_color),
////            title: Text('Feedback'),
////            onTap: () => {Navigator.of(context).pop()},
////          ),
////          ListTile(
////            leading: Icon(Icons.exit_to_app),
////            title: Text('Logout'),
////            onTap: () => {Navigator.of(context).pop()},
////          ),
////          ExpansionTile(
////            title: Text(
////              "Title",
////              style: TextStyle(
////                  fontSize: 18.0,
////                  fontWeight: FontWeight.bold
////              ),
////            ),
////            children: <Widget>[
////              ExpansionTile(
////                title: Text(
////                  'Sub title',
////                ),
////                children: <Widget>[
////                  ListTile(
////                    title: Text('data'),
////                  )
////                ],
////              ),
////              ListTile(
////                title: Text(
////                    'data'
////                ),
////              )
////            ],
////          ),
////          ExpansionPanelList(
////            expansionCallback: (int index, bool isExpanded) {},
////            children: [
////              ExpansionPanel(
////                headerBuilder: (BuildContext context, bool isExpanded) {
////                  return ListTile(
////                    title: Text('Item 1'),
////                  );
////                },
////                body: ListTile(
////                  title: Text('Item 1 child'),
////                  subtitle: Text('Details goes here'),
////                ),
//////    isExpanded: true,
////              ),
////              ExpansionPanel(
////                headerBuilder: (BuildContext context, bool isExpanded) {
////                  return ListTile(
////                    title: Text('Item 2'),
////                  );
////                },
////                body: ListTile(
////                  title: Text('Item 2 child'),
////                  subtitle: Text('Details goes here'),
////                ),
////                isExpanded: false,
////              ),
////            ],
////          ),
////          ExpansionTile(
////            title: Text("Expansion Title"),
//////            leading: Icon(Icons.arrow_drop_down),
////            trailing: Icon(Icons.arrow_drop_down),
////            children: <Widget>
////            [
////              Row(
////                children: [
////                  Text("children 1"),
////                  Text("children 1"),
////
////                ],
////              ),
////              Row(
////                children: [
////                  Text("children 1"),
////                  Text("children 1"),
////
////                ],
////              ),
////            ],
////            initiallyExpanded:true,
////          ),
////
////        ],
////      ),
////
////    );
//  }
//
//  Future<bool> _exitApp(BuildContext context) {
//    return showDialog(
//      context: context,
//      child: AlertDialog(
//        title: Text('Are you sure ?'),
//        content: Text('Do you want to Logout ?'),
//        actions: <Widget>[
//          FlatButton(
//            onPressed: () {
//              print("you choose no");
//              Navigator.of(context).pop(false);
//            },
//            child: Text('No',style: TextStyle( fontSize: 17,color: Colors.blue), ),
//          ),
//          FlatButton(
//            onPressed: () async {
////              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//
////              SharedPreferences prefs = await SharedPreferences.getInstance();
////              await prefs.remove(userKey);
//              await Future.delayed(Duration(seconds: 1));
//
//              Navigator.of(context).pushAndRemoveUntil(
//                // the new route
//                  MaterialPageRoute(
//                    builder: (BuildContext context) => LoginScreen(),
//                  ),
//
//                  // this function should return true when we're done removing routes
//                  // but because we want to remove all other screens, we make it
//                  // always return false
//                      (Route<dynamic> route) => false
//              );
//            },
//            child: Text('Yes', style: TextStyle( fontSize: 17,color:Colors.blue)),
//          ),
//        ],
//      ),
//    ) ??
//        false;
//  }
//}