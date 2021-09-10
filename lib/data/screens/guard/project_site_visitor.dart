import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wewatchapp/CustomAppBar.dart';
import 'package:wewatchapp/DbControllers/DailySiteVisitorController.dart';
import 'dart:io';

import 'package:wewatchapp/consts.dart';
import 'package:wewatchapp/data/models/projectSiteVisitorModel.dart';
import 'package:wewatchapp/data/screens/user/dashboard.dart';
import 'package:wewatchapp/data/screens/guard/guard_Drawer.dart';
import 'package:http/http.dart' as http;
import 'package:wewatchapp/data/screens/guard/guard_dashboard.dart';
import 'package:wewatchapp/data/screens/wewatchManager/wwmanager_dashboard.dart';
import 'package:wewatchapp/data/widgets/Custom_Button.dart';
import 'dart:io' as Io;

import 'package:wewatchapp/data/widgets/navDrawerWidget.dart';





class project_site_reg extends StatefulWidget {

  const project_site_reg({Key key}) : super(key: key);


  @override
  _project_site_reg createState() => _project_site_reg();
}

class _project_site_reg extends State<project_site_reg> {


  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String visitReason = 'Client';
  String file ;
  String file2;
  final picker = ImagePicker();
  final picker2 = ImagePicker();
  final AddSiteVisitor = ProjectvisitorModel();
  final companyController = TextEditingController();
  final drivercontController = TextEditingController();
  bool CarPressed = false;
  bool IDPressed = false;
  String userType = ""?? "";
  String CarimgString;
  String IDimgString;
  int u_id;
  int p_id;
  String filenameCar = '';
  String filenameID = '';
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
    list = await DailySiteVisitorController().fetchData();
    setState(() {loading=false;});
    //print(list);
  }





  @override
  void initState() {
    _User();
    userList();
    IDPressed = false;
    CarPressed = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope (
        onWillPop: () {
          return  NavigateToDashboard () ;
        },
        child:SafeArea(
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
                                    child: Text('Daily Site Visitor Form',
                                      style: TextStyle( fontSize: 25,fontWeight:FontWeight.bold,color: Colors.white),),
                                  )

                              )


                          )
                      ),
                    ],
                  )

              ),

//
//      drawer: ,

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
                                                  labelText:"Company Name",
                                                  labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Colors.grey)
                                              ),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Please enter some text';
                                                }
                                                return null;
                                              },
                                              controller: companyController,
                                            ),
                                            SizedBox(height: 20.0,),

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
                                                  labelText:"Driver Contact Number" ,
                                                  labelStyle: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Colors.grey)

                                              ),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Please enter some text';
                                                }
                                                return null;
                                              },
                                              controller: drivercontController,
                                            ),
                                            SizedBox(height: 20.0,),
                                            Padding(
                                              padding: EdgeInsets.only(left:15.0,),
                                              child:   Text("Reason For Visit", style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(89, 89, 89, 1)
                                              )),
                                            ),
                                            SizedBox(height: 10.0,),

                                            ButtonTheme(
                                              alignedDropdown: true,
                                              child: DropdownButton<String>(

                                                isExpanded: true,
                                                value: visitReason,
                                                icon: Icon(Icons.arrow_drop_down),
                                                iconSize: 24,
                                                elevation: 16,
                                                style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w400,color: Colors.grey
                                                ),
                                                underline: Container(
                                                  height: 1,
                                                  color: Colors.grey,

                                                ),
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    visitReason = newValue;
                                                  });
                                                },
                                                items: <String>['Client', 'Supplier', 'Spectator', 'Visitor']
                                                    .map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            ),

                                            SizedBox(height: 10.0,),
                                            new Container(
                                              child: file == null
                                                  ? new Text("")
                                                  : new Text("Attachment added",style: TextStyle(fontSize: 20.0,color: Colors.green,)),
                                            ),
                                            Text(filenameCar??'',style: new TextStyle(fontSize: 15.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1)) ),

                                            new Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,

                                                    children: <Widget>[


                                                      new IconButton(
                                                          icon: new Icon(Icons.camera_alt, color:(CarPressed) ? Colors.red
                                                              : DarkBlue),
//                                                highlightColor: Colors.deepOrangeAccent,

                                                          iconSize: 50.0,
                                                          onPressed:(){
                                                            FocusScope.of(context).requestFocus(FocusNode());
                                                            getCarImage();
                                                          }
                                                      ),
//
                                                    ],
                                                  ),
                                                  SizedBox(width: 20.0,),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width / 2,
//                                  padding: EdgeInsets.only(top: 20.0),
                                                    child:  new Text(
                                                      'Take Picture of car including (make model & license plate)',
                                                      style: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Colors.grey,

                                                      ),
                                                    ),
                                                  )

                                                ]
                                            ),

                                            SizedBox(height: 10.0,),
                                            new Container(
                                              child: file2 == null
                                                  ? new Text("")
                                                  : new Text("Attachment added",style: TextStyle(fontSize: 20.0,color: Colors.green,)),
                                            ),
                                            Text(filenameID??'',style: new TextStyle(fontSize: 15.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1)) ),

                                            new Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [

                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[



                                                      new IconButton(
                                                        icon: new Icon(Icons.camera_alt, color:(IDPressed) ? Colors.red
                                                            : DarkBlue),
//                                                highlightColor: Colors.deepOrangeAccent,

                                                        iconSize: 50.0,
                                                        onPressed: (){
                                                          FocusScope.of(context).requestFocus(FocusNode());

                                                          getIdImage();
                                                        },
                                                      ),
//

                                                    ],
                                                  ),
//                              new  Icon(Icons.camera_alt,color: Color.fromRGBO(45, 87, 163, 1), size: 50.0,),
                                                  SizedBox(width: 20.0,),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width / 2,
//                                  padding: EdgeInsets.only(top: 20.0),

                                                    child:  new Text(
                                                      'Take Picture of Identification',
                                                      style: TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Colors.grey,

                                                      ),
                                                    ),
                                                  )

                                                ]
                                            ),



                                          ],
                                        ),
                                      ))

                              ),
                            ),
                            Align(
                              child: SizedBox(
//                              width: 600,
                                child: BouncingButton(


                                    onPress: () {
//                                   Validate returns true if the form is valid, or false
//                                   otherwise.
                                      if (_formKey.currentState.validate() && file != null && file2 != null) {

                                        showLoaderDialog(context);
                                        _Submit();
                                      }
                                      else if (file == null && file2 != null   ){

                                        setState(()
                                        {
                                          CarPressed = true;
                                        });
                                      }
                                      else if (file2 == null && file != null  ){

                                        setState(()
                                        {
                                          IDPressed  = true;
                                        });
                                      }
                                      else if (file2 == null && file2 == null  ){

                                        setState(()
                                        {
                                          CarPressed = true;
                                          IDPressed  = true;
                                        });
                                      }
                                    },
                                    child: Container(
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
    p_id = ModalRoute.of(context).settings.arguments;

    ProjectvisitorModel projectvisitorModel = ProjectvisitorModel( id: null, projectId: p_id, userId: u_id, companyName: companyController.text ,driverContact:  drivercontController.text ,visitReason: visitReason,carAttachment: CarimgString,idAttachment: IDimgString);
    await DailySiteVisitorController().addData(projectvisitorModel).then((value){
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

    AddSiteVisitor.userId = u_id;
    AddSiteVisitor.projectId = p_id;
    AddSiteVisitor.companyName =companyController.text;
    AddSiteVisitor.driverContact = drivercontController.text;
    AddSiteVisitor.visitReason=visitReason;



//    _AddResult.name = widget.EconomicDetail.name.toString();
    form.save();
//    print(_AddResult.toMap());

//    SharedPreferences prefs = await SharedPreferences.getInstance();

    String tokenn = userData.getString('token');
//    String tokenn ='90|ZHVdsajU7doU6LusdhVwd2D0s9zqZAebfnUhInLT';
    String token = 'Bearer '+ tokenn;

    final uri = baseURL +'dailyvisitorsregister';
//    _onLoading();
    http.Response response = await http.post(
      Uri.parse(uri), headers: { 'Content-type': 'application/json',
      'Accept': 'application/json', HttpHeaders.authorizationHeader: token },body: (json.encode(AddSiteVisitor.toMap())),
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
    print(AddSiteVisitor.toMap());



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
                              MaterialPageRoute(builder: (BuildContext context) =>  project_site_reg (  ),settings: RouteSettings( arguments: p_id)),
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


  Future getCarImage() async{
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    File imageFile = new File(pickedFile.path);
    filenameCar = imageFile.path.split('/').last;
    String fileExt = imageFile.path.split('.').last;
//    String basename = basename(imageFile.path);
    List<int> videoBytes = imageFile.readAsBytesSync();
    file = base64.encode(videoBytes);
    String fi = fileExt +","+ file ;

    setState(()  {
      CarPressed = false;
      CarimgString = imageFile.path;
      AddSiteVisitor.carAttachment = fi;

    });
  }

  Future getIdImage() async{
    final pickedFile2 = await picker2.getImage(source: ImageSource.camera);
    File imageFile2 = new File(pickedFile2.path);
    filenameID = imageFile2.path.split('/').last;
    String fileExt2 = imageFile2.path.split('.').last;
//    String basename = basename(imageFile.path);
    List<int> videoBytes2 = imageFile2.readAsBytesSync();
    file2 = base64.encode(videoBytes2);
    String fi2 = fileExt2 +","+ file2 ;

    setState(()  {
      IDPressed  = false;
      IDimgString = imageFile2.path;
      AddSiteVisitor.idAttachment = fi2;

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

