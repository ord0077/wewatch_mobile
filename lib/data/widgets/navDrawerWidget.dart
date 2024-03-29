import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wewatchapp/Connectivity.dart';
import 'package:wewatchapp/consts.dart';
import 'package:wewatchapp/data/login/loginScreen.dart';
import 'package:wewatchapp/data/models/loginModel.dart';
import 'package:wewatchapp/data/models/projectsModel.dart';
import 'package:wewatchapp/data/repositories/projectsRepository.dart';
import 'package:wewatchapp/data/screens/client/client_dashboard.dart';
import 'package:wewatchapp/data/screens/public_user.dart';
import 'package:wewatchapp/data/screens/user/dashboard.dart';
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
  NavDrawer({Key key,}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

//  final String title;

  @override
  _NavDrawer createState() => _NavDrawer();
}

class _NavDrawer extends State<NavDrawer> {
//class NavDrawer extends StatelessWidget {
  bool _isExpanded = false;
  String userType = ""?? "";
  String project_name = "" ?? "" ;
  String location = "" ?? "" ;
  Timer timer;
  MyConnectivity _connectivity = MyConnectivity.instance;

//  WeatherFactory wf = new WeatherFactory("YOUR_API_KEY");
  final ProjectRepository _projectRepo = ProjectRepository();



  Future<SharedPreferences> sharedPreferences() async => await SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _loadCounter();

    // ProjectRepository().GetProjectList();

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
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          FutureBuilder<SharedPreferences>(
              future: sharedPreferences(),
              builder: (context, snapshot) {

                if (snapshot.hasData && snapshot.data!=null){
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
                      color: AppBlue,
                    ),

                  );

                }
                return DrawerHeader(child: Container(color: AppBlue),);
              }
          ),


         // if(userType == 'Security Guard' || userType == 'User')
         //   NavigatorListItem(
         //     icon: Icons.bubble_chart,
         //     title: "Project: "+ project_name ,
         //   ),


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
                  if(userType == 'project Admin')

                    NavigatorListItem(
                      icon: Icons.home,
                      title: "Home",
                      onTap: (){
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => client_Dashboard()),
                                (Route<dynamic> route) => false
                        );
                      },
                    ),
                    if(userType == 'public')

                      NavigatorListItem(
                        icon: Icons.home,
                        title: "Home",
                        onTap: (){
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => public_Dashboard()),
                                  (Route<dynamic> route) => false
                          );
                        },
                      ),




          if(userType == 'Wewatch Manager')
          FutureBuilder<SharedPreferences>(
              future: sharedPreferences(),
              builder: (context, snapshot)  {

                if (snapshot.hasData && snapshot.data!=null) {
                  print(snapshot.data);
                  Map userMap = jsonDecode(snapshot.data.getString(projectKey));
                  Projects projectData = Projects.fromJson(userMap);
                   List<Project> ProjectList =  [];
                  ProjectList = projectData.project;

                  return Expanded(child:ProjectList.isEmpty ? Container(child: Text('Empty')) :
                  ListView.builder(

                    shrinkWrap: true, //just set this property
                    padding: const EdgeInsets.all(8.0),
                    itemCount: ProjectList.length != null ? (ProjectList?.length ?? 0) : 0,
                    itemBuilder: (context, index) {
//                          return Column(
////                            children: [
////                              ListTile(
////                                title: Text(europeanCountries[index].projectName),
////                              )
////                            ],
////
////                          );
                      return   ExpansionTile(

//                           backgroundColor: Colors.white,
                        leading: Icon(Icons.bubble_chart,color: Colors.white,) ,
                        title: Text(ProjectList[index].projectName,style: TextStyle(color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w600,),),
                        children: <Widget>[

                          NavigatorListItem(
                            icon: Icons.filter_frames,
                            title: 'Accident /  Incident Form',

                            onTap: (){
                              Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (context) => AccidentIncidentReport(),settings: RouteSettings( arguments: [ProjectList[index].Id,ProjectList[index].location])));
                            },
                          ),
                          NavigatorListItem(
                            icon: Icons.filter_frames,
                            title: "Observation Form",
                            onTap: (){
                              Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (context) => ObservationForm(),settings: RouteSettings( arguments: [ProjectList[index].Id,ProjectList[index].location])));                   },
                          ),
                          NavigatorListItem(
                              icon: Icons.filter_frames,
                              title: "Training Induction Form",
                              onTap: () {
                                Navigator.push(
                                    context, MaterialPageRoute(
                                    builder: (context) => training_induction_form(),settings: RouteSettings( arguments: ProjectList[index].Id)));
                              }
                          ),
                          NavigatorListItem(
                            icon: Icons.filter_frames,
                            title: 'Covid-19 Register',
                            onTap: (){
                              Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (context) => covid_19_reg(),settings: RouteSettings( arguments: ProjectList[index].Id)));       },
                          ),
                          NavigatorListItem(
                            icon: Icons.filter_frames,
                            title: 'Daily Site Visitor Form',
                            onTap: (){
                              Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (context) => project_site_reg(),settings: RouteSettings( arguments: ProjectList[index].Id)));                        },
                          ),
                          // NavigatorListItem(
                          //   icon: Icons.filter_frames,
                          //   title: 'Daily Security Form',
                          //   onTap: (){
                          //     Navigator.push(
                          //         context, MaterialPageRoute(
                          //         builder: (context) => DailySecurityReport(),settings: RouteSettings( arguments: ProjectList[index].projectId)));                       },
                          // ),
                          // NavigatorListItem(
                          //   icon: Icons.filter_frames,
                          //   title: 'Daily HSE Form',
                          //   onTap: (){
                          //     Navigator.push(
                          //         context, MaterialPageRoute(
                          //         builder: (context) => DailyHscReport(),settings: RouteSettings( arguments: ProjectList[index].projectId)));                   },
                          // ),

                        ],
                      );


                    },
                  )
                  );

                }
                else if (snapshot.hasError || snapshot.data ==null ) {
                  return Container(
                      height: 100.0,
                      child: ListView(
                        children: [
                          ListTile(
                            title: Text("Empty"),
                          )
                        ],
                      )
                  );
                }
                else {
                  return Container(
                      height: 100.0,
                      child: ListView(
                        children: [
                          ListTile(
                            title: Text("Empty"),
                          )
                        ],
                      )
                  );
                }

              }

          ),

          if (userType == "User" )
            FutureBuilder<SharedPreferences>(
                future: sharedPreferences(),
                builder: (context, snapshot) {

                  if (snapshot.hasData && snapshot.data!=null){
                    Map userMap = jsonDecode(snapshot.data.getString(projectKey));
                    Projects projectData = Projects.fromJson(userMap);
                    final List<Project> ProjectList = projectData.project;

                    return Expanded(child: ListView.builder(
                      shrinkWrap: true, //just set this property
                      padding: const EdgeInsets.all(8.0),
                      itemCount: ProjectList.length,
                      itemBuilder: (context, index) {
//
                        return   ExpansionTile(
//                           backgroundColor: Colors.white,
                          leading: Icon(Icons.bubble_chart,color: Colors.white,) ,
                          title: Text(ProjectList[index].projectName,style: TextStyle(color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w600,),),
                          children: <Widget>[

                            NavigatorListItem(
                              icon: Icons.filter_frames,
                              title: 'Accident / Incident Form',

                              onTap: (){
                                Navigator.push(
                                    context, MaterialPageRoute(
                                    builder: (context) => AccidentIncidentReport(),settings: RouteSettings( arguments: [ProjectList[index].Id,ProjectList[index].location])));
                              },
                            ),
                            NavigatorListItem(
                              icon: Icons.filter_frames,
                              title: "Observation Form",
                              onTap: (){
                                Navigator.push(
                                    context, MaterialPageRoute(
                                    builder: (context) => ObservationForm(),settings: RouteSettings( arguments: [ProjectList[index].Id,ProjectList[index].location])));                   },
                            ),
                            NavigatorListItem(
                                icon: Icons.filter_frames,
                                title: "Training Induction Form",
                                onTap: () {
                                  Navigator.push(
                                      context, MaterialPageRoute(
                                      builder: (context) => training_induction_form(),settings: RouteSettings( arguments: ProjectList[index].Id)));
                                }
                            ),

                          ],
                        );


                      },
                    ));

                  }
                  return Container(
                      height: 100.0,
                      child:ListView(
                        children: [
                          ListTile(
                            title: Text("Empty"),
                          )
                        ],
                      )
                  );
                }
            ),
          if(userType == 'Security Guard')
            FutureBuilder<SharedPreferences>(
                future: sharedPreferences(),
                builder: (context, snapshot) {

                  if (snapshot.hasData && snapshot.data!=null){
                    Map userMap = jsonDecode(snapshot.data.getString(projectKey));
                    Projects projectData = Projects.fromJson(userMap);
                    final List<Project> ProjectList = projectData.project;

                    return  Expanded(child: ProjectList.isEmpty ? Container(child: Text('Empty')) : ListView.builder(
                      shrinkWrap: true, //just set this property
                      padding: const EdgeInsets.all(8.0),
                      itemCount: ProjectList.length,
                      itemBuilder: (context, index) {
//                          return Column(
////                            children: [
////                              ListTile(
////                                title: Text(europeanCountries[index].projectName),
////                              )
////                            ],
////
////                          );
                        return   ExpansionTile(
//                           backgroundColor: Colors.white,
                          leading: Icon(Icons.bubble_chart,color: Colors.white,) ,
                          title: Text(ProjectList[index].projectName,style: TextStyle(color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w600,),),
                          children: <Widget>[
                            NavigatorListItem(
                              icon: Icons.filter_frames,
                              title: "Observation Form",
                              onTap: (){
                                Navigator.push(
                                    context, MaterialPageRoute(
                                    builder: (context) => ObservationForm(),settings: RouteSettings( arguments: [ProjectList[index].Id,ProjectList[index].location])));                   },
                            ),

                            NavigatorListItem(
                              icon: Icons.filter_frames,
                              title: 'Covid-19 Register',
                              onTap: (){
                                Navigator.push(
                                    context, MaterialPageRoute(
                                    builder: (context) => covid_19_reg(),settings: RouteSettings( arguments: ProjectList[index].Id)));       },
                            ),
                            NavigatorListItem(
                              icon: Icons.filter_frames,
                              title: 'Daily Site Visitor Form',
                              onTap: (){
                                Navigator.push(
                                    context, MaterialPageRoute(
                                    builder: (context) => project_site_reg(),settings: RouteSettings( arguments: ProjectList[index].Id)));                        },
                            ),


                          ],
                        );


                      },
                    ));

                  }
                  return Container(
                      height: 100.0,
                      child:ListView(
                        children: [
                          ListTile(
                            title: Text("Empty"),
                          )
                        ],
                      )
                  );
                }
            ),



            Align(
            alignment: FractionalOffset.bottomCenter,
              child: NavigatorListItem(
//
                icon: Icons.logout,
                title: "Log Out",

                onTap: () {
                  _exitApp(context);
                },
              ),
            )




        ],
      ),
    );
  }




  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => new  AlertDialog(
        title: Text('Are you sure ?'),
        content: Text('Do you want to Logout ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              print("you choose no");
              Navigator.of(context).pop(false);
            },
            child: Text('No',style: TextStyle( fontSize: 17,color: Colors.blue), ),
          ),
          TextButton(
            onPressed: () async {
//              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//            _connectivity.PauseStream();
              SharedPreferences prefs = await SharedPreferences.getInstance();
              SharedPreferences userData = await SharedPreferences.getInstance();
              SharedPreferences projectData = await SharedPreferences.getInstance();
              await prefs.remove(userKey);
              await userData.remove(userKey);
              await projectData.clear();

              await Future.delayed(Duration(seconds: 1));
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                // the new route
                  MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen(),
                  ),

                  // this function should return true when we're done removing routes
                  // but because we want to remove all other screens, we make it
                  // always return false
                  //     (Route<dynamic> route) => false
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


