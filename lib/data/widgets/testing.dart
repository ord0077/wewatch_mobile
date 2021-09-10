import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wewatchapp/CustomAppBar.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:wewatchapp/consts.dart';
import 'package:wewatchapp/data/models/covid19Model.dart';
import 'package:wewatchapp/data/screens/user/dashboard.dart';
import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as Io;







class covid_19_reg  extends StatefulWidget {

  const covid_19_reg ({Key key}) : super(key: key);


  @override
  _covid_19_reg createState() => _covid_19_reg();
}

class _covid_19_reg  extends State<covid_19_reg > {

  int user_id;
  int project_id = 1;

  final _formKey = GlobalKey<FormState>();
  String file;
  final picker = ImagePicker();


  final scaffoldKey = GlobalKey<ScaffoldState>();
  int tempVal = 1;

  TextEditingController nameController = TextEditingController();
  TextEditingController company_nameController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  final AddCovid = CovidModel();


  void _handleRadioValueChange(int value) {
    setState(() {
      tempVal = value;


    });
  }











  @override
  void initState() {
    setState(() {


    });
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            drawer: Theme(
              data: Theme.of(context).copyWith(
                  canvasColor: Color.fromRGBO(45, 87, 163, 1) //This will change the drawer background to blue.
                //other styles
              ),
//              child: NavDrawer(),
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
                                  child: Text('Covid 19 Temp Register',
                                    style: TextStyle( fontSize: 25,fontWeight:FontWeight.bold,color: Colors.white),),
                                )

                            )


                        )
                    ),
                  ],
                )

            ),
            body:
            Center (
                child:  Form(
                    key: _formKey,
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
                                    child: ListView(
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
                                          onSaved: (val) {
                                            AddCovid.staffName = val;
                                            print( AddCovid.staffName);
                                          },
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
                                          onSaved: (val) {
                                            AddCovid.company = val;
                                            print( AddCovid.company);
                                          },
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
                                              labelText:"Remarks*" ,
                                              labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w500,color: Colors.grey)

                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            return null;
                                          },
                                          onSaved: (val) {
                                            AddCovid.remarks = val;
                                            print( AddCovid.remarks);
                                          },
                                        ),
                                        SizedBox(height: 30.0,),
                                        new Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
//                                    RaisedButton(
//                                      color: Colors.white,
//
//                                      child: Icon(Icons.camera_alt,color: Colors.blue,),
//                                      onPressed: getImageCamera,
//                                    ),

                                              SizedBox(width: 15.0,),
                                              new Text(
                                                'Take a Picture',
                                                style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w500,color: Colors.grey,

                                                ),
                                              )
                                            ]
                                        ),
                                        SizedBox(height: 20.0,),





                                      ],
                                    ),



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
                                        if (_formKey.currentState.validate()) {
                                          _submitForm();
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
            )
        )
    );
  }

  Future<void> _submitForm() async {
    final FormState form = _formKey.currentState;

//    if (form.validate()) {
//      String a= _fbKey.currentState.value.toString();
//      _formResult.supporterType = a;
    SharedPreferences prefs = await SharedPreferences.getInstance();
//    //Return int
//    int Value = prefs.getInt('jobId');
    int u_id = prefs.getInt('user_id');
    AddCovid.userId = 1;
    AddCovid.staffName="a";
    AddCovid.company = "a";
    AddCovid.remarks = "a";

    AddCovid.projectId = 1;
    AddCovid.temperature = "p";
//    AddCovid.image = "http://localhost:8000/uploads/covid/ORD_CUP.jpg";
//    AddCovid.image = "http://localhost:8000/uploads/covid/ORD_CUP.jpg";



//    _AddResult.name = widget.EconomicDetail.name.toString();
    form.save();
//    print(_AddResult.toMap());

//    SharedPreferences prefs = await SharedPreferences.getInstance();

    String tokenn = ( prefs.getString('token'));
//    String tokenn ='90|ZHVdsajU7doU6LusdhVwd2D0s9zqZAebfnUhInLT';
    String token = 'Bearer '+ tokenn;

    final uri = 'https://wewatch.ordd.tk/api/covid';
//    _onLoading();
    http.Response response = await http.post(
      Uri.parse(uri), headers: { 'Content-type': 'application/json',
      'Accept': 'application/json', HttpHeaders.authorizationHeader: token },body: (json.encode(AddCovid.toMap())),
    );
    Navigator.pop(this.context);

    print(response.toString());


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
                      child: Text("Data uploaded successfully",  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
                      ),
                    ),
                    SizedBox(
                      width: 200.0,
                      child: RaisedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => covid_19_reg()),
                                    (Route<dynamic> route) => false
                            );

                          },
                          child: Text(
                            "Back to Covid 19 Temp Register",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue
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
                      width: 200.0,
                      child: RaisedButton(
                          onPressed: () {Navigator.pop(context);},
                          child: Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Color.fromRGBO(0, 150, 136, 1)                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
//  Future getImageCamera() async{
//    final pickedFile = await picker.getImage(source: ImageSource.camera);
//    File imageFile = new File(pickedFile.path);
////    var videoFile = await ImagePicker.pickImage(source: ImageSource.camera);
//    List<int> videoBytes = imageFile.readAsBytesSync();
//    file = base64.encode(videoBytes);
//    print(file);
//    String fi = "jpg,"+ file ;
//    print(fi);
//    setState(()  {
////      _video = imageFile;
//      AddCovid.image = "abc";
//
//    });
//  }

}





