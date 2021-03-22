import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wewatchapp/consts.dart';
import 'package:wewatchapp/data/login/loginScreen.dart';
import 'package:wewatchapp/data/models/loginModel.dart';
import 'package:wewatchapp/data/screens/dashboard.dart';
import 'package:wewatchapp/data/screens/guard/guard_dashboard.dart';
import 'package:wewatchapp/data/screens/superAdmin/add_user.dart';
import 'package:wewatchapp/data/screens/superAdmin/user_list.dart';
import 'package:wewatchapp/data/screens/user/accident_incident_report.dart';
import 'data/screens/wewatchManager/wwmanager_dashboard.dart';


main() async {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  Future<SharedPreferences> sharedPreferences() async => await SharedPreferences.getInstance();
  bool isLogged = false;
  String route = '/login';

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return new FutureBuilder<SharedPreferences>(
        future: sharedPreferences(),
        builder: (context, snapshot) {

          if (snapshot.hasData){

            isLogged = snapshot.data.containsKey(userKey);

            if (isLogged){
              Map userMap = jsonDecode(snapshot.data.getString(userKey));
              LoginModel userData = LoginModel.fromJson(userMap);

              switch (userData.user.userType) {
                case "User":
                  route = '/User';
                  break;

                case "Security Guard":
                  route = '/guard';
                  break;
//
                case "Wewatch Manager":
                  route = '/wewatch_manager';
                  break;
//
//                case "maintenance":
//                  route = '/maintenance';
//                  break;

                default:
//                  route = '/login';
                  route = '/login';



              }
            }

            return MaterialApp(

              title: 'WeWatch',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColorLight: Colors.black,
                accentColor: Color(0xFFF9F8F4),
                buttonColor: Color(0xFF333333),
                backgroundColor: Color(0xFFF9F8F4),
                // appBarTheme: ,

                iconTheme: IconThemeData(
                  color: Colors.black,
                ),

                tabBarTheme: TabBarTheme(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black26,
                  labelPadding: EdgeInsets.only(top: 32.0),
                  indicator: ShapeDecoration(
                    shape: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, style: BorderStyle.solid),
                    ),
                  ),
                ),
                scaffoldBackgroundColor: Color(0xFFF9F8F4),

                textTheme: TextTheme(
                  headline: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              routes: <String, WidgetBuilder>{
                '/login'  : (BuildContext context) => new LoginScreen(),
                '/User' : (BuildContext context) => new Dashboard(),
                '/guard' : (BuildContext context) => new GuardDashboard(),
                '/wewatch_manager' : (BuildContext context) => new wwmanager_Dashboard(),


//                '/customer' : (BuildContext context) => new AddUser(),

//                '/customer/order_history' : (BuildContext context) => new OrderHistory(),
//                '/customer/maintainance_history' : (BuildContext context) => new MaintainanceHistoryScreen(),
//                '/coldstorage' : (BuildContext context) => new AssignedOrderScreen(),
//                '/coldstorage/order_history' : (BuildContext context) => new ColdStorageHistoryScreen(),
//                '/driver' : (BuildContext context) => new DriverScreen(),
//                '/driver/order_history' : (BuildContext context) => new DriverHistoryScreen(),
//                '/maintenance' : (BuildContext context) => new MaintainaceScreen(),
//                '/maintenance/history' : (BuildContext context) => new MaintenanceManHistory(),
              },

              initialRoute: route,
              // initialRoute: isLogged? '/customer' : '/login',
              // home: LoginScreen(),
            );
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColorLight: Colors.black,
                accentColor: Color(0xFFF9F8F4),
                buttonColor: Color(0xFF333333),
                backgroundColor: Color(0xFFF9F8F4),
              ),

              builder: (_,__){
                return Scaffold(
                  body: Container(
                    color: Color(0xFFCCCCCC),
                    child: Center(
                      child: Text(
                        'WELCOME BACK',
                        style: TextStyle(
                          fontSize: 32.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }
    );
  }
}