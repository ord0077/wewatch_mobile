import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wewatchapp/CustomAppBar.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:io' as Io;

import 'package:wewatchapp/data/models/observationModel.dart';
import 'package:wewatchapp/data/screens/dashboard.dart';
import 'package:wewatchapp/data/screens/guard/guard_dashboard.dart';
import 'package:wewatchapp/data/screens/wewatchManager/wwmanager_dashboard.dart';
import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';

import '../../../consts.dart';





class ObservationForm extends StatefulWidget {

  const ObservationForm({Key key}) : super(key: key);


  @override
  _ObservationForm createState() => _ObservationForm();
}

class _ObservationForm extends State<ObservationForm> {


  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String file;
  String _character ;
  final observertionController = TextEditingController();
  final locationController = TextEditingController();
  final req_actionController = TextEditingController();
  final AddObservation = ObservationModel();
  final picker = ImagePicker();
  bool  imagePressed = false;
  String userType = ""?? "";





  _User() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    setState(() {
      userType = (userData.getString('user_type') ?? '');
    });
  }



  @override
  void initState() {
    _User();
    locationController.text ="Location";

      super.initState();
  }

  @override
  void dispose() {
    observertionController.dispose();
    locationController.dispose();
    req_actionController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope (
        onWillPop: () {
      return NavigateToDashboard ();
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
    child: Text('Observation Form',
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
                          SizedBox(height: 40.0,),


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
                                labelText:"Observations's Description",
                                labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                            ),
//                                validator: (value) {
//                                  if (value.isEmpty) {
//                                    return 'Please enter some text';
//                                  }
//                                  return null;
//                                },
                            controller: observertionController,
                          ),
                          SizedBox(height: 30.0,),
                          TextFormField(

                            readOnly: true,
                            decoration: new InputDecoration(

//                              border: InputBorder.none,
//                              focusedBorder: InputBorder.none,
//                              enabledBorder: InputBorder.none,
//                              errorBorder: InputBorder.none,
//                              disabledBorder: InputBorder.none,
                                contentPadding:
                                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
//                    hintText: "Name / Staff ID*",
                                labelText:"Location to fetched from project",

                                labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                            ),
//                                validator: (value) {
//                                  if (value.isEmpty) {
//                                    return 'Please enter some text';
//                                  }
//                                  return null;
//                                },
                            controller: locationController,
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
                                labelText:"Required Action",
                                labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            controller: req_actionController,
                          ),
                          SizedBox(height: 40.0,),
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
                                  _submitForm();


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
                    ],
                  ),



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
    SharedPreferences userData = await SharedPreferences.getInstance();
//    //Return int
//    int Value = prefs.getInt('jobId');
    int u_id = userData.getInt('user_id');
    int p_id = userData.getInt('project_id');
    AddObservation.userId = u_id;
    AddObservation.projectId = p_id;
    AddObservation.observationDescription = observertionController.text;
    AddObservation.location = locationController.text;
    AddObservation.action =req_actionController.text;




//    _AddResult.name = widget.EconomicDetail.name.toString();
    form.save();
//    print(_AddResult.toMap());

//    SharedPreferences prefs = await SharedPreferences.getInstance();

    String tokenn = userData.getString('token');
//    String tokenn ='90|ZHVdsajU7doU6LusdhVwd2D0s9zqZAebfnUhInLT';
    String token = 'Bearer '+ tokenn;

    final uri = 'https://wewatch.ordd.tk/api/observation';
//    _onLoading();
    http.Response response = await http.post(
      uri, headers: { 'Content-type': 'application/json',
      'Accept': 'application/json', HttpHeaders.authorizationHeader: token },body: (json.encode(AddObservation.toMap())),
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
    print(AddObservation.toMap());



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
                              MaterialPageRoute(builder: (BuildContext context) =>  ObservationForm (),),
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
          Container(margin: EdgeInsets.only(left: 15.0),child:Text("Loading..." )),
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
      AddObservation.attachments = fi;

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
      AddObservation.attachments = fi;

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





