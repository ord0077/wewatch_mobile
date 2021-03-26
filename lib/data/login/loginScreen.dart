import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wewatchapp/consts.dart';
import 'package:wewatchapp/data/models/loginModel.dart';
import 'package:wewatchapp/data/repositories/loginRepository.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final LoginRepository _login = LoginRepository();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isSelected = false;

  bool loginIsTapped = false;

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var shortestside = MediaQuery.of(context).size.shortestSide;
    var useMobileLayout = shortestside <600;
    if(useMobileLayout)
    {
      print("running mobile app");
      return _buildMobileLayout(context);
    }
    print("running tablet app");

    return  _buildtabletLayout(context);
  }
  @override
  Widget _buildtabletLayout(BuildContext context){
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Builder(
            builder: (context) {
              return  Stack(
                children: <Widget>[

//              Container(
//                width: MediaQuery.of(context).size.width,
//                height: MediaQuery.of(context).size.height,
//                child: Image.asset(
//                  'assets/images/cover-image.png',
//                  fit: BoxFit.cover,
//                ),
//              ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
//                  child: Image.asset(
//                    'assets/images/login_top.png',
//                    fit: BoxFit.cover,
//                  ),
                    ),
                  ),

                  Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.6,
                      child: SingleChildScrollView(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              // Logo image of login screen
                              Container(
                                width: 400,
                                height: 200,
                                child: Image.asset(
                                    "assets/images/wewatch_logo.png"
                                ),
                              ),


                              SizedBox(height: 60.0,),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Proceed with your',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w400) ),
                              ),
                              SizedBox(height: 16.0,),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Login',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold)),
                              ),

                              SizedBox(height: 20.0,),

                              // Input textfields for email
                              InputBox(
                                hint: "Email",
                                icon: Icons.person_outline,
                                isPassword: false,
                                textController: emailController,
                              ),

                              SizedBox(height: 20.0,),


                              // Input textfields for password
                              InputBox(
                                hint: "Password",
                                icon: Icons.lock_outline,
                                isPassword: true,
                                textController: passwordController,
                              ),

                              // Forgot password

//                              SizedBox(height: 10.0,),
//                            Align(
//                              alignment: Alignment.centerRight,
//                              child: Container(
//                                  width: 200.0,
////                                  color: Colors.blue,
//                                    child:
                                    CheckboxListTile(
                                      checkColor: Colors.white,
                                      activeColor: DarkBlue,
                                      contentPadding: EdgeInsets.all(0),

                                      title: Text("Remember me",style: TextStyle(color: DarkBlue )),
                                      value: _isSelected,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _isSelected = newValue;
                                        });

                                      },

                                      controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                                    ),
//                                  )
//
//                              ),




                              SizedBox(height: 10.0,),

                              // Button
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.all(12.0),
                                  color: Color.fromRGBO(30, 75, 156, 1),
                                  child: Center(
                                    child: loginIsTapped? Center(
                                        child: SizedBox(
                                          width: 20.0,
                                          height: 20.0,
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.white,
                                            valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
                                            strokeWidth: 3.0,
                                          ),
                                        )
                                    ):Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                ),

                                onTap: () async {

                                  if (emailController.text == "" || passwordController.text == ""){
                                    _showToast(context, 'One or more feild(s) are empty');
                                  } else{

                                    setState(() {
                                      loginIsTapped = loginIsTapped? false:true;
                                    });

                                    // String _email = "customer2@ord.com";
                                    // String _password = "secret";
                                    String _email = emailController.text;
                                    String _password = passwordController.text;



                                    Future<LoginModel> loginResponse = _login.login(_email, _password);

                                    loginResponse.then((loginModel) async {

                                      SharedPreferences userData = await SharedPreferences.getInstance();
                                      String userJSON = jsonEncode(loginModel);
                                      userData.setString('token', loginModel.token.toString() ?? '');

                                      userData.setInt('user_id', loginModel.user.id?? '');
                                      userData.setString('user_type', loginModel.user.userType?? '' );
                                      userData.setInt('project_id', loginModel.project.first.projectId?? '');
                                      userData.setString('project_name', loginModel.project.first.projectName?? '');


                                      userData.setString(userKey, userJSON);
                                      var tokenn = userData.getString('token');
                                      print(tokenn);
                                      userData.remove(userKey);
                                      userData.setString(userKey, userJSON);

                                      print(loginModel.user.userType.toLowerCase());
//                                      loginModel.user.userType = "User";
                                      switch (loginModel.user.userType) {
                                        case "User":
                                          Navigator.pushReplacementNamed(
                                            context,
                                            '/User',
                                          );
                                          break;

                                        case "Security Guard":
                                          Navigator.pushReplacementNamed(
                                            context,
                                            '/guard',
                                          );
                                          break;

                                        case "Wewatch Manager":
                                          Navigator.pushReplacementNamed(
                                            context,
                                            '/wewatch_manager',
                                          );
                                          break;

                                        default:
                                          _showToast(context, 'Some error occurred please try again later');
                                      }
                                    }).catchError((error){
                                      _showToast(context, error);

                                    }).whenComplete((){
                                      setState(() {
                                        loginIsTapped = false;

                                      });
                                    });

                                  }
                                },

                              ),
                              SizedBox(height: 60.0,),

//                              GestureDetector(
//                                child: Align(
//                                  alignment: Alignment.center,
//                                  child: Text(
//                                    "Forgot Password ?",
//                                    style: TextStyle(
//                                        color: Colors.black87,fontSize: 18.0
//                                    ),
//                                  ),
//                                ),
//                                onTap: (){
////                               Navigator.push(
////                                 context,
////                                 MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
////                               );
//                                },
//                              ),
                            ],

                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
        )
    );
  }

  @override
  Widget _buildMobileLayout(BuildContext context){
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Builder(
            builder: (context) {
              return  Stack(
                children: <Widget>[

//              Container(
//                width: MediaQuery.of(context).size.width,
//                height: MediaQuery.of(context).size.height,
//                child: Image.asset(
//                  'assets/images/cover-image.png',
//                  fit: BoxFit.cover,
//                ),
//              ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
//                  child: Image.asset(
//                    'assets/images/login_top.png',
//                    fit: BoxFit.cover,
//                  ),
                    ),
                  ),

                  Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.6,
                      child: SingleChildScrollView(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              // Logo image of login screen
                              Container(
                                width: 400,
                                height: 200,
                                child: Image.asset(
                                    "assets/images/wewatch_logo.png"
                                ),
                              ),


                              SizedBox(height: 60.0,),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Proceed with your',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w400) ),
                              ),
                              SizedBox(height: 16.0,),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Login',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold)),
                              ),

                              SizedBox(height: 20.0,),

                              // Input textfields for email
                              InputBox(
                                hint: "Email",
                                icon: Icons.person_outline,
                                isPassword: false,
                                textController: emailController,
                              ),

                              SizedBox(height: 20.0,),


                              // Input textfields for password
                              InputBox(
                                hint: "Password",
                                icon: Icons.lock_outline,
                                isPassword: true,
                                textController: passwordController,
                              ),

                              // Forgot password

//                              SizedBox(height: 10.0,),
//                            Align(
//                              alignment: Alignment.centerRight,
//                              child: Container(
//                                  width: 200.0,
////                                  color: Colors.blue,
//                                    child:
                              CheckboxListTile(
                                checkColor: Colors.white,
                                activeColor: DarkBlue,
                                contentPadding: EdgeInsets.all(0),

                                title: Text("Remember me",style: TextStyle(color: DarkBlue )),
                                value: _isSelected,
                                onChanged: (newValue) {
                                  setState(() {
                                    _isSelected = newValue;
                                  });

                                },

                                controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                              ),
//                                  )
//
//                              ),




                              SizedBox(height: 10.0,),

                              // Button
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.all(12.0),
                                  color: Color.fromRGBO(30, 75, 156, 1),
                                  child: Center(
                                    child: loginIsTapped? Center(
                                        child: SizedBox(
                                          width: 20.0,
                                          height: 20.0,
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.white,
                                            valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
                                            strokeWidth: 3.0,
                                          ),
                                        )
                                    ):Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,fontSize: 16.0
                                      ),
                                    ),
                                  ),
                                ),

                                onTap: () async {

                                  if (emailController.text == "" || passwordController.text == ""){
                                    _showToast(context, 'One or more feild(s) are empty');
                                  } else{

                                    setState(() {
                                      loginIsTapped = loginIsTapped? false:true;
                                    });

                                    // String _email = "customer2@ord.com";
                                    // String _password = "secret";
                                    String _email = emailController.text;
                                    String _password = passwordController.text;



                                    Future<LoginModel> loginResponse = _login.login(_email, _password);

                                    loginResponse.then((loginModel) async {

                                      SharedPreferences userData = await SharedPreferences.getInstance();
                                      String userJSON = jsonEncode(loginModel);
                                      userData.setString('token', loginModel.token.toString() ?? '');

                                      userData.setInt('user_id', loginModel.user.id?? '');
                                      userData.setString('user_type', loginModel.user.userType?? '' );
                                      userData.setInt('project_id', loginModel.project.first.projectId?? '');
                                      userData.setString('project_name', loginModel.project.first.projectName?? '');


                                      userData.setString(userKey, userJSON);
                                      var tokenn = userData.getString('token');
                                      print(tokenn);
                                      userData.remove(userKey);
                                      userData.setString(userKey, userJSON);

                                      print(loginModel.user.userType.toLowerCase());
//                                      loginModel.user.userType = "User";
                                      switch (loginModel.user.userType) {
                                        case "User":
                                          Navigator.pushReplacementNamed(
                                            context,
                                            '/User',
                                          );
                                          break;

                                        case "Security Guard":
                                          Navigator.pushReplacementNamed(
                                            context,
                                            '/guard',
                                          );
                                          break;

                                        case "Wewatch Manager":
                                          Navigator.pushReplacementNamed(
                                            context,
                                            '/wewatch_manager',
                                          );
                                          break;

                                        default:
                                          _showToast(context, 'Some error occurred please try again later');
                                      }
                                    }).catchError((error){
                                      _showToast(context, error);

                                    }).whenComplete((){
                                      setState(() {
                                        loginIsTapped = false;

                                      });
                                    });

                                  }
                                },

                              ),
                              SizedBox(height: 60.0,),

//                              GestureDetector(
//                                child: Align(
//                                  alignment: Alignment.center,
//                                  child: Text(
//                                    "Forgot Password ?",
//                                    style: TextStyle(
//                                        color: Colors.black87,fontSize: 18.0
//                                    ),
//                                  ),
//                                ),
//                                onTap: (){
////                               Navigator.push(
////                                 context,
////                                 MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
////                               );
//                                },
//                              ),
                            ],

                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
        )
    );
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      ),
    );
  }
}

class InputBox extends StatelessWidget {
  const InputBox({
    Key key,
    @required this.textController, this.hint, this.icon, this.isPassword,
  }) : super(key: key);

  final TextEditingController textController;
  final String hint;
  final IconData icon;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              icon,
            ),
          ),

          Flexible(
            child: TextField(
              enableInteractiveSelection: false,
              autofocus: false,
              autocorrect: false,
              obscureText: isPassword,
              controller: textController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
              ),
            ),
          ),
        ],
      ),
    );
  }
}