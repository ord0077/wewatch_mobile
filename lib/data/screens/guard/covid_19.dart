import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wewatchapp/CustomAppBar.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:wewatchapp/DbControllers/Covid19Controller.dart';
import 'package:wewatchapp/consts.dart';
import 'package:wewatchapp/data/models/covid19Model.dart';
import 'package:wewatchapp/data/screens/dashboard.dart';
import 'package:wewatchapp/data/screens/guard/guard_Drawer.dart';
import 'package:wewatchapp/data/screens/guard/guard_dashboard.dart';
import 'package:wewatchapp/data/screens/wewatchManager/wwmanager_dashboard.dart';
import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as Io;







class covid_19_reg  extends StatefulWidget {

  const covid_19_reg ({Key key}) : super(key: key);


  @override
  _covid_19_reg createState() => _covid_19_reg();
}

class _covid_19_reg  extends State<covid_19_reg > {

  final _formKey = GlobalKey<FormState>();
  String file ;
  final picker = ImagePicker();
  bool isPressed = false;
  String imgString;


  final scaffoldKey = GlobalKey<ScaffoldState>();
  int tempVal = 1;

  final nameController = TextEditingController();
  final company_nameController = TextEditingController();
  final remarksController = TextEditingController();
  final AddCovid = CovidModel();
  String userType = ""?? "";
  int u_id;
  int p_id;



  _User() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    setState(() {
      userType = (userData.getString('user_type') ?? '');
      u_id = userData.getInt('user_id');
      p_id = ModalRoute.of(context).settings.arguments;
    });
  }

  List list;
  bool loading = true;

  Future userList()async{
    list = await Covid19Controller().fetchData();
    setState(() {loading=false;});
    //print(list);
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      tempVal = value;


    });
  }











  @override
  void initState() {
    userList();
    setState(() {
      _User();
      isPressed = false;
      picker == null ?? "no image";

    });
    super.initState();
  }

  @override
  void dispose() {
    picker;
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope (
        onWillPop: ()  {
          return NavigateToDashboard();
        },
        child:
        SafeArea(
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
                  preferredSize: const Size.fromHeight(150.0),
                  child:Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 20.0,bottom: 20.0),
                        // color: Theme.of(context).primaryColorLight,
                        color: lightBackgroundColor,
                        child:   Stack(
                          children: <Widget>[
                            new Center(
                                child: new Column(
                                  children: <Widget>[
                                    Container(
//                        padding: EdgeInsets.only(top: 16.0),
                                      width: 200,
                                      child:Image(image: AssetImage('assets/images/wewatch_logo.png',)),

                                    )
                                  ],
                                )),
                            Positioned(
                              left: 10,
//                top: 16,
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
                      Container(
                          width: MediaQuery.of(context).size.width ,
                          padding: const EdgeInsets.only(left: 20.0,top: 20.0,right: 20.0,bottom: 15.0,),
//                  color: Colors.black54,
                          color: Color.fromRGBO(45, 87, 163, 1),




                          child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text('Covid-19 Register',
                                      style: TextStyle( fontSize: 25,fontWeight:FontWeight.bold,color: Colors.white),),
                                  )

                              )


                          )
                      ),
                    ],
                  )

              ),
              body: new GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: new
                  Center (
                      child:    Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width ,
//          color: Color.fromRGBO(246,246,246, 1),
                          padding: EdgeInsets.all(20.0),
//        color:Colors.green,
                          child:Column(
                              children: [

                                Expanded(
                                    child: Scrollbar(
                                        child: SingleChildScrollView(
                                            child: Form(
                                              key: _formKey,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
//                  color: Colors.blue,
                                                    alignment: Alignment.topLeft,
                                                    child:  Align(
//                          alignment: Alignment.topRight,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("Body Temperature is ",style: new TextStyle(fontSize: 20.0,fontWeight:FontWeight.w500,color: Colors.grey) ),
                                                          new Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                new Radio(
                                                                  value: 1,
                                                                  groupValue: tempVal,
                                                                  onChanged: _handleRadioValueChange,
                                                                  activeColor: Colors.blue,
                                                                ),
                                                                new Text(
                                                                  '37.6 +',
                                                                  style: new  TextStyle(fontSize: 16.0,fontWeight:FontWeight.w500,color: Colors.grey),
                                                                ),

                                                              ]
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(height: 10.0,),

                                                  TextFormField(

                                                    decoration: new InputDecoration(

//                              border: InputBorder.none,
//                              focusedBorder: InputBorder.none,
//                              enabledBorder: InputBorder.none,
//                              errorBorder: InputBorder.none,
//                              disabledBorder: InputBorder.none,
                                                        contentPadding:
                                                        EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
//                    hintText: "Name / Staff ID*",
                                                        labelText:"Name / Staff ID*",
                                                        labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w500,color: Colors.grey)
                                                    ),
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Please enter some text';
                                                      }
                                                      return null;
                                                    },
//                                  onSaved: (val) {
//                                    AddCovid.staffName = val;
//                                    print( AddCovid.staffName);
//                                  },
                                                    controller: nameController,
                                                  ),
                                                  SizedBox(height: 15.0,),

                                                  TextFormField(
                                                    decoration: new InputDecoration(
//                              border: InputBorder.none,
//                              focusedBorder: InputBorder.none,
//                              enabledBorder: InputBorder.none,
//                              errorBorder: InputBorder.none,
//                              disabledBorder: InputBorder.none,
                                                        contentPadding:
                                                        EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
//                    hintText: "Name / Staff ID*",
                                                        labelText:"Company Name*" ,
                                                        labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w500,color: Colors.grey)

                                                    ),
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Please enter some text';
                                                      }
                                                      return null;
                                                    },
//                                  onSaved: (val) {
//                                    AddCovid.company = val;
//                                    print( AddCovid.company);
//                                  },
                                                    controller: company_nameController,
                                                  ),
                                                  SizedBox(height: 15.0,),

                                                  TextFormField(
                                                    decoration: new InputDecoration(
//                              border: InputBorder.none,
//                              focusedBorder: InputBorder.none,
//                              enabledBorder: InputBorder.none,
//                              errorBorder: InputBorder.none,
//                              disabledBorder: InputBorder.none,
                                                        contentPadding:
                                                        EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
//                    hintText: "Name / Staff ID*",
                                                        labelText:"Remarks" ,
                                                        labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w500,color: Colors.grey)

                                                    ),
//                                          validator: (value) {
//                                            if (value.isEmpty) {
//                                              return 'Please enter some text';
//                                            }
//                                            return null;
//                                          },
//                                  onSaved: (val) {
//                                    AddCovid.remarks = val;
//                                    print( AddCovid.remarks);
//                                  },
                                                    controller: remarksController,
                                                  ),
                                                  SizedBox(height: 30.0,),
                                                  new  Container(
                                                    margin: EdgeInsets.only(left:8.0,),

                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,

                                                      children: <Widget>[
                                                        Container(

                                                          child: file ==null
                                                              ? new Text("Add attachment",style: TextStyle(fontSize: 20.0,color: DarkBlue,),)
                                                              : new Text("Attachment added",style: TextStyle(fontSize: 20.0,color: Colors.green,)),

                                                        ),
                                                        new IconButton(
                                                            icon: new Icon(Icons.camera_alt, color:(isPressed) ? Colors.red
                                                                : DarkBlue),
//                                                highlightColor: Colors.deepOrangeAccent,

                                                            iconSize: 50.0,
                                                            onPressed:(){
                                                              FocusScope.of(context).requestFocus(FocusNode());
                                                              getImageCamera();
                                                            }
                                                        ),
//                                              Container(
//
//                                                  child:  Row(
//
//                                                    children: <Widget>[
//
//                                                      ElevatedButton(
//                                                        style: ElevatedButton.styleFrom(
//                                                          primary: Color.fromRGBO(45, 87, 163, 1),
////                            onPrimary: Color.fromRGBO(32, 87, 163, 1),
//
//
//                                                        ),
//
//                                                        child: Icon(Icons.camera_alt,color: Colors.blue,),
//                                                        onPressed: getImageCamera,
//                                                      ),
////                                              RaisedButton(
////                                                child: Text("UPLOAD video"),
////                                                onPressed:(){
//////                                                  uploadVideo(_video);
////                                                },
////                                              ),
//
//                                                    ],
//                                                  )
//                                              ),

                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 20.0,),





                                                ],
                                              ),
                                            )
                                        )



                                    )
                                ),
//                      Padding(
//                          padding: const EdgeInsets.symmetric(vertical: 10.0),
//                          child:
                                Align(
                                  child: SizedBox(
//                              width: 600,
                                    child: ElevatedButton(

                                        style: ElevatedButton.styleFrom(
                                          primary: Color.fromRGBO(45, 87, 163, 1),
//                            onPrimary: Color.fromRGBO(32, 87, 163, 1),


                                        ),
                                        onPressed: () {
//                                   Validate returns true if the form is valid, or false
//                                   otherwise.
                                          if (_formKey.currentState.validate() && file != null) {

                                            showLoaderDialog(context);
                                            _Submit();
                                          }
                                          else if (file == null ){

                                            setState(()
                                            {
                                              isPressed= true;
                                            });
                                          }
                                        },
                                        child: Container(
//                                    height: MediaQuery.of(context).size.height,
                                          width: MediaQuery.of(context).size.width ,
//                                    width: 600.0,

                                          child:Text('Submit',textAlign: TextAlign.center,style: TextStyle(fontSize: 20.0)
                                          ),
                                        )
                                    ),
                                  ),
                                )
//                      )
                              ]
                          )
                      )
                  )
              ),
            )
        )

    );
  }

  Future <void> AddToSqllite() async {
    _onLoading();
//    p_id = ModalRoute.of(context).settings.arguments;

    CovidModel covidModel = CovidModel( id: null, projectId: p_id, userId: u_id, temperature: "Have temperature" ,staffName: nameController.text,
      company:company_nameController.text ,remarks: remarksController.text ,image: imgString,);
    await Covid19Controller().addData(covidModel).then((value){
      if (value>0) {
        print("Success");
        userList();
        print(list.length);
      }else{
        print("faild");
      }

    });
  }

  Future<void> _Submit() async {
    final FormState form = _formKey.currentState;
    form.save();
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        _submitForm();
      }
    } on SocketException catch (_) {
      print('not connected');

      AddToSqllite();
    }

  }

  Future<void> _submitForm() async {
    final FormState form = _formKey.currentState;

//    if (form.validate()) {
//      String a= _fbKey.currentState.value.toString();
//      _formResult.supporterType = a;
    SharedPreferences userData = await SharedPreferences.getInstance();
//    //Return int
//    int Value = prefs.getInt('jobId');


    AddCovid.userId = u_id;
    AddCovid.projectId = p_id;
    AddCovid.temperature = "Have temperature";
    AddCovid.staffName = nameController.text;
    AddCovid.company = company_nameController.text;
    AddCovid.remarks = remarksController.text;


//    _AddResult.name = widget.EconomicDetail.name.toString();
    form.save();
//    print(_AddResult.toMap());

//    SharedPreferences prefs = await SharedPreferences.getInstance();

    String tokenn = userData.getString('token');
//    String tokenn ='90|ZHVdsajU7doU6LusdhVwd2D0s9zqZAebfnUhInLT';
    String token = 'Bearer '+ tokenn;

    final uri = 'https://wewatch.ordd.tk/api/covid';
//    _onLoading();
    http.Response response = await http.post(
      uri, headers: { 'Content-type': 'application/json',
      'Accept': 'application/json', HttpHeaders.authorizationHeader: token },body: (json.encode(AddCovid.toMap())),
    );
    Navigator.pop(this.context);

    print(response.body);


    if (response.statusCode == 200) {
      print('Data saved');
      _onLoading();

//      setState(() => _dialogState = DialogState.LOADING);
//      Future.delayed(Duration(seconds: 5)).then((_) {
//        setState(() => _dialogState = DialogState.COMPLETED);
//        Timer(Duration(seconds: 5), () =>
//            setState(() => _dialogState = DialogState.DISMISSED));
//      });
    } else {
      _notUploaded();
      print('Data not saved');
      print(response.statusCode);
      throw Exception("Problem in uploading");
//      setState(() => _f_dialogState = F_DialogState.LOADING);
//      setState(() => _f_dialogState = F_DialogState.Failed);
//      Future.delayed(Duration(seconds: 5)).then((_) {
//        setState(() => _f_dialogState = F_DialogState.DISMISSED);
//      });
    }


//    print(response.body);
    print(AddCovid.toMap());



//    }

  }
  void _onLoading() {
    showDialog(
        barrierDismissible: false,
        context: this.context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 200,
              width: 300,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container( margin: EdgeInsets.only(bottom: 20.0),
                      child: Text("Form submitted",  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
                      ),
                    ),
                    SizedBox(
                      width: 150.0,
                      child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (BuildContext context) =>  covid_19_reg (),settings: RouteSettings( arguments: p_id)),
                            );

                          },
                          child: Text(
                            "Back to Form",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: DarkBlue
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
  void _notUploaded() {
    showDialog(
        context: this.context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 200,
              width: 300,

              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      child:  Text("Something went wrong..!",  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
                      ),

                    ),
                    SizedBox(
                      width: 150.0,
                      child: RaisedButton(
                          onPressed: () {Navigator.pop(context);},
                          child: Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: DarkBlue                     ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future getImageCamera() async{
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    File imageFile = new File(pickedFile.path);
    String fileExt = imageFile.path.split('.').last;
//    String basename = basename(imageFile.path);
    List<int> videoBytes = imageFile.readAsBytesSync();
    file = base64.encode(videoBytes);
    String fi = fileExt +","+ file ;

    setState(()  {
      imgString = imageFile.path;
      isPressed= false;
      AddCovid.image = fi;

    });
  }




  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row
        (
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(DarkBlue)
          ),
          Container(margin: EdgeInsets.only(left: 15.0),child:Text("please wait ..." )),
        ],),
    );

    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  Future NavigateToDashboard () async {

    if(userType == "User"){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
              (Route<dynamic> route) => false
      );
    }
    else if(userType == "Security Guard"){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => GuardDashboard()),
              (Route<dynamic> route) => false
      );
    }
    else if(userType == "Wewatch Manager"){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => wwmanager_Dashboard()),
              (Route<dynamic> route) => false
      );
    }
  }

}





