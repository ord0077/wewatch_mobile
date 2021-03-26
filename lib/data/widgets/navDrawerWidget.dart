import 'dart:convert';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wewatchapp/consts.dart';
import 'package:wewatchapp/data/login/loginScreen.dart';
import 'package:wewatchapp/data/models/loginModel.dart';
import 'package:wewatchapp/data/screens/dashboard.dart';
import 'package:wewatchapp/data/screens/guard/covid_19.dart';
import 'package:wewatchapp/data/screens/guard/guard_dashboard.dart';
import 'package:wewatchapp/data/screens/guard/project_site_visitor.dart';
import 'package:wewatchapp/data/screens/user/accident_incident_report.dart';
import 'package:wewatchapp/data/screens/user/daily_hsc_report.dart';
import 'package:wewatchapp/data/screens/user/daily_security_repo.dart';
import 'package:wewatchapp/data/screens/user/observation_form.dart';
import 'package:wewatchapp/data/screens/user/training_induction_form.dart';
import 'package:wewatchapp/data/screens/wewatchManager/wwmanager_dashboard.dart';


class NavDrawer extends StatefulWidget {
  NavDrawer({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _NavDrawer createState() => _NavDrawer();
}

class _NavDrawer extends State<NavDrawer> {
//class NavDrawer extends StatelessWidget {
  bool _isExpanded = false;
  String userType;
  String project_name = "" ?? "";

  Future<SharedPreferences> sharedPreferences() async => await SharedPreferences.getInstance();
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    setState(() {
      userType = (userData.getString('user_type') ?? '');
      project_name =(userData.getString('project_name') ?? '');
    });
  }
  @override
  Widget build(BuildContext context) {

    bool isCustomer = userType == null ? true : (userType == "User");
    print(isCustomer);
    print(userType);


    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          FutureBuilder<SharedPreferences>(
              future: sharedPreferences(),
              builder: (context, snapshot) {

                if (snapshot.hasData){
                  Map userMap = jsonDecode(snapshot.data.getString(userKey));
                  LoginModel userData = LoginModel.fromJson(userMap);

                  return DrawerHeader(
                    padding: EdgeInsets.fromLTRB(16.0, 16.0, 24.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/menu-icon.png',
                          height: 40,
                          width: 40,
                          fit: BoxFit.fitWidth,
                        ),
                        SizedBox(width: 8.0),
                        Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                Text(
                                  userData.user.name?? "Name is null",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                                SizedBox(height: 4.0),

//                                Flexible(
//                                  child: Text(
//                                    userData.user.address?? "address is null",
//                                    style: TextStyle(
//                                      color: Colors.white54,
//                                      fontSize: 12.0,
//                                      fontWeight: FontWeight.w400,
//                                    ),
//                                  ),
//                                ),
                              ],
                            )
                        ),
                        SizedBox(width: 8.0),
                        Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 48.0,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: DarkBlue,
                    ),
                  );
                } else {
                  return DrawerHeader(child: Container(color: DarkBlue),);
                }
              }
          ),

          Flexible(
            child: ListView(
              padding: EdgeInsets.all(0.0),
              children: <Widget>[
                NavigatorListItem(
                  icon: Icons.bubble_chart,
                  title: "Project: "+ project_name,

                ),
                if(userType == 'User')
                NavigatorListItem(
                  icon: Icons.home,
                  title: "Home",
                  onTap: (){
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Dashboard()),
                            (Route<dynamic> route) => false
                    );
                  },
                ),
                if(userType == 'Security Guard')
                  NavigatorListItem(
                    icon: Icons.home,
                    title: "Home",
                    onTap: (){
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => GuardDashboard()),
                              (Route<dynamic> route) => false
                      );
                    },
                  ),
                if(userType == 'Wewatch Manager')
                  NavigatorListItem(
                    icon: Icons.home,
                    title: "Home",
                    onTap: (){
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => wwmanager_Dashboard()),
                              (Route<dynamic> route) => false
                      );
                    },
                  ),
                if (userType == "User"|| userType == "Wewatch Manager" )
                  NavigatorListItem(
                    icon: Icons.local_mall,
                    title: 'Accident /  Incident Form',

                    onTap: (){
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) => AccidentIncidentReport()));
                    },
                  ),


                if (userType == "User" || userType == "Wewatch Manager")
                  NavigatorListItem(
                    icon: Icons.local_mall,
                    title: "Observation Form",
                    onTap: (){
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) => ObservationForm()));                   },
                  ),

                if (userType == "User" || userType == "Wewatch Manager" || userType == 'Security Guard')
                  NavigatorListItem(
                    icon: Icons.work,
                    title: "Training Induction Form",
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) => training_induction_form()));
                    }
                    ),

                if (userType == "Security Guard"|| userType == "Wewatch Manager")
                  NavigatorListItem(
                    icon: Icons.work,
                    title: 'Covid 19 Temp Register',
                    onTap: (){
                               Navigator.push(
                                  context, MaterialPageRoute(
                                builder: (context) => covid_19_reg()));       },
                  ),

                if (userType == "Security Guard" || userType == "Wewatch Manager")
                  NavigatorListItem(
                    icon: Icons.work,
                    title: 'Project Site Visitors Daily Register',
                    onTap: (){
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) => project_site_reg()));                        },
                  ),
                if (userType == "Wewatch Manager")
                  NavigatorListItem(
                    icon: Icons.work,
                    title: 'Daily Security Form',
                    onTap: (){
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) => DailySecurityReport()));                       },
                  ),
                if (userType == "Wewatch Manager")
                  NavigatorListItem(
                    icon: Icons.work,
                    title: 'Daily HSC Form',
                    onTap: (){
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) => DailyHscReport()));                   },
                  ),
                SizedBox(height: 20.0),
                NavigatorListItem(

                  icon: Icons.power_settings_new,
                  title: "Log Out",

                  onTap: () {
                    _exitApp(context);
                  },
                ),


              ],
            ),
          ),


        ],
      ),
    );
  }


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
//
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
//
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
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => training_induction_form()),
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
//
//  }


  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => new  AlertDialog(
        title: Text('Are you sure ?'),
        content: Text('Do you want to Logout ?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              print("you choose no");
              Navigator.of(context).pop(false);
            },
            child: Text('No',style: TextStyle( fontSize: 17,color: Colors.blue), ),
          ),
          FlatButton(
            onPressed: () async {
//              SystemChannels.platform.invokeMethod('SystemNavigator.pop');

              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove(userKey);
              await Future.delayed(Duration(seconds: 1));

              Navigator.of(context).pushAndRemoveUntil(
                // the new route
                  MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen(),
                  ),

                  // this function should return true when we're done removing routes
                  // but because we want to remove all other screens, we make it
                  // always return false
                      (Route<dynamic> route) => false
              );
            },
            child: Text('Yes', style: TextStyle( fontSize: 17,color:Colors.blue)),
          ),
        ],
      ),
    ) ??
        false;
  }
}
class NavigatorListItem extends StatelessWidget {
  const NavigatorListItem({
    Key key, this.title, this.icon, this.onTap,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.white),
          )
      ),
      child: ListTile(
        leading: Icon(
          this.icon,
          color: Colors.white,
        ),
        title: Text(title,style: TextStyle(color: Colors.white,fontSize: 14.0),),
        onTap: () {

          onTap();
          //Navigator.pop(context);
        },
      ),
    );
  }
}