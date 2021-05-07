import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wewatchapp/CustomAppBar.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:wewatchapp/DbControllers/controller.dart';
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
  String file ;
  Uint8List imgfile;
  Uint8List imgUint8;
  File imgfil;
  String imgString;
  String _character = "" ;
  final observertionController = TextEditingController();
  final locationController = TextEditingController();
  final req_actionController = TextEditingController();
  final AddObservation = ObservationModel();
  final picker = ImagePicker();
  bool  imagePressed = false;
  String userType = ""?? "";
  int u_id ;
  int p_id;



  _User() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    setState(() {
      userType = (userData.getString('user_type') ?? '');
      u_id = userData.getInt('user_id');
      p_id = ModalRoute.of(context).settings.arguments;

//      p_id = userData.getInt('project_id');
    });
  }

//  Future  IsInternet() async{
//    await SyncronizationData.isInternet().then((connection){
//      if(connection) {
//        print("internet connection available ");
//      } else {
//        print("no internet connection available");
//        Fluttertoast.showToast(
//            msg: "No internet connection available",
//            toastLength: Toast.LENGTH_SHORT,
//            gravity: ToastGravity.BOTTOM,
//            timeInSecForIosWeb: 1,
//            backgroundColor: Colors.black54,
//            textColor: Colors.white,
//            fontSize: 16.0
//        );
////        Scaffold.of(context).showSnackBar(SnackBar(
////          content: Text('No Internet'),
////          duration: Duration(seconds: 3),
////        ));
//      }
//    });
//  }

  List list;
  bool loading = true;

  Future userList()async{
    list = await Controller().fetchData();
    setState(() {loading=false;});
    //print(list);
  }

//  Future syncToMysql()async{
//    await SyncronizationData().fetchAllInfo().then((userList)async{
//      EasyLoading.show(status: 'Dont close app. we are sync...');
//      await SyncronizationData().saveToMysqlWith(userList);
//      EasyLoading.showSuccess('Successfully save to mysql');
//    });
//  }


  @override
  void initState() {
    _User();
    locationController.text ="Location";
    userList();
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
                                                                                Icon(Icons.image,color: Colors.white,),
                                                                                SizedBox(width: 10.0,),
                                                                                Text('Gallery', style: TextStyle(color: Colors.white),),
                                                                              ],
                                                                            ),
                                                                          ),

                                                                          onPressed: (){
                                                                            FocusScope.of(context).requestFocus(FocusNode());
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
                                      onPressed: () async {
//                                   Validate returns true if the form is valid, or false
//                                   otherwise.
                                        if (_formKey.currentState.validate() && file != null ) {
                                          showLoaderDialog(context);
                                          _Submit();
//                                  AddToSqllite();

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
        )

    );
  }

  Future <void> AddToSqllite() async {
    _onLoading();
    p_id = ModalRoute.of(context).settings.arguments;

    ObservationModel observationModel = ObservationModel( id: null, projectId: p_id, userId: u_id, observationDescription: observertionController.text,location:  locationController.text,action: req_actionController.text,attachments: imgString,);
    await Controller().addData(observationModel).then((value){
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


//    if (form.validate()) {
//      String a= _fbKey.currentState.value.toString();
//      _formResult.supporterType = a;
    SharedPreferences userData = await SharedPreferences.getInstance();
//    //Return int
//    int Value = prefs.getInt('jobId');

    AddObservation.userId = u_id;
    AddObservation.projectId = p_id;
    AddObservation.observationDescription = observertionController.text;
    AddObservation.location = locationController.text;
    AddObservation.action =req_actionController.text;

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
                              MaterialPageRoute(builder: (BuildContext context) =>  ObservationForm (),settings: RouteSettings( arguments: p_id)),
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


  Future getImageGallery() async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    File imageFile = new File(pickedFile.path);
    String fileExt = imageFile.path.split('.').last;
    List<int> videoBytes = imageFile.readAsBytesSync();
    file = base64.encode(videoBytes);
    String fi = fileExt +","+ file ;
    setState(()  {
      imagePressed = false;
      imgString = imageFile.path;
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
      imgString = imageFile.path;
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





