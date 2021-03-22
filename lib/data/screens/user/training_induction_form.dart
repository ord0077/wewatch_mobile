import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wewatchapp/CustomAppBar.dart';
import 'dart:io';

import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';

import '../../../consts.dart';





class training_induction_form extends StatefulWidget {

  const training_induction_form({Key key}) : super(key: key);


  @override
  _training_induction_form createState() => _training_induction_form();
}

class _training_induction_form extends State<training_induction_form> {


  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String file;
  String _character ;
  final picker = ImagePicker();







  @override
  void initState() {
    _character = 'safety Induction';
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
    child: Text('Training Induction Report',
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
                                padding: new EdgeInsets.only(left: 20.0,),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Session Type',
                                  style: new TextStyle(
                                      fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1)
                                  ),
                                ),
                              ),

                              new Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Row(
                                    children: [
                                      new Radio(
                                        value: 'safety Induction',
                                        groupValue: _character,
                                        activeColor: Colors.blue,

                                        onChanged:  ( value) {
                                          setState(() {
                                            _character = value;
//                                  _AddResult.or = _character;
//                                  print(_character);
                                          });
                                        },
                                      ),
                                      new Text(
                                        'Safety Induction',
                                        style: new TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1)),
                                      ),
                                    ],
                                  ),

                                  new Row(
                                    children: [
                                      new Radio(
                                        value: 'Training',
                                        groupValue: _character,
                                        activeColor: Colors.blue,

                                        onChanged:  ( value) {
                                          setState(() {
                                            _character = value;
//                                  _AddResult.or = _character;
//                                  print(_character);
                                          });
                                        },
                                      ),
                                      new Text(
                                        'Training',
                                        style: new TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1)),
                                      ),
                                    ],
                                  ),
                                  new Row(
                                    children: [
                                      new Radio(
                                        value: 'Toolbox Talk',
                                        groupValue: _character,
                                        activeColor: Colors.blue,

                                        onChanged:  ( value) {
                                          setState(() {
                                            _character = value;
//                                  _AddResult.or = _character;
//                                  print(_character);
                                          });
                                        },
                                      ),
                                      new Text(
                                        'Toolbox Talk',
                                        style: new TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color:Color.fromRGBO(113, 113, 113, 1)),
                                      ),
                                    ],
                                  ),
                                  new Row(
                                    children: [
                                      new Radio(
                                        value: 'Security Briefing',
                                        groupValue: _character,
                                        activeColor: Colors.blue,

                                        onChanged:  ( value) {
                                          setState(() {
                                            _character = value;
//                                  _AddResult.or = _character;
//                                  print(_character);
                                          });
                                        },
                                      ),
                                      new Text(
                                        'Security Briefing',
                                        style: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1)),
                                      ),
                                    ],
                                  ),



                                ],
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
                                    labelText:"Training / Toolbox Talk Subject",
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
                                    labelText:"Number of attendees" ,
                                    labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))

                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20.0,),
                              Container(
                                child: file ==null
                                    ? new Text("No attachment!",style: TextStyle(fontSize: 20.0),)
                                    : new Text("attachment added",style: TextStyle(fontSize: 20.0)),
                              ),
                              Padding(

                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child:SizedBox(
                                        width: 150,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Color.fromRGBO(45, 87, 163, 1),
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
                                              getImageGallery();
                                              //Actions
                                            }),
                                      )
                                  )

                              ),



                            ],
                          ),
                        ),
                      ),
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
//                                  submitForm();
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
                    ],
                  ),



                )
            )

        )
        )
    );
  }

  Future getImageGallery() async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    File imageFile = new File(pickedFile.path);
//    var videoFile = await ImagePicker.pickImage(source: ImageSource.camera);
    List<int> videoBytes = imageFile.readAsBytesSync();
    file = base64.encode(videoBytes);
    String fi = "jpg,"+ file ;
    print(fi);
    setState(()  {
//      _video = imageFile;
//      AddAccident.attachment = fi;

    });
  }

  Future getImageCamera() async{
    var imagefile = await ImagePicker.pickImage(source: ImageSource.camera);
    List<int> videoBytes = imagefile.readAsBytesSync();
    file = base64.encode(videoBytes);
    String fi = "jpg,"+file;

    setState(()  {
//      _video = imageFile;
//      _AddResult.attachment= fi;
    });
  }
}

