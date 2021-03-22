import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wewatchapp/CustomAppBar.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:wewatchapp/consts.dart';
import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';






class DailyHscReport extends StatefulWidget {

  const DailyHscReport({Key key}) : super(key: key);


  @override
  _DailyHscReport createState() => _DailyHscReport();
}

class _DailyHscReport extends State<DailyHscReport> {


  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String file;
  String _incidents;
  String misses ;
  String voilaions;
  String first_aid;
  String environment;
  String housekeeping;
  String barriers;
  String complince;
  String stored_properly;
  String concerns;
  String mask_complince;
  String hygiene_place;
  String distancing_compl;
  String disinfecting_prot;

  double _height;
  double _width;
  String _setTime, _setDate;
  String _setTime2;

  String _hour, _minute, _time ;
  String _hour2, _minute2, _time2;

  String dateTime;

  DateTime selectedDate = DateTime.now();
  DateTime selectedDate2 = DateTime.now();



  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00, );
  TimeOfDay selectedTime2 = TimeOfDay(hour: 00, minute: 00, );


  TextEditingController _timeController1 = TextEditingController();
  TextEditingController _timeController2 = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();



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
      _timeController1.text = DateFormat.jm().format(DateTime.now());
      _timeController2.text = DateFormat.jm().format(DateTime.now());


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
                    child: Text('Daily HSC Report',
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
//                              SizedBox(height: 40.0,),


//                              Row(
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                crossAxisAlignment: CrossAxisAlignment.center,
//                                children: [
//                                  new Flexible(
//                                      child: Container(
//                                        width: 230.0,
//                                        child:Center(
//                                          child: Text(
//                                            "Date",
//
//                                            textAlign: TextAlign.center,
//                                            style:  TextStyle(fontSize: 20.0,fontWeight:FontWeight.w500,color: Color.fromRGBO(45, 87, 163, 1),),
//                                          ),
//                                        ),
//                                      )
//
//                                  ),
//                                  SizedBox(width: 20.0,),
//                                  new Flexible(
//                                      child: Container(
//                                        width: 230.0,
//                                        child:Center(
//                                          child: Text(
//                                            "Time",
//                                            textAlign: TextAlign.center,
//                                            style:  TextStyle(fontSize: 20.0,fontWeight:FontWeight.w500,color: Color.fromRGBO(45, 87, 163, 1),),
//
//                                          ),
//                                        ),
//                                      )
//
//                                  ),
//                                  SizedBox(width: 20.0,),
//                                ],
//                              ),
//                              Row(
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                crossAxisAlignment: CrossAxisAlignment.center,
//                                children: [
//                                  new Flexible(
//                                      child: Container(
//                                          width: 230.0,
//                                        child: InkWell(
//                                          onTap: () {
//                                            _selectTime(context);
//                                          },
//                                          child: Container(
//                                            margin: EdgeInsets.only(top: 30),
////                                  width: _width / 1.7,
////                                  height: _height / 9,
//                                            alignment: Alignment.center,
//                                            decoration: BoxDecoration(color: Colors.grey[200]),
//                                            child: TextFormField(
//                                              style: TextStyle(fontSize: 40),
//                                              textAlign: TextAlign.center,
//                                              onSaved: (String val) {
//                                                _setTime = val;
//                                              },
//                                              enabled: false,
//
//                                              keyboardType: TextInputType.text,
//                                              controller: _timeController1,
//                                              decoration: InputDecoration(
//                                                  disabledBorder:
//                                                  UnderlineInputBorder(borderSide: BorderSide.none),
//                                                  // labelText: 'Time',
//                                                  contentPadding: EdgeInsets.all(5)),
//                                            ),
//                                          ),
//                                        ),
//                                      )
//
//                                  ),
//                                  SizedBox(width: 20.0,),
//                                  new Flexible(
//                                      child: Container(
//                                          width: 230.0,
//                                          child: InkWell(
//                                            onTap: () {
//                                              _selectTime2(context);
//                                            },
//                                            child: Container(
//                                              margin: EdgeInsets.only(top: 30),
////                                  width: _width / 1.7,
////                                  height: _height / 9,
//                                              alignment: Alignment.center,
//                                              decoration: BoxDecoration(color: Colors.grey[200]),
//                                              child: TextFormField(
//                                                style: TextStyle(fontSize: 40),
//                                                textAlign: TextAlign.center,
//                                                onSaved: (String val) {
//                                                  _setTime2 = val;
//                                                },
//                                                enabled: false,
//
//                                                keyboardType: TextInputType.text,
//                                                controller: _timeController2,
//                                                decoration: InputDecoration(
//                                                    disabledBorder:
//                                                    UnderlineInputBorder(borderSide: BorderSide.none),
//                                                    // labelText: 'Time',
//                                                    contentPadding: EdgeInsets.all(5)),
//                                              ),
//                                            ),
//                                          ),
////                                          TextField(
////                                            readOnly: true,
//////                                            controller: timeController,
////                                            decoration: InputDecoration(
////                                              hintText: 'Pick Time',
////                                              enabledBorder: OutlineInputBorder(
////                                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
////                                                borderSide: BorderSide(color: Colors.grey),
////                                              ),
////                                              focusedBorder: OutlineInputBorder(
////                                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
////                                                borderSide: BorderSide(color: Colors.grey),
////                                              ),
////                                            ),
////                                            onTap: () async {
////                                              var date =  await showDatePicker(
////                                                  context: context,
////                                                  initialDate:DateTime.now(),
////                                                  firstDate:DateTime(1900),
////                                                  lastDate: DateTime(2100));
//////                                              timeController.text = date.toString().substring(0,10);
////                                            },)
//                                      )
//
//                                  ),
//                                  SizedBox(width: 20.0,),
//                                ],
//                              ),


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
                                    ),
                                    SizedBox(height: 15.0,),

                                    Padding(
                                      padding: EdgeInsets.only(left:15.0,),
                                      child:   Text("Work Timings", style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w600,color: Color.fromRGBO(89, 89, 89, 1)
                                      )),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.baseline,
                                      children: [
                                        SizedBox(width: 20.0,),

                                        new Text(
                                          "From",

                                          textAlign: TextAlign.center,
                                          style:  TextStyle(fontSize: 20.0,fontWeight:FontWeight.w500,color: Color.fromRGBO(45, 87, 163, 1),),
                                        ),
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
                                        new Text(
                                          "To",

                                          textAlign: TextAlign.center,
                                          style:  TextStyle(fontSize: 20.0,fontWeight:FontWeight.w500,color: Color.fromRGBO(45, 87, 163, 1),),
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
                                        padding: EdgeInsets.only(left:15.0,),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                        child:   Text("Compliance Check List", style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w600,color: Color.fromRGBO(89, 89, 89, 1)
                                        )),
                                            ),
                                      ),
                                    ),

                                    Spacer(),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left:15.0,),
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
                                        child:   Text("Were there any incidents?", style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)
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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
                                        labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                    ),

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
                                        child:   Text("Were there any near misses?", style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)
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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
                                          labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                      ),

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
                                        child:   Text("Any reported safety violations/noncompliance?", style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)
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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
                                          labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                      ),

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
                                        child:   Text("Any cases which required first aid?", style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)
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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
                                          labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                      ),

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
                                        child:   Text("Any noted environmental incidents? (chemical/oil spill etc.)", style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)
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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
                                          labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                      ),

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
                                        child:   Text("Was the daily housekeeping done? ", style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)
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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
                                          labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                      ),

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
                                        child:   Text("All identified hazards provided by safety signs/barriers?", style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)
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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
                                          labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                      ),

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
                                        child:   Text("Work permit compliance?", style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)
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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
                                          labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                      ),

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
                                            child:Text("All oil drums/compressed gas cylinders and hazardous energy stored properly?", style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)

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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
                                          labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                      ),

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
                                            child:Text("Any major safety concerns?", style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)

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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
                                          labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                      ),

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
                                            child:Text("COVID Prevention – face mask compliance?", style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)

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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
                                          labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                      ),

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
                                            child:Text("COVID Prevention – good hand and respiratory hygiene in place?", style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)

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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
                                          labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                      ),

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
                                            child:Text("COVID Prevention – social distancing compliance?", style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)

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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
                                          labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                      ),

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
                                            child:Text("COVID Prevention – cleaning and disinfecting protocols?", style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)

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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
//                                              _AddResult.or = _character;
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
                                          labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                      ),

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
                                      ),
                                      SizedBox(height: 30.0,),

                                    ],
                                  )
                              ),

                              Container(
//                            color: Colors.blue,
                                width: 500,
                                padding: EdgeInsets.only(top: 20.0),
                                child:  new Text(
                                  'Add attachment',
                                  style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1),

                                  ),
                                ),
                              ),
                              Padding(

                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child:SizedBox(
                                        width: 200,
                                        child: ElevatedButton(

                                            style: ElevatedButton.styleFrom(
                                              primary: Color.fromRGBO(45, 87, 163, 1),
//                            onPrimary: Color.fromRGBO(32, 87, 163, 1),


                                            ),
                                            onPressed: () {
//                                   Validate returns true if the form is valid, or false
//                                   otherwise.
                                              if (_formKey.currentState.validate()) {
                                                // If the form is valid, display a Snackbar.
                                                Scaffold.of(context)
                                                    .showSnackBar(SnackBar(content: Text('Processing Data')));
                                              }
                                            },
                                            child: Container(
                                              width: 150.0,
                                              child:
                                              Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      child: Icon(Icons.file_upload),

                                                    ),
                                                    Container(
                                                        child: Text('Upload File',textAlign: TextAlign.center,style: TextStyle(fontSize: 20.0),


                                                        )
                                                    )
                                                  ]
                                              ),
                                            )
                                        ),
                                      )
                                  )

                              ),



                            ],
                          ),
                        ),
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
                                      // If the form is valid, display a Snackbar.
//                                        Navigator.push(
//                                          context,
//                                          MaterialPageRoute(builder: (context) => DailySecurityReportScrn2()),
//                                        );
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

}





