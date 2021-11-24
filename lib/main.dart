
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wewatchapp/consts.dart';
import 'package:wewatchapp/data/login/loginScreen.dart';
import 'package:wewatchapp/data/models/loginModel.dart';
import 'package:wewatchapp/data/screens/client/client_dashboard.dart';
import 'package:wewatchapp/data/screens/public_user.dart';
import 'package:wewatchapp/data/screens/user/dashboard.dart';
import 'package:wewatchapp/data/screens/guard/guard_dashboard.dart';
import 'package:wewatchapp/data/screens/user/accident_incident_report.dart';
import 'package:wewatchapp/data/screens/wewtachWebView.dart';
import 'data/screens/wewatchManager/wwmanager_dashboard.dart';


Future<void> main() async {

//  WidgetsFlutterBinding.ensureInitialized();
FlutterError.onError = (FlutterErrorDetails details) {
FlutterError.dumpErrorToConsole(details);
if (kReleaseMode)
exit(1);
};

// WidgetsFlutterBinding.ensureInitialized();
// await FlutterDownloader.initialize(
//     debug: true // optional: set false to disable printing logs to console
// );
runApp(new MyApp());
}

class MyApp extends StatelessWidget {

Future<SharedPreferences> sharedPreferences() async => await SharedPreferences.getInstance();

bool isLogged = false;
String route = '/login';
// String route = '/project_Admin';

@override
Widget build(BuildContext context) {


// FlutterStatusbarcolor.setStatusBarColor(Colors.grey);
//      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//   statusBarColor: Colors.grey, //or set color with: Color(0xFF0000FF)
// ));
SystemChrome.setPreferredOrientations([
DeviceOrientation.portraitUp,
DeviceOrientation.portraitDown,
]);

return new AnnotatedRegion<SystemUiOverlayStyle>(
value: const SystemUiOverlayStyle(
// For Android.
// Use [light] for white status bar and [dark] for black status bar.
statusBarIconBrightness: Brightness.light,
// For iOS.
// Use [dark] for white status bar and [light] for black status bar.
statusBarBrightness: Brightness.dark,
),
child: FutureBuilder<SharedPreferences>  (
future: sharedPreferences(),
builder: (context, snapshot) {
if (  snapshot.hasData && snapshot !=null) {

isLogged = snapshot.data.containsKey(userKey);
print(userKey);

if (isLogged ) {
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

case "project Admin":
route = '/project_Admin';
break;

  case "public":
    route = '/public';
    break;

default:
route = '/login';
// route = '/project_Admin';
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
borderSide: BorderSide(
color: Colors.black, style: BorderStyle.solid),
),
),
),
scaffoldBackgroundColor: const Color(0xFFF9F8F4),

textTheme: TextTheme(
// headline: TextStyle(
//   fontSize: 24.0,
//   fontWeight: FontWeight.bold,
// ),
),
),

routes: <String, WidgetBuilder>{
'/login': (BuildContext context) => new LoginScreen(),
'/User': (BuildContext context) => new Dashboard(),
'/guard': (BuildContext context) => new GuardDashboard(),
'/wewatch_manager': (BuildContext context) => new wwmanager_Dashboard(),
'/project_Admin': (BuildContext context) => new client_Dashboard(),
  '/public': (BuildContext context) => new public_Dashboard(),
// '/client': (BuildContext context) => new client_Dashboard(),


//                '/customer' : (BuildContext context) => new AddUser(),

},


initialRoute: route,
// initialRoute: isLogged? '/customer' : '/login',
// home: LoginScreen(),
)
;

}
else {
return Container(height: 0,width: 0,);

//                MaterialApp(
//                debugShowCheckedModeBanner: false,
//                theme: ThemeData(
//                  primaryColorLight: Colors.black,
//                  accentColor: Color(0xFFF9F8F4),
//                  buttonColor: Color(0xFF333333),
//                  backgroundColor: Color(0xFFF9F8F4),
//                ),
//
//                builder: (_, __) {
//                  return Scaffold(
//                    body: Container(
//                      color: Color(0xFFCCCCCC),
//                      child: Center(
//                        child: Text(
//                          'WELCOME BACK',
//                          style: TextStyle(
//                            fontSize: 32.0,
//                            color: Colors.black,
//                          ),
//                        ),
//                      ),
//                    ),
//                  );
//                },
//              );
}
}
),
);


//    WidgetsBinding.instance.addPostFrameCallback((_) async {


//    }
//    );
}
}