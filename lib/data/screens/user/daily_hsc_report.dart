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
import 'package:wewatchapp/data/models/dailyhscModel.dart';
import 'package:wewatchapp/data/screens/user/dashboard.dart';
import 'package:wewatchapp/data/screens/guard/guard_dashboard.dart';
import 'package:wewatchapp/data/screens/wewatchManager/wwmanager_dashboard.dart';
import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:io';






class DailyHscReport extends StatefulWidget {

  const DailyHscReport({Key key}) : super(key: key);


  @override
  _DailyHscReport createState() => _DailyHscReport();
}

class _DailyHscReport extends State<DailyHscReport> {


  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String file ;
  String _incidents= "";
  String misses = "";
  String voilaions= "";
  String first_aid= "";
  String environment= "";
  String housekeeping= "";
  String barriers= "";
  String complince= "";
  String stored_properly= "";
  String concerns= "";
  String mask_complince= "";
  String hygiene_place= "";
  String distancing_compl= "";
  String disinfecting_prot= "";

  double _height;
  double _width;
  String _setTime, _setDate = "";
  String _setTime2= "";

  String _hour, _minute, _time  = "";
  String _hour2, _minute2, _time2 = "";

  String dateTime = "";

  DateTime selectedDate = DateTime.now();
  final  dateController = TextEditingController();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");



  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00, );
  TimeOfDay selectedTime2 = TimeOfDay(hour: 00, minute: 00, );


  TextEditingController _timeController1 = TextEditingController();
  TextEditingController _timeController2 = TextEditingController();
  bool  imagePressed = false;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  final AddHsc = DailyHscModel();
  final picker = ImagePicker();

  final nameController = TextEditingController();
  final contact_noController = TextEditingController();
  final weather_conditionsController = TextEditingController();
  final work_timingsController = TextEditingController();
  final workforce_sizeController = TextEditingController();
  final subcontractorsController = TextEditingController();
  final progress_activityController = TextEditingController();
  final session_attendeesController = TextEditingController();
  final red_flagController = TextEditingController();
  final incidents_remarksController = TextEditingController();
  final near_misses_remarksController = TextEditingController();
  final violations_noncompliance_remarksController = TextEditingController();
  final first_aid_remarksController = TextEditingController();
  final environment_incidents_remarksController = TextEditingController();
  final housekeeping_remarksController = TextEditingController();
  final safety_signs_remarksController = TextEditingController();
  final work_permit_remarksController = TextEditingController();
  final drums_cylinders_remarksController = TextEditingController();
  final safety_concerns_remarksController = TextEditingController();
  final covid_face_mask_remarksController = TextEditingController();
  final covid_respiratory_hygiene_remarksController = TextEditingController();
  final social_distancing_remarksController = TextEditingController();
  final cleaning_disinfecting_remarksController = TextEditingController();
  String userType = ""?? "";





  _User() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    setState(() {
      userType = (userData.getString('user_type') ?? '');
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
        _timeController1.text = _time;

//        _timeController.text = DateFormat.jm().format(DateFormat("hh:mm:ss").parse("22:30:00"));
      });
  }
  Future<Null> _selectTime2(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime2,
    );
    if (picked != null)
      setState(() {
        selectedTime2 = picked;
        print(selectedTime2);
        _hour2 = selectedTime2.hour.toString();
        _minute2 = selectedTime2.minute.toString();
//        _mode = selectedTime.period.toString();
        _time2 = _hour2 + ' : ' + _minute2 ;
//        _timeController.text = _time;
        _timeController2.text = _time2;

//        _timeController.text = DateFormat.jm().format(DateFormat("hh:mm:ss").parse("22:30:00"));
      });
  }












  @override
  void initState() {
    setState(() {

      _incidents= 'yes';
       misses = 'yes' ;
       voilaions= 'yes';
       first_aid= 'yes';
       environment= 'yes';
       housekeeping= 'yes';
       barriers= 'yes';
       complince= 'yes';
       stored_properly= 'yes';
       concerns= 'yes';
       mask_complince= 'yes';
       hygiene_place= 'yes';
       distancing_compl= 'yes';
       disinfecting_prot= 'yes';
      _timeController1.text = DateFormat('HH:mm').format(DateTime.now());
      _timeController2.text = DateFormat('HH:mm').format(DateTime.now());
      dateController.text = dateFormat.format(selectedDate) ;
      final picker = ImagePicker();
      _User();

    });
    super.initState();
  }

  @override
  void dispose() {
     dateController.dispose();
     nameController.dispose();
     contact_noController.dispose();
     weather_conditionsController.dispose();
     work_timingsController.dispose();
     workforce_sizeController .dispose();
     subcontractorsController.dispose();
     progress_activityController.dispose();
     session_attendeesController.dispose();
     red_flagController.dispose();
     incidents_remarksController.dispose();
     near_misses_remarksController.dispose();
     violations_noncompliance_remarksController.dispose();
     first_aid_remarksController.dispose();
     environment_incidents_remarksController.dispose();
     housekeeping_remarksController.dispose();
     safety_signs_remarksController.dispose();
     work_permit_remarksController.dispose();
     drums_cylinders_remarksController.dispose();
     safety_concerns_remarksController.dispose();
     covid_face_mask_remarksController.dispose();
     covid_respiratory_hygiene_remarksController.dispose();
     social_distancing_remarksController.dispose();
     cleaning_disinfecting_remarksController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope (
        onWillPop: () {
      return NavigateToDashboard () ;
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
                    child: Text('Daily HSE Form',
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
//                                color: Color.fromRGBO(230, 230, 230, 1),
                              child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.0,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(padding: const EdgeInsets.only(top: 10.0),
                                      child:  new Container(

                                            child: Text("Date", style: TextStyle(fontSize: 22.0,fontWeight:FontWeight.w600,color: DarkBlue
                                            ))

                                        ),

                                        ),

                                      SizedBox(width: 10.0,),

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

                                    ],
                                  ),

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
                                        labelText:"Name",
                                        labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    controller: nameController,
                                    onChanged: (value){
                                      setState(() {
                                        AddHsc.name = nameController.text;

                                      });
                                    },
                                  ),
                                  SizedBox(height: 15.0,),

                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: new InputDecoration(

//                              border: InputBorder.none,
//                              focusedBorder: InputBorder.none,
//                              enabledBorder: InputBorder.none,
//                              errorBorder: InputBorder.none,
//                              disabledBorder: InputBorder.none,
                                        contentPadding:
                                        EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
//                    hintText: "Name / Staff ID*",
                                        labelText:"Contact",
                                        labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    controller: contact_noController,
                                    onChanged: (value){
                                      setState(() {
                                        AddHsc.contactNo = contact_noController.text;

                                      });
                                    },
                                  ),
                                ],
                              )
                          ),
                          SizedBox(height: 10.0,),
                          Padding(
                            padding: EdgeInsets.only(left:15.0,),
                            child:   Text("Site Details", style: TextStyle(fontSize: 22.0,fontWeight:FontWeight.w600,color: Color.fromRGBO(89, 89, 89, 1)
                            )),
                          ),
                          Container(
//                                color: Color.fromRGBO(230, 230, 230, 1),
                              child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                        labelText:"Weather Conditions",
                                        labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    controller: weather_conditionsController,
                                    onChanged: (value){
                                      setState(() {
                                        AddHsc.weatherConditions = weather_conditionsController.text;

                                      });
                                    },
                                  ),
                                  SizedBox(height: 15.0,),

                                  Padding(
                                    padding: EdgeInsets.only(left:15.0,),
                                    child:   Text("Work Timings", style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w600,color: Color.fromRGBO(89, 89, 89, 1)
                                    )),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,

                                    children: [
                                      SizedBox(width: 20.0,),
                                      Padding(padding: const EdgeInsets.only(top: 10.0),
                                        child:
                                        new Text(
                                        "From",

                                        textAlign: TextAlign.center,
                                        style:  TextStyle(fontSize: 20.0,fontWeight:FontWeight.w500,color: Color.fromRGBO(45, 87, 163, 1),),
                                      ),),
                                      SizedBox(width: 20.0,),

                                      new Flexible(
                                          child: Container(
                                            width: 200.0,
                                            child: InkWell(
                                              onTap: () {
                                                _selectTime(context);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(top: 30),
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
                                                  controller: _timeController1,
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
                                      Padding(padding: const EdgeInsets.only(top: 10.0),
                                        child:Container(
                                            child:  new Text(
                                              "To",

                                              textAlign: TextAlign.center,
                                              style:  TextStyle(fontSize: 20.0,fontWeight:FontWeight.w500,color: Color.fromRGBO(45, 87, 163, 1),),
                                            ),
                                        ),

                                        ),
                                      SizedBox(width: 20.0,),
                                      new Flexible(
                                          child: Container(
                                            width: 200.0,
                                            child: InkWell(
                                              onTap: () {
                                                _selectTime2(context);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(top: 30),
//                                  width: _width / 1.7,
//                                  height: _height / 9,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(color: Colors.grey[200]),
                                                child: TextFormField(
                                                  style: TextStyle(fontSize: 25),
                                                  textAlign: TextAlign.center,
                                                  onSaved: (String val) {
                                                    _setTime2 = val;
                                                  },
                                                  enabled: false,

                                                  keyboardType: TextInputType.text,
                                                  controller: _timeController2,
                                                  decoration: InputDecoration(
                                                      disabledBorder:
                                                      UnderlineInputBorder(borderSide: BorderSide.none),
                                                      // labelText: 'Time',
                                                      contentPadding: EdgeInsets.all(5)),
                                                ),
                                              ),
                                            ),
//                                          TextField(
//                                            readOnly: true,
////                                            controller: timeController,
//                                            decoration: InputDecoration(
//                                              hintText: 'Pick Time',
//                                              enabledBorder: OutlineInputBorder(
//                                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                                                borderSide: BorderSide(color: Colors.grey),
//                                              ),
//                                              focusedBorder: OutlineInputBorder(
//                                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                                                borderSide: BorderSide(color: Colors.grey),
//                                              ),
//                                            ),
//                                            onTap: () async {
//                                              var date =  await showDatePicker(
//                                                  context: context,
//                                                  initialDate:DateTime.now(),
//                                                  firstDate:DateTime(1900),
//                                                  lastDate: DateTime(2100));
////                                              timeController.text = date.toString().substring(0,10);
//                                            },)
                                          )

                                      ),
                                      SizedBox(width: 20.0,),
                                    ],
                                  ),
                                  SizedBox(height: 20.0,),
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
                                        labelText:"Total Workforce Size",
                                        labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    controller: workforce_sizeController,
                                    onChanged: (value){
                                      setState(() {
                                        AddHsc.workforceSize = workforce_sizeController.text;

                                      });
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
                                        labelText:"Names & Numbers of Subcontractor Staff on site",
                                        labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    controller: subcontractorsController,
                                    onChanged: (value){
                                      setState(() {
                                        AddHsc.subcontractors = subcontractorsController.text;

                                      });
                                    },
                                  ),
                                ],
                              )
                          ),
                          SizedBox(height: 30.0,),
                          Padding(
                            padding: EdgeInsets.only(left:15.0,),
                            child:   Text("Activities in Progress", style: TextStyle(fontSize: 22.0,fontWeight:FontWeight.w600,color: Color.fromRGBO(89, 89, 89, 1)
                            )),
                          ),
                          Container(
//                                  color: Color.fromRGBO(230, 230, 230, 1),
                              child: Column(
                                children: [
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
                                        labelText:"What are the in progress activities",
                                        labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    controller: progress_activityController,
                                    onChanged: (value){
                                      setState(() {
                                        AddHsc.progressActivity = progress_activityController.text;

                                      });
                                    },
                                  ),

                                ],
                              )
                          ),
                          SizedBox(height: 30.0,),
                          Padding(
                            padding: EdgeInsets.only(left:15.0,),
                            child:   Text("HSE Training / Induction", style: TextStyle(fontSize: 22.0,fontWeight:FontWeight.w600,color: Color.fromRGBO(89, 89, 89, 1)
                            )),
                          ),

                          Container(
//                                  color: Color.fromRGBO(230, 230, 230, 1),
                              child: Column(
                                children: [
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
                                        labelText:"List all delivered sessions with number of attendees",
                                        labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    controller: session_attendeesController,
                                    onChanged: (value){
                                      setState(() {
                                        AddHsc.sessionAttendees = session_attendeesController.text;

                                      });
                                    },
                                  ),
                                  SizedBox(height: 30.0,),

                                ],
                              )
                          ),
                          Column(
//                                mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child:  Padding(
                                      padding: EdgeInsets.only(left:5.0,),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child:   Text("Compliance Check List", style: TextStyle(fontSize: 18.0,fontWeight:FontWeight.w800,color: DarkBlue
                                        )),
                                      ),
                                    ),
                                  ),

                                  Spacer(),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left:5.0,),
                                        child:   Text("Yes", style: TextStyle(fontSize: 18.0,fontWeight:FontWeight.w600,color: Color.fromRGBO(89, 89, 89, 1)
                                        )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left:15.0,),
                                        child:   Text("No", style: TextStyle(fontSize: 18.0,fontWeight:FontWeight.w600,color: Color.fromRGBO(89, 89, 89, 1)
                                        )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left:15.0,right: 15.0),
                                        child:   Text("N/A", style: TextStyle(fontSize: 18.0,fontWeight:FontWeight.w600,color: Color.fromRGBO(89, 89, 89, 1)
                                        )),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 30.0,),

                              Row(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left:15.0,),
                                      child:Container(
                                        width: MediaQuery.of(context).size.width / 2,
                                        child:   Text("Were there any incidents?", style: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)
                                        )),
                                      )
                                  ),
                                  Spacer(),
                                  new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Radio(
                                        value: 'yes',
                                        groupValue: _incidents,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged:  ( value) {
                                          setState(() {
                                            _incidents = value;
                                            AddHsc.incidents =_incidents;
//                                              print(_character);
                                          });
                                        },
                                      ),

                                      new Radio(
                                        value: 'no',
                                        groupValue: _incidents,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            _incidents = value;
                                            AddHsc.incidents =_incidents;
//                                              print(_character);

                                          });
                                        },
                                      ),
                                      new Radio(
                                        value: 'n/a',
                                        groupValue: _incidents,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            _incidents = value;
                                            AddHsc.incidents =_incidents;
//                                              print(_character);

                                          });
                                        },
                                      ),


                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width / 2,
                                child: TextFormField(
                                  decoration: new InputDecoration(

                                      contentPadding:
                                      EdgeInsets.only(left: 15, bottom: 10, top: 11, right: 15),
//                    hintText: "Name / Staff ID*",
                                      labelText:"Remarks",
                                      labelStyle: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                  ),
                                  controller: incidents_remarksController,
                                  onChanged: (value){
                                    setState(() {
                                      AddHsc.incidentsRemarks = incidents_remarksController.text;

                                    });
                                  },
                                ),
//                                  SizedBox(height: 30.0,),
                              ),
                              SizedBox(height: 15.0,),

                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left:15.0,),
                                    child:Container(
                                      width: MediaQuery.of(context).size.width / 2,
                                      child:   Text("Were there any near misses?", style: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)
                                      )),
                                    ),
                                  ),
                                  Spacer(),
                                  new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Radio(
                                        value: 'yes',
                                        groupValue: misses,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged:  ( value) {
                                          setState(() {
                                            misses = value;
                                            AddHsc.nearMisses = misses;
                                            //                                              print(_character);
                                          });
                                        },
                                      ),

                                      new Radio(
                                        value: 'no',
                                        groupValue: misses,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            misses = value;
                                            AddHsc.nearMisses = misses;
//                                              print(_character);

                                          });
                                        },
                                      ),
                                      new Radio(
                                        value: 'n/a',
                                        groupValue: misses,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            misses = value;
                                            AddHsc.nearMisses = misses;
//                                              print(_character);

                                          });
                                        },
                                      ),


                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width / 2,
                                child: TextFormField(
                                  decoration: new InputDecoration(

                                      contentPadding:
                                      EdgeInsets.only(left: 15, bottom: 10, top: 11, right: 15),
//                    hintText: "Name / Staff ID*",
                                      labelText:"Remarks",
                                      labelStyle: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                  ),
                                  controller: near_misses_remarksController,
                                  onChanged: (value){
                                    setState(() {
                                      AddHsc.nearMissesRemarks = near_misses_remarksController.text;

                                    });
                                  },

                                ),
//                                  SizedBox(height: 30.0,),
                              ),
                              SizedBox(height: 15.0,),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left:15.0,),
                                    child:Container(
                                      width: MediaQuery.of(context).size.width / 2,
                                      child:   Text("Any reported safety violations/noncompliance?", style: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)
                                      )),
                                    ),
                                  ),
                                  Spacer(),
                                  new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Radio(
                                        value: 'yes',
                                        groupValue: voilaions ,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged:  ( value) {
                                          setState(() {
                                            voilaions  = value;
                                            AddHsc.violationsNoncompliance = voilaions;
                                            //                                              print(_character);
                                          });
                                        },
                                      ),

                                      new Radio(
                                        value: 'no',
                                        groupValue: voilaions ,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            voilaions  = value;
                                            AddHsc.violationsNoncompliance = voilaions;
//                                              print(_character);

                                          });
                                        },
                                      ),
                                      new Radio(
                                        value: 'n/a',
                                        groupValue: voilaions ,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            voilaions  = value;
                                            AddHsc.violationsNoncompliance = voilaions;
//                                              print(_character);

                                          });
                                        },
                                      ),


                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width / 2,
                                child: TextFormField(
                                  decoration: new InputDecoration(

                                      contentPadding:
                                      EdgeInsets.only(left: 15, bottom: 10, top: 11, right: 15),
//                    hintText: "Name / Staff ID*",
                                      labelText:"Remarks",
                                      labelStyle: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                  ),
                                  controller: violations_noncompliance_remarksController,
                                  onChanged: (value){
                                    setState(() {
                                      AddHsc.violationsNoncomplianceRemarks = violations_noncompliance_remarksController.text;

                                    });
                                  },
                                ),
//                                  SizedBox(height: 30.0,),
                              ),
                              SizedBox(height: 15.0,),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left:15.0,),
                                    child:Container(
                                      width: MediaQuery.of(context).size.width / 2,
                                      child:   Text("Any cases which required first aid?", style: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)
                                      )),
                                    ),
                                  ),
                                  Spacer(),
                                  new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Radio(
                                        value: 'yes',
                                        groupValue: first_aid,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged:  ( value) {
                                          setState(() {
                                            first_aid = value;
                                            AddHsc.firstAid = first_aid;

                                            //                                              print(_character);
                                          });
                                        },
                                      ),

                                      new Radio(
                                        value: 'no',
                                        groupValue: first_aid,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            first_aid = value;
                                            AddHsc.firstAid = first_aid;
//                                              print(_character);

                                          });
                                        },
                                      ),
                                      new Radio(
                                        value: 'n/a',
                                        groupValue: first_aid,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            first_aid = value;
                                            AddHsc.firstAid = first_aid;
//                                              print(_character);

                                          });
                                        },
                                      ),


                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width / 2,
                                child: TextFormField(
                                  decoration: new InputDecoration(

                                      contentPadding:
                                      EdgeInsets.only(left: 15, bottom: 10, top: 11, right: 15),
//                    hintText: "Name / Staff ID*",
                                      labelText:"Remarks",
                                      labelStyle: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                  ),
                                  controller: first_aid_remarksController,
                                  onChanged: (value){
                                    setState(() {
                                      AddHsc.firstAidRemarks = first_aid_remarksController.text;

                                    });
                                  },
                                ),
//                                  SizedBox(height: 30.0,),
                              ),
                              SizedBox(height: 15.0,),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left:15.0,),
                                    child:Container(
                                      width: MediaQuery.of(context).size.width / 2,
                                      child:   Text("Any noted environmental incidents? (chemical/oil spill etc.)", style: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)
                                      )),
                                    ),
                                  ),
                                  Spacer(),
                                  new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Radio(
                                        value: 'yes',
                                        groupValue: environment,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged:  ( value) {
                                          setState(() {
                                            environment = value;
                                            AddHsc.environmentIncidents = environment;

                                            //                                              print(_character);
                                          });
                                        },
                                      ),

                                      new Radio(
                                        value: 'no',
                                        groupValue: environment,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            environment = value;
                                            AddHsc.environmentIncidents = environment;
//                                              print(_character);

                                          });
                                        },
                                      ),
                                      new Radio(
                                        value: 'n/a',
                                        groupValue: environment,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            environment = value;
                                            AddHsc.environmentIncidents = environment;
//                                              print(_character);

                                          });
                                        },
                                      ),


                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width / 2,
                                child: TextFormField(
                                  decoration: new InputDecoration(

                                      contentPadding:
                                      EdgeInsets.only(left: 15, bottom: 10, top: 11, right: 15),
//                    hintText: "Name / Staff ID*",
                                      labelText:"Remarks",
                                      labelStyle: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                  ),
                                  controller: environment_incidents_remarksController,
                                  onChanged: (value){
                                    setState(() {
                                      AddHsc.environmentIncidentsRemarks = environment_incidents_remarksController.text;

                                    });
                                  },
                                ),
//                                  SizedBox(height: 30.0,),
                              ),
                              SizedBox(height: 15.0,),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left:15.0,),
                                    child:Container(
                                      width: MediaQuery.of(context).size.width / 2,
                                      child:   Text("Was the daily housekeeping done? ", style: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)
                                      )),
                                    ),
                                  ),
                                  Spacer(),
                                  new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Radio(
                                        value: 'yes',
                                        groupValue: housekeeping,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged:  ( value) {
                                          setState(() {
                                            housekeeping = value;
                                            AddHsc.housekeeping = housekeeping;
                                            //                                              print(_character);
                                          });
                                        },
                                      ),

                                      new Radio(
                                        value: 'no',
                                        groupValue: housekeeping,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            housekeeping = value;
                                            AddHsc.housekeeping = housekeeping;
//                                              print(_character);

                                          });
                                        },
                                      ),
                                      new Radio(
                                        value: 'n/a',
                                        groupValue: housekeeping,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            housekeeping = value;
                                            AddHsc.housekeeping = housekeeping;
//                                              print(_character);

                                          });
                                        },
                                      ),


                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width / 2,
                                child: TextFormField(
                                  decoration: new InputDecoration(

                                      contentPadding:
                                      EdgeInsets.only(left: 15, bottom: 10, top: 11, right: 15),
//                    hintText: "Name / Staff ID*",
                                      labelText:"Remarks",
                                      labelStyle: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                  ),
                                  controller: housekeeping_remarksController,
                                  onChanged: (value){
                                    setState(() {
                                      AddHsc.housekeepingRemarks = housekeeping_remarksController.text;

                                    });
                                  },
                                ),
//                                  SizedBox(height: 30.0,),
                              ),
                              SizedBox(height: 15.0,),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left:15.0,),
                                    child:Container(
                                        width: MediaQuery.of(context).size.width / 2,
                                        child:   Text("All identified hazards provided by safety signs/barriers?", style: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)
                                        ))
                                    ),
                                  ),
                                  Spacer(),
                                  new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Radio(
                                        value: 'yes',
                                        groupValue: barriers,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged:  ( value) {
                                          setState(() {
                                            barriers = value;
                                            AddHsc.safetySigns =barriers;
                                            //                                              print(_character);
                                          });
                                        },
                                      ),

                                      new Radio(
                                        value: 'no',
                                        groupValue: barriers,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            barriers = value;
                                            AddHsc.safetySigns =barriers;
//                                              print(_character);

                                          });
                                        },
                                      ),
                                      new Radio(
                                        value: 'n/a',
                                        groupValue: barriers,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            barriers = value;
                                            AddHsc.safetySigns =barriers;
//                                              print(_character);

                                          });
                                        },
                                      ),


                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width / 2,
                                child: TextFormField(
                                  decoration: new InputDecoration(

                                      contentPadding:
                                      EdgeInsets.only(left: 15, bottom: 10, top: 11, right: 15),
//                    hintText: "Name / Staff ID*",
                                      labelText:"Remarks",
                                      labelStyle: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                  ),
                                  controller: safety_signs_remarksController,
                                  onChanged: (value){
                                    setState(() {
                                      AddHsc.safetySignsRemarks = safety_signs_remarksController.text;

                                    });
                                  },
                                ),
//                                  SizedBox(height: 30.0,),
                              ),
                              SizedBox(height: 15.0,),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left:15.0,),
                                    child:Container(
                                      width: MediaQuery.of(context).size.width / 2,
                                      child:   Text("Work permit compliance?", style: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)
                                      )),
                                    ),
                                  ),
                                  Spacer(),
                                  new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Radio(
                                        value: 'yes',
                                        groupValue: complince,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged:  ( value) {
                                          setState(() {
                                            complince = value;
                                            AddHsc.workPermit= complince;
                                            //                                              print(_character);
                                          });
                                        },
                                      ),

                                      new Radio(
                                        value: 'no',
                                        groupValue: complince,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            complince = value;
                                            AddHsc.workPermit= complince;
//                                              print(_character);

                                          });
                                        },
                                      ),
                                      new Radio(
                                        value: 'n/a',
                                        groupValue: complince,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            complince = value;
                                            AddHsc.workPermit= complince;
//                                              print(_character);

                                          });
                                        },
                                      ),


                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width / 2,
                                child: TextFormField(
                                  decoration: new InputDecoration(

                                      contentPadding:
                                      EdgeInsets.only(left: 15, bottom: 10, top: 11, right: 15),
//                    hintText: "Name / Staff ID*",
                                      labelText:"Remarks",
                                      labelStyle: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                  ),
                                  controller: work_permit_remarksController,
                                  onChanged: (value){
                                    setState(() {
                                      AddHsc.workPermitRemarks = work_permit_remarksController.text;

                                    });
                                  },
                                ),
//                                  SizedBox(height: 30.0,),
                              ),
                              SizedBox(height: 15.0,),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left:15.0,),
                                    child:Container(
                                        width: MediaQuery.of(context).size.width / 2,
                                        child:Text("All oil drums/compressed gas cylinders and hazardous energy stored properly?", style: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)

                                        )
                                        )),
                                  ),
                                  Spacer(),
                                  new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Radio(
                                        value: 'yes',
                                        groupValue: stored_properly,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged:  ( value) {
                                          setState(() {
                                            stored_properly = value;
                                            AddHsc.drumsCylinders =stored_properly;
                                            //                                              print(_character);
                                          });
                                        },
                                      ),

                                      new Radio(
                                        value: 'no',
                                        groupValue: stored_properly,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            stored_properly = value;
                                            AddHsc.drumsCylinders =stored_properly;
//                                              print(_character);

                                          });
                                        },
                                      ),
                                      new Radio(
                                        value: 'n/a',
                                        groupValue: stored_properly,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            stored_properly = value;
                                            AddHsc.drumsCylinders =stored_properly;
//                                              print(_character);

                                          });
                                        },
                                      ),


                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width / 2,
                                child: TextFormField(
                                  decoration: new InputDecoration(

                                      contentPadding:
                                      EdgeInsets.only(left: 15, bottom: 10, top: 11, right: 15),
//                    hintText: "Name / Staff ID*",
                                      labelText:"Remarks",
                                      labelStyle: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                  ),
                                  controller: drums_cylinders_remarksController,
                                  onChanged: (value){
                                    setState(() {
                                      AddHsc..drumsCylindersRemarks = drums_cylinders_remarksController.text;

                                    });
                                  },
                                ),
//                                  SizedBox(height: 30.0,),
                              ),
                              SizedBox(height: 15.0,),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left:15.0,),
                                    child:Container(
                                        width: MediaQuery.of(context).size.width / 2,
                                        child:Text("Any major safety concerns?", style: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)

                                        )
                                        )),
                                  ),
                                  Spacer(),
                                  new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Radio(
                                        value: 'yes',
                                        groupValue: concerns,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged:  ( value) {
                                          setState(() {
                                            concerns = value;
                                            AddHsc.safetyConcerns = concerns;
                                            //                                              print(_character);
                                          });
                                        },
                                      ),

                                      new Radio(
                                        value: 'no',
                                        groupValue: concerns,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            concerns = value;
                                            AddHsc.safetyConcerns = concerns;
//                                              print(_character);

                                          });
                                        },
                                      ),
                                      new Radio(
                                        value: 'n/a',
                                        groupValue: concerns,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            concerns = value;
                                            AddHsc.safetyConcerns = concerns;
//                                              print(_character);

                                          });
                                        },
                                      ),


                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width / 2,
                                child: TextFormField(
                                  decoration: new InputDecoration(

                                      contentPadding:
                                      EdgeInsets.only(left: 15, bottom: 10, top: 11, right: 15),
//                    hintText: "Name / Staff ID*",
                                      labelText:"Remarks",
                                      labelStyle: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                  ),
                                  controller: safety_concerns_remarksController,
                                  onChanged: (value){
                                    setState(() {
                                      AddHsc.safetyConcernsRemarks = safety_concerns_remarksController.text;

                                    });
                                  },
                                ),
//                                  SizedBox(height: 30.0,),
                              ),
                              SizedBox(height: 15.0,),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left:15.0,),
                                    child:Container(
                                        width: MediaQuery.of(context).size.width / 2,
                                        child:Text("COVID Prevention – face mask compliance?", style: TextStyle(fontSize:16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)

                                        )
                                        )),
                                  ),
                                  Spacer(),
                                  new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Radio(
                                        value: 'yes',
                                        groupValue: mask_complince,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged:  ( value) {
                                          setState(() {
                                            mask_complince = value;
                                            AddHsc.covidFaceMask = mask_complince;
                                            //                                              print(_character);
                                          });
                                        },
                                      ),

                                      new Radio(
                                        value: 'no',
                                        groupValue: mask_complince,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            mask_complince = value;
                                            AddHsc.covidFaceMask = mask_complince;
//                                              print(_character);

                                          });
                                        },
                                      ),
                                      new Radio(
                                        value: 'n/a',
                                        groupValue: mask_complince,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            mask_complince = value;
                                            AddHsc.covidFaceMask = mask_complince;
//                                              print(_character);

                                          });
                                        },
                                      ),


                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width / 2,
                                child: TextFormField(
                                  decoration: new InputDecoration(

                                      contentPadding:
                                      EdgeInsets.only(left: 15, bottom: 10, top: 11, right: 15),
//                    hintText: "Name / Staff ID*",
                                      labelText:"Remarks",
                                      labelStyle: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                  ),
                                  controller: covid_face_mask_remarksController,
                                  onChanged: (value){
                                    setState(() {
                                      AddHsc.covidFaceMaskRemarks = covid_face_mask_remarksController.text;

                                    });
                                  },
                                ),
//                                  SizedBox(height: 30.0,),
                              ),
                              SizedBox(height: 15.0,),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left:15.0,),
                                    child:Container(
                                        width: MediaQuery.of(context).size.width / 2,
                                        child:Text("COVID Prevention – good hand and respiratory hygiene in place?", style: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)

                                        )
                                        )),
                                  ),
                                  Spacer(),
                                  new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Radio(
                                        value: 'yes',
                                        groupValue: hygiene_place,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged:  ( value) {
                                          setState(() {
                                            hygiene_place = value;
                                            AddHsc.covidRespiratoryHygiene = hygiene_place;
                                            //                                              print(_character);
                                          });
                                        },
                                      ),

                                      new Radio(
                                        value: 'no',
                                        groupValue: hygiene_place,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            hygiene_place = value;
                                            AddHsc.covidRespiratoryHygiene = hygiene_place;
//                                              print(_character);

                                          });
                                        },
                                      ),
                                      new Radio(
                                        value: 'n/a',
                                        groupValue: hygiene_place,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            hygiene_place = value;
                                            AddHsc.covidRespiratoryHygiene = hygiene_place;
//                                              print(_character);

                                          });
                                        },
                                      ),


                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width / 2,
                                child: TextFormField(
                                  decoration: new InputDecoration(

                                      contentPadding:
                                      EdgeInsets.only(left: 15, bottom: 10, top: 11, right: 15),
//                    hintText: "Name / Staff ID*",
                                      labelText:"Remarks",
                                      labelStyle: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                  ),
                                  controller: covid_respiratory_hygiene_remarksController,
                                  onChanged: (value){
                                    setState(() {
                                      AddHsc.covidRespiratoryHygieneRemarks = covid_respiratory_hygiene_remarksController.text;

                                    });
                                  },
                                ),
//                                  SizedBox(height: 30.0,),
                              ),
                              SizedBox(height: 15.0,),

                              Row(
                                children: [

                                  Padding(
                                    padding: EdgeInsets.only(left:15.0,),
                                    child:Container(
                                        width: MediaQuery.of(context).size.width / 2,
                                        child:Text("COVID Prevention – social distancing compliance?", style: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)

                                        )
                                        )),
                                  ),
                                  Spacer(),
                                  new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Radio(
                                        value: 'yes',
                                        groupValue: distancing_compl,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged:  ( value) {
                                          setState(() {
                                            distancing_compl = value;
                                            AddHsc.socialDistancing = distancing_compl;

                                            //                                              print(_character);
                                          });
                                        },
                                      ),

                                      new Radio(
                                        value: 'no',
                                        groupValue: distancing_compl,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            distancing_compl = value;
                                            AddHsc.socialDistancing = distancing_compl;
//                                              print(_character);

                                          });
                                        },
                                      ),
                                      new Radio(
                                        value: 'n/a',
                                        groupValue: distancing_compl,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            distancing_compl = value;
                                            AddHsc.socialDistancing = distancing_compl;
//                                              print(_character);

                                          });
                                        },
                                      ),


                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width / 2,
                                child: TextFormField(
                                  decoration: new InputDecoration(

                                      contentPadding:
                                      EdgeInsets.only(left: 15, bottom: 10, top: 11, right: 15),
//                    hintText: "Name / Staff ID*",
                                      labelText:"Remarks",
                                      labelStyle: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                  ),
                                  controller: social_distancing_remarksController,
                                  onChanged: (value){
                                    setState(() {
                                      AddHsc.socialDistancingRemarks = social_distancing_remarksController.text;

                                    });
                                  },
                                ),
//                                  SizedBox(height: 30.0,),
                              ),
                              SizedBox(height: 15.0,),

                              Row(
                                children: [

                                  Padding(
                                    padding: EdgeInsets.only(left:15.0,),
                                    child:Container(
                                        width: MediaQuery.of(context).size.width / 2,
                                        child:Text("COVID Prevention – cleaning and disinfecting protocols?", style: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)

                                        )
                                        )),
                                  ),
                                  Spacer(),
                                  new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Radio(
                                        value: 'yes',
                                        groupValue: disinfecting_prot,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged:  ( value) {
                                          setState(() {
                                            disinfecting_prot = value;
                                            AddHsc.cleaningDisinfecting = disinfecting_prot;
                                            //                                              print(_character);
                                          });
                                        },
                                      ),

                                      new Radio(
                                        value: 'no',
                                        groupValue: disinfecting_prot,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            disinfecting_prot = value;
                                            AddHsc.cleaningDisinfecting = disinfecting_prot;
//                                              print(_character);

                                          });
                                        },
                                      ),
                                      new Radio(
                                        value: 'n/a',
                                        groupValue: disinfecting_prot,
                                        activeColor: Color.fromRGBO(45, 87, 163, 1),

                                        onChanged: ( value) {
                                          setState(() {
                                            disinfecting_prot = value;
                                            AddHsc.cleaningDisinfecting = disinfecting_prot;
//                                              print(_character);

                                          });
                                        },
                                      ),


                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width / 2,
                                child: TextFormField(
                                  decoration: new InputDecoration(

                                      contentPadding:
                                      EdgeInsets.only(left: 15, bottom: 10, top: 11, right: 15),
//                    hintText: "Name / Staff ID*",
                                      labelText:"Remarks",
                                      labelStyle: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                  ),
                                  controller: cleaning_disinfecting_remarksController,
                                  onChanged: (value){
                                    setState(() {
                                      AddHsc.cleaningDisinfectingRemarks = cleaning_disinfecting_remarksController.text;

                                    });
                                  },
                                ),
//                                  SizedBox(height: 30.0,),
                              ),
                              SizedBox(height: 15.0,),
                            ],
                          ),

                          SizedBox(height: 20.0,),

                          Padding(
                            padding: EdgeInsets.only(left:15.0,),
                            child:   Text("Red Flag", style: TextStyle(fontSize: 22.0,fontWeight:FontWeight.w600,color: Color.fromRGBO(89, 89, 89, 1)
                            )),
                          ),
                          Container(
//                                  color: Color.fromRGBO(230, 230, 230, 1),
                              child: Column(
                                children: [
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
                                        labelText:"Any Red Flag?",
                                        labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    controller: red_flagController,
                                    onChanged: (value){
                                      setState(() {
                                        AddHsc.redFlag = red_flagController.text;

                                      });
                                    },
                                  ),
                                  SizedBox(height: 30.0,),

                                ],
                              )
                          ),

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
                                Container(

                                    child:  Row(

                                      children: <Widget>[
                                        RaisedButton(
                                          color: (imagePressed) ? Colors.red
                                              : DarkBlue,
                                          child: Icon(Icons.camera_alt, color: Colors.white,),
                                          onPressed: getImageCamera,
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
                                                            Icon(Icons.image,color: Colors.white,),
                                                            SizedBox(width: 10.0,),
                                                            Text('Gallery', style: TextStyle(color: Colors.white),),
                                                          ],
                                                        ),
                                                      ),

                                                      onPressed: (){
                                                        getImageGallery();
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
//
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
                                if (_formKey.currentState.validate() && file != null ) {
                                  showLoaderDialog(context);
                                  submitForm();


                                }
                                else if ( file == null ){

                                  setState(()
                                  {
                                    imagePressed = true;
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
//                      ),
                    ],
                  ),



                )
            )

        )
                  )
        );
  }


  Future<void> submitForm() async {
    final FormState form = _formKey.currentState;

//    if (form.validate()) {
//      String a= _fbKey.currentState.value.toString();
//      _formResult.supporterType = a;
    SharedPreferences userData = await SharedPreferences.getInstance();
//    //Return int
//    int Value = prefs.getInt('jobId');
    int u_id = userData.getInt('user_id');
    int p_id = userData.getInt('project_id');
    AddHsc.userId = u_id;
    AddHsc.projectId = ModalRoute.of(context).settings.arguments;
    AddHsc.date = dateController.text;
    AddHsc.workTimings = _timeController1.text;



//    _AddResult.name = widget.EconomicDetail.name.toString();
    form.save();
//    print(_AddResult.toMap());

//    SharedPreferences prefs = await SharedPreferences.getInstance();

    String tokenn = userData.getString('token');
//    String tokenn ='90|ZHVdsajU7doU6LusdhVwd2D0s9zqZAebfnUhInLT';
    String token = 'Bearer '+ tokenn;

    final uri = baseURL +'hsereport';
//    _onLoading();
    http.Response response = await http.post(
      Uri.parse(uri), headers: { 'Content-type': 'application/json',
      'Accept': 'application/json', HttpHeaders.authorizationHeader: token },body: (json.encode(AddHsc.toMap())),
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
    print(AddHsc.toMap());



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
                              MaterialPageRoute(builder: (BuildContext context) =>  DailyHscReport (),),
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
      content: new Row(
        children: [
          CircularProgressIndicator(),
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


  Future getImageGallery() async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    File imageFile = new File(pickedFile.path);
    String fileExt = imageFile.path.split('.').last;
//    String basename = basename(imageFile.path);
    List<int> videoBytes = imageFile.readAsBytesSync();
    file = base64.encode(videoBytes);
    String fi = fileExt +","+ file ;

    setState(()  {
      imagePressed = false;
      AddHsc.attachment = fi;

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
      imagePressed = false;
      AddHsc.attachment = fi;

    });
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





