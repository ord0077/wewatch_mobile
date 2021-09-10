import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wewatchapp/CustomAppBar.dart';
import 'package:wewatchapp/DbControllers/TrainingInductionController.dart';
import 'package:wewatchapp/data/models/trainingInductionModel.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:wewatchapp/data/screens/user/dashboard.dart';
import 'package:wewatchapp/data/screens/guard/guard_dashboard.dart';
import 'package:wewatchapp/data/screens/wewatchManager/wwmanager_dashboard.dart';
import 'package:wewatchapp/data/widgets/Custom_Button.dart';

import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';

import '../../../consts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';




class training_induction_form extends StatefulWidget {

  const training_induction_form({Key key}) : super(key: key);


  @override
  _training_induction_form createState() => _training_induction_form();
}

class _training_induction_form extends State<training_induction_form> {


  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String file;
  String _character= 'safety Induction' ;
  final picker = ImagePicker();
  final filepicker = FilePicker;
  final AddTraining = TrainingInducModel();
  final trainingController = TextEditingController();
  final attendeesController = TextEditingController();
  bool  imagePressed = false;
  String userType = ""?? "";
  int p_id;
  int u_id;
  String imgString;
  String filename = '';
  FileType fileType;
  List<String> extensions;
  bool isLoadingPath = false;

  _User() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    setState(() {
      userType = (userData.getString('user_type') ?? '');
      u_id = userData.getInt('user_id');
      p_id = ModalRoute.of(context).settings.arguments;
    });
  }







  @override
  void initState() {
    _User();
    _character = 'safety Induction';
    imagePressed = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope (
        onWillPop: ()  {
          return NavigateToDashboard () ;
        },
        child:  SafeArea(
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
                                    child: Text('Training Induction Form',
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
                                                      activeColor: DarkBlue,

                                                      onChanged:  ( value) {
                                                        setState(() {
                                                          _character = value;
//                                        AddTraining.sessionType = _character;
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
//                                        AddTraining.sessionType = _character;
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
//                                        AddTraining.sessionType = _character;
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
//                                        AddTraining.sessionType = _character;
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
                                              controller: trainingController,
                                              onChanged: (value){
                                                setState(() {
                                                  AddTraining.subject = trainingController.text;

                                                });
                                              },
                                            ),
                                            SizedBox(height: 30.0,),

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
                                                  labelText:"Number of attendees" ,
                                                  labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1))

                                              ),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Please enter some text';
                                                }
                                                return null;
                                              },
                                              controller: attendeesController,
                                              onChanged: (value){
                                                setState(() {
                                                  AddTraining.noAttendees = int.parse(attendeesController.text);

                                                });
                                              },
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

                                                                        onPressed:(){
                                                                          FocusScope.of(context).requestFocus(FocusNode());
                                                                          getFile();
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
                                child: BouncingButton(

                                    onPress: () {
//                                   Validate returns true if the form is valid, or false
//                                   otherwise.
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
                                    child: Container(
//
                                    )
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

    TrainingInducModel trainingInducModel = TrainingInducModel( id: null, projectId: p_id, userId: u_id, sessionType: _character,subject: AddTraining.subject,noAttendees: AddTraining.noAttendees,attachments: imgString,);
    await TrainingInductionController().addData(trainingInducModel).then((value){
      if (value>0) {
        print("Success");
//        userList();
//        print(list.length);
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
//    int u_id = userData.getInt('user_id');
//    int p_id = userData.getInt('project_id');
    AddTraining.userId = u_id;
    AddTraining.projectId = p_id;
    AddTraining.sessionType = _character;

//    _AddResult.name = widget.EconomicDetail.name.toString();
    form.save();
//    print(_AddResult.toMap());

//    SharedPreferences prefs = await SharedPreferences.getInstance();

    String tokenn = userData.getString('token');
//    String tokenn ='90|ZHVdsajU7doU6LusdhVwd2D0s9zqZAebfnUhInLT';
    String token = 'Bearer '+ tokenn;

    final uri = baseURL +'traininginduction';
//    _onLoading();
    http.Response response = await http.post(
      Uri.parse(uri), headers: { 'Content-type': 'application/json',
      'Accept': 'application/json', HttpHeaders.authorizationHeader: token },body: (json.encode(AddTraining.toMap())),
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
    print(AddTraining.toMap());



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
                              MaterialPageRoute(builder: (BuildContext context) =>  training_induction_form (),settings: RouteSettings( arguments: p_id)),
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
          AddTraining.attachments = fi;

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
  //     AddTraining.attachments = fi;
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
      AddTraining.attachments = fi;

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

