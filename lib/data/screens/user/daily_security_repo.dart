import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wewatchapp/CustomAppBar.dart';
import 'dart:io';

import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';

import '../../../consts.dart';





class DailySecurityReport extends StatefulWidget {

  const DailySecurityReport({Key key}) : super(key: key);


  @override
  _DailySecurityReport createState() => _DailySecurityReport();
}

class _DailySecurityReport extends State<DailySecurityReport> {


  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String file;
  String _character ;






  @override
  void initState() {
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
    child: Text('Daily Security Report',
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
                                    labelText:"Daily Reports Elements",
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
                                    labelText:"Guard Organization",
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
                                    labelText:"Staff Numbers",
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
                                    labelText:"Daily Reported Security Incidents",
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
                                    labelText:"Visitors on Site" ,
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
                                    labelText:"Security Management Ispections Conducted",
                                    labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 30.0,), TextFormField(
                                decoration: new InputDecoration(

//                              border: InputBorder.none,
//                              focusedBorder: InputBorder.none,
//                              enabledBorder: InputBorder.none,
//                              errorBorder: InputBorder.none,
//                              disabledBorder: InputBorder.none,
                                    contentPadding:
                                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
//                    hintText: "Name / Staff ID*",
                                    labelText:"Sub-Contractor Non-Compliance Observations",
                                    labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 30.0,), TextFormField(
                                decoration: new InputDecoration(

//                              border: InputBorder.none,
//                              focusedBorder: InputBorder.none,
//                              enabledBorder: InputBorder.none,
//                              errorBorder: InputBorder.none,
//                              disabledBorder: InputBorder.none,
                                    contentPadding:
                                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
//                    hintText: "Name / Staff ID*",
                                    labelText:"Travel Security Updates",
                                    labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 30.0,), TextFormField(
                                decoration: new InputDecoration(

//                              border: InputBorder.none,
//                              focusedBorder: InputBorder.none,
//                              enabledBorder: InputBorder.none,
//                              errorBorder: InputBorder.none,
//                              disabledBorder: InputBorder.none,
                                    contentPadding:
                                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
//                    hintText: "Name / Staff ID*",
                                    labelText:"Any red flag ? ",
                                    labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 40.0,),
                              Container(
//                            color: Colors.blue,
                                width: 500,
                                padding: EdgeInsets.only(top: 20.0),
                                child:  new Text(
                                  'Please upload multiple files',
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
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child:Align(
                              child: SizedBox(
                                width: 600,
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
                                      width: 600.0,

                                      child:Text('Submit',textAlign: TextAlign.center,style: TextStyle(fontSize: 20.0)
                                      ),
                                    )
                                ),
                              ),
                            )

                        ),
                      ],
                    ),



                )
            )

        )
        )
    );
  }

}





