import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wewatchapp/CustomAppBar.dart';
import 'package:wewatchapp/DbControllers/AccidentIncidentController.dart';
import 'package:wewatchapp/data/models/accidentModel.dart';
import 'package:wewatchapp/data/screens/user/dashboard.dart';
import 'package:wewatchapp/data/screens/guard/guard_dashboard.dart';
import 'package:wewatchapp/data/screens/wewatchManager/wwmanager_dashboard.dart';
import 'package:wewatchapp/data/widgets/Custom_Button.dart';
import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';
import 'package:wewatchapp/data/widgets/testing.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:io' as Io;
import '../../../consts.dart';
import 'package:wewatchapp/consts.dart';
import 'package:flutter/services.dart';


class AccidentIncidentReport extends StatefulWidget {

  const AccidentIncidentReport({Key key}) : super(key: key);


  @override
  _AccidentIncidentReport createState() => _AccidentIncidentReport();
}

class _AccidentIncidentReport extends State<AccidentIncidentReport> {

  final picker = ImagePicker();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String file;
  final  dateController = TextEditingController();
  final timeController = TextEditingController();
  final otherController = TextEditingController();
  final fatalityController = TextEditingController();
  final incidentController = TextEditingController();
  final immediateController = TextEditingController();



//  TextEditingController dateController = TextEditingController();
//  TextEditingController timeController = TextEditingController();
  String categoryIncident = 'Nearmiss';
  String typeInjury = 'none';
  String typeIncident = 'Event Equipment';
  String _setTime;
  String _hour, _minute, _time ;
  String dateTime;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00, );
  TextEditingController _timeController1 = TextEditingController();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  final AddAccident = AccidentModel();
  bool  imagePressed = false;
  String userType = ""?? "";
  int p_id;
  int u_id;
  String imgString;
  String location = '';
  String filename = '';

  _User() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    setState(() {
      List<dynamic> args = ModalRoute.of(context).settings.arguments;
      userType = (userData.getString('user_type') ?? '');
      u_id = userData.getInt('user_id');
      p_id = args[0];
      location = args[1];
    });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        print(selectedTime);
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
//        _mode = selectedTime.period.toString();
        _time = _hour + ' : ' + _minute ;
//        _timeController.text = _time;
        timeController.text = _time;

//        _timeController.text = DateFormat.jm().format(DateFormat("hh:mm:ss").parse("22:30:00"));
      });
  }

  List list;
  bool loading = true;

  Future userList()async{
    list = await AccidentIncidentController().fetchData();
    setState(() {loading=false;});
    //print(list);
  }



  @override
  void initState() {
    userList();
    _User();
    categoryIncident = 'Nearmiss';
    typeInjury = 'none';
    typeIncident = 'Event Equipment';
    timeController.text = DateFormat('HH:mm').format(DateTime.now());
    dateController.text = dateFormat.format(selectedDate) ;
    super.initState();



  }

  @override
  void dispose() {
    this.dateController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope (
        onWillPop: ()  {
          return NavigateToDashboard();
        },
        child: SafeArea(
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
                                    child: Text('Accident / Incident Form',
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


                                            new Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin:const EdgeInsets.only(left: 15.0,),
                                                    child:
                                                    Text("Location : ",style: new TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1)) ),

                                                  ),
                                                  new Text(
                                                    location ?? '',
                                                    style: new  TextStyle(fontSize: 20.0,fontWeight:FontWeight.w500,color: DarkBlue),
                                                  ),

                                                ]
                                            ),
                                            SizedBox(height: 30.0,),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                new Flexible(
                                                    child: Container(
                                                      width: 230.0,
                                                      child:Center(
                                                        child: Text(
                                                          "Date",

                                                          textAlign: TextAlign.center,
                                                          style:  TextStyle(fontSize: 20.0,fontWeight:FontWeight.w500,color: Color.fromRGBO(45, 87, 163, 1),),
                                                        ),
                                                      ),
                                                    )

                                                ),
                                                SizedBox(width: 20.0,),
                                                new Flexible(
                                                    child: Container(
                                                      width: 230.0,
                                                      child:Center(
                                                        child: Text(
                                                          "Time",
                                                          textAlign: TextAlign.center,
                                                          style:  TextStyle(fontSize: 20.0,fontWeight:FontWeight.w500,color: Color.fromRGBO(45, 87, 163, 1),),

                                                        ),
                                                      ),
                                                    )

                                                ),
                                                SizedBox(width: 20.0,),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                new Flexible(
                                                    child: Container(
                                                      width: 230.0,
                                                      child:InkWell(
                                                        onTap: () async {
                                                          var date =  await showDatePicker(
                                                              context: context,
                                                              initialDate:DateTime.now(),
                                                              firstDate:DateTime(2021),
                                                              lastDate: DateTime(2100)
                                                          );
                                                          dateController.text = date.toString().substring(0,10);
                                                        },
                                                        child: Container(
                                                          margin: EdgeInsets.only(top: 10),
//                                  width: _width / 1.7,
//                                  height: _height / 9,
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(color: Colors.grey[200]),
                                                          child: TextFormField(
                                                            style: TextStyle(fontSize: 25),
                                                            textAlign: TextAlign.center,
                                                            onSaved: (String val) {
                                                              _setTime = val;
                                                            },
                                                            enabled: false,

                                                            keyboardType: TextInputType.text,
                                                            controller: dateController,
                                                            decoration: InputDecoration(
                                                                disabledBorder:
                                                                UnderlineInputBorder(borderSide: BorderSide.none),
                                                                // labelText: 'Time',
                                                                contentPadding: EdgeInsets.all(5)),
                                                          ),
                                                        ),
                                                      ),
                                                    )

                                                ),
                                                SizedBox(width: 20.0,),
                                                new Flexible(
                                                    child: Container(
                                                      width: 230.0,
                                                      child: InkWell(
                                                        onTap: () {
                                                          _selectTime(context);
                                                        },
                                                        child: Container(
                                                          margin: EdgeInsets.only(top: 10),
//                                  width: _width / 1.7,
//                                  height: _height / 9,
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(color: Colors.grey[200]),
                                                          child: TextFormField(
                                                            style: TextStyle(fontSize: 25),
                                                            textAlign: TextAlign.center,
                                                            onSaved: (String val) {
                                                              _setTime = val;
                                                            },
                                                            enabled: false,

                                                            keyboardType: TextInputType.text,
                                                            controller: timeController,
                                                            decoration: InputDecoration(
                                                                disabledBorder:
                                                                UnderlineInputBorder(borderSide: BorderSide.none),
                                                                // labelText: 'Time',
                                                                contentPadding: EdgeInsets.all(5)),
                                                          ),
                                                        ),
                                                      ),
                                                    )

                                                ),
                                                SizedBox(width: 20.0,),
                                              ],
                                            ),
                                            SizedBox(height: 30.0,),
                                            Padding(
                                              padding: EdgeInsets.only(left:15.0,),
                                              child:   Text("Category of Incident", style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)
                                              )),
                                            ),


                                            ButtonTheme(
                                              alignedDropdown: true,
                                              child: DropdownButton<String>(

                                                isExpanded: true,
                                                value: categoryIncident,
                                                icon: Icon(Icons.arrow_drop_down),
                                                iconSize: 24,
                                                elevation: 16,
                                                style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400, color: Color.fromRGBO(113, 113, 113, 1)
                                                ),
                                                underline: Container(
                                                    height: 1,
                                                    color: Color.fromRGBO(113, 113, 113, 1)

                                                ),
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    categoryIncident = newValue;
                                                  });
                                                },
                                                items: <String>['Nearmiss', 'Personal Injury', 'Property Damage', 'Environmental','Security']
                                                    .map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                            SizedBox(height: 30.0,),
                                            Padding(
                                              padding: EdgeInsets.only(left:15.0,),
                                              child:   Text("Type of Injury (if any)", style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)
                                              )),
                                            ),


                                            ButtonTheme(
                                              alignedDropdown: true,
                                              child: DropdownButton<String>(

                                                isExpanded: true,
                                                value: typeInjury,
                                                icon: Icon(Icons.arrow_drop_down),
                                                iconSize: 24,
                                                elevation: 16,
                                                style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400, color: Color.fromRGBO(113, 113, 113, 1)
                                                ),
                                                underline: Container(
                                                    height: 1,
                                                    color: Color.fromRGBO(113, 113, 113, 1)

                                                ),
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    typeInjury = newValue;
                                                  });
                                                },
                                                items: <String>['First Aid Case', 'Medical Treatment Case', 'Lost Time Injury', 'Environmental','Security','none']
                                                    .map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                            SizedBox(height: 30.0,),
                                            Padding(
                                              padding: EdgeInsets.only(left:15.0,),
                                              child:   Text("Type of Incident", style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)
                                              )),
                                            ),


                                            ButtonTheme(
                                              alignedDropdown: true,
                                              child: DropdownButton<String>(

                                                isExpanded: true,
                                                value: typeIncident,
                                                icon: Icon(Icons.arrow_drop_down),
                                                iconSize: 24,
                                                elevation: 16,
                                                style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400, color: Color.fromRGBO(113, 113, 113, 1)
                                                ),
                                                underline: Container(
                                                    height: 1,
                                                    color: Color.fromRGBO(113, 113, 113, 1)

                                                ),
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    typeIncident = newValue;
                                                  });
                                                },
                                                items: <String>['Event Equipment', 'Scaffolding Collapse', 'Road Traffic Accident', 'Falls from Height','Security','Other']
                                                    .map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                            SizedBox(height: 30.0,),

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
                                                  labelText:"Other",
                                                  labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                              ),
//                                validator: (value) {
//                                  if (value.isEmpty) {
//                                    return 'Please enter some text';
//                                  }
//                                  return null;
//                                },
                                              controller: otherController,
                                            ),
                                            SizedBox(height: 30.0,),
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
                                                  labelText:"Details of fatality",
                                                  labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                              ),
//                                validator: (value) {
//                                  if (value.isEmpty) {
//                                    return 'Please enter some text';
//                                  }
//                                  return null;
//                                },
                                              controller: fatalityController,
                                            ),
                                            SizedBox(height: 30.0,),
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
                                                  labelText:"Describe the incident",
                                                  labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                              ),
//                                validator: (value) {
//                                  if (value.isEmpty) {
//                                    return 'Please enter some text';
//                                  }
//                                  return null;
//                                },
                                              controller: incidentController,
                                            ),
                                            SizedBox(height: 30.0,),
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
                                                  labelText:"Immediate Action (taken)",
                                                  labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                              ),
//                                validator: (value) {
//                                  if (value.isEmpty) {
//                                    return 'Please enter some text';
//                                  }
//                                  return null;
//                                },
                                              controller: immediateController,
                                            ),
                                            SizedBox(height: 20.0,),

                                            new  Container(
                                              margin: EdgeInsets.only(left:8.0,),

                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,

                                                children: <Widget>[
                                                  Container(
                                                    child: file == null
                                                        ? new Text("Add attachment",style: TextStyle(fontSize: 20.0,color: DarkBlue,),)
                                                        : new Text("Attachment added",style: TextStyle(fontSize: 20.0,color: Colors.green,)),
                                                  ),
                                                  Text(filename??'',style: new TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1)) ),

                                                  Container(

                                                      child:  Row(

                                                        children: <Widget>[
                                                          RaisedButton(

                                                              color: (imagePressed) ? Colors.red
                                                                  : DarkBlue,
                                                              child: Icon(Icons.camera_alt, color: Colors.white,),
                                                              onPressed:(){
                                                                FocusScope.of(context).requestFocus(FocusNode());
                                                                getImageCamera();
                                                              }


                                                          ),
                                                          SizedBox(width: 10.0,),
                                                          Padding(

                                                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                                                              child: Align(
                                                                  alignment: Alignment.topLeft,
                                                                  child:SizedBox(
                                                                    width: 120,
                                                                    child: ElevatedButton(

                                                                        style: ElevatedButton.styleFrom(
                                                                          primary: (imagePressed) ? Colors.red
                                                                              : DarkBlue,
                                                                          onPrimary: Color.fromRGBO(32, 87, 163, 1),
                                                                        ),

//                                                       ),
                                                                        child: Container(
                                                                          child: Row(
                                                                            children: <Widget>[
                                                                              Icon(Icons.file_upload,color: Colors.white,),
                                                                              SizedBox(width: 10.0,),
                                                                              Text('Upload', style: TextStyle(color: Colors.white),),
                                                                            ],
                                                                          ),
                                                                        ),

                                                                        onPressed: (){
                                                                          FocusScope.of(context).requestFocus(FocusNode());
                                                                          getFile();
                                                                          //Actions
                                                                        }
                                                                    ),
                                                                  )
                                                              )

                                                          ),

                                                        ],
                                                      )
                                                  ),
                                                  SizedBox(height: 15.0,),
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




                                          ],
                                        ),
                                      )
                                  )
                              ),
                            ),
                            Align(
                              child: SizedBox(
//                              width: 600,

                                child:
                                BouncingButton(
                                    onPress: () {

                                      if (_formKey.currentState.validate() && file != null ) {
                                        showLoaderDialog(context);
                                        _Submit();


                                      }
                                      else if ( file == null ){

                                        setState(()
                                        {
                                          imagePressed = true;
                                        });
                                      }
                                    },
                                    child: Container()
                                ),
                              ),
                            )
                          ],
                        ),



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

    AccidentModel accidentModel = AccidentModel( id: null, projectId: p_id, userId: u_id, location: location ,reportedDate: dateController.text ,
      reportedTime: timeController.text, categoryIncident:categoryIncident,typeInjury:typeInjury,typeIncident:typeIncident,other:otherController.text,
      fatality: fatalityController.text,describeIncident:incidentController.text,immediateAction:immediateController.text ,attachment: imgString,);
    await AccidentIncidentController().addData(accidentModel).then((value){
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

    AddAccident.userId = u_id;
    AddAccident.projectId = p_id;
    AddAccident.location = location;
    AddAccident.reportedDate = dateController.text;
    AddAccident.reportedTime = timeController.text;
    AddAccident.categoryIncident = categoryIncident;
    AddAccident.typeInjury = typeInjury;
    AddAccident.typeIncident = typeIncident;
    AddAccident.other = otherController.text;
    AddAccident.fatality = fatalityController.text;
    AddAccident.describeIncident = incidentController.text;
    AddAccident.immediateAction = immediateController.text;
//    AddAccident.attachment = "jpg,abc";




//    _AddResult.name = widget.EconomicDetail.name.toString();
    form.save();
//    print(_AddResult.toMap());

//    SharedPreferences prefs = await SharedPreferences.getInstance();

    String tokenn = userData.getString('token');
//    String tokenn ='90|ZHVdsajU7doU6LusdhVwd2D0s9zqZAebfnUhInLT';
    String token = 'Bearer '+ tokenn;

    final uri =  baseURL + 'accidentincident';
//    _onLoading();
    http.Response response = await http.post(
      Uri.parse(uri), headers: { 'Content-type': 'application/json',
      'Accept': 'application/json', HttpHeaders.authorizationHeader: token },body: (json.encode(AddAccident.toMap())),
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
    print(AddAccident.toMap());



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
                              MaterialPageRoute(builder: (BuildContext context) =>  AccidentIncidentReport (),settings: RouteSettings( arguments: [p_id,location])),
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

  Future getFile() async {

    FilePickerResult  result = await FilePicker.platform.pickFiles(
      type: FileType.any,);

    if(result != null) {
      filename = result.files.single.name;
      File filee = File(result.files.single.path);
      int sizeInBytes = filee.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      if (sizeInMb > 10){
        Fluttertoast.showToast(
            msg: "Attachment should be less than 10 Mb",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 16.0
        );      }
      else {
        String fileExt = filee.path.split('.').last;
        List<int> videoBytes = filee.readAsBytesSync();
        file = base64.encode(videoBytes);
        String fi = fileExt +","+ file ;
        setState(()  {
          imagePressed = false;
          imgString = filee.path;
          AddAccident.attachment = fi;

        });
      }


    }

  }

  // Future getImageGallery() async{
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   File imageFile = new File(pickedFile.path);
  //   String fileExt = imageFile.path.split('.').last;
  //   List<int> videoBytes = imageFile.readAsBytesSync();
  //   file = base64.encode(videoBytes);
  //   String fi = fileExt +","+ file ;
  //   setState(()  {
  //     imagePressed = false;
  //     imgString = imageFile.path;
  //     AddAccident.attachment = fi;
  //
  //   });
  // }

  Future getImageCamera() async{
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    File imageFile = new File(pickedFile.path);
    filename = imageFile.path.split('/').last;
    String fileExt = imageFile.path.split('.').last;
//    String basename = basename(imageFile.path);
    List<int> videoBytes = imageFile.readAsBytesSync();
    file = base64.encode(videoBytes);
    String fi = fileExt +","+ file ;

    setState(()  {
      imagePressed = false;
      imgString = imageFile.path;
      AddAccident.attachment = fi;

    });
  }

}





