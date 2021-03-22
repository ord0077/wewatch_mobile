import 'package:flutter/material.dart';




class AddUser extends StatefulWidget {

  const AddUser({Key key}) : super(key: key);


  @override
  _AddUser createState() => _AddUser();
}

class _AddUser extends State<AddUser> {


  final _scaffoldKey = GlobalKey<ScaffoldState>();

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

    return Scaffold(
      key: _scaffoldKey,
//      appBar:
//
//      drawer: ,

//      body:
    );
  }
}

//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:wewatchapp/CustomAppBar.dart';
//
//
//class AddUser extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    final appTitle = 'Form Validation Demo';
//
//    return MaterialApp(
//        title: appTitle,
//        home: SafeArea(
//          child: Scaffold(
//            body: MyCustomForm(),
//          ),
//        )
//    );
//  }
//}
//
//// Create a Form widget.
//class MyCustomForm extends StatefulWidget {
//  @override
//  MyCustomFormState createState() {
//    return MyCustomFormState();
//  }
//}
//
//// Create a corresponding State class.
//// This class holds data related to the form.
//class MyCustomFormState extends State<MyCustomForm> {
//  // Create a global key that uniquely identifies the Form widget
//  // and allows validation of the form.
//  //
//  // Note: This is a GlobalKey<FormState>,
//  // not a GlobalKey<MyCustomFormState>.
//  final _formKey = GlobalKey<FormState>();
//
//  @override
//  Widget build(BuildContext context) {
//    // Build a Form widget using the _formKey created above.
//    return new Scaffold(
//        appBar: CustomAppBar(   height: 250,
//
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//
//              children: [
//                Container(
//                    height: 150.0,
//                    padding: const EdgeInsets.only(left: 20.0,top: 20.0,right: 20.0,bottom: 8.0,),
//
//
//
//                    child: Column(
//                        children: [
//                          Row(
//                            children: [
//                              Container(
//                                width:50.0,
//                                child:Image(image: AssetImage('assets/images/wewatch_logo.png')),
//
//                              ),
////                            Spacer(),
//                              Container(
//
////                              height: 80,
//                                child:Image(image: AssetImage('assets/images/wewatch_logo.png')),
//
//                              )
//                            ],
//                          )
//
//
//
//                        ]
//                    )
//                ),
//                Container(
//                    height: 100.0,
//                    padding: const EdgeInsets.only(left: 20.0,top: 20.0,right: 20.0,bottom: 8.0,),
////                  color: Colors.black54,
//                    color: Color.fromRGBO(45, 87, 163, 1),
//
//
//
//
//                    child: Align(
//                        alignment: Alignment.center,
//                        child: Container(
//                          child: Text('wewatch User',
//                            style: TextStyle( fontSize: 30,color: Colors.white),),
//                        )
//
//
//                    )
//                ),
//
//              ],
//            )
//        ),
//        body: SafeArea(
//            child:  Center(
//                child: Container(
////                color: Color.fromARGB(255, 66, 165, 245),
////          margin: EdgeInsets.all(40.0),
//                  child:  Form(
//
//                    key: _formKey,
//                    child: Container(
//                      margin: EdgeInsets.all(40.0),
//
//                      child:
//                      Column(
////            crossAxisAlignment: CrossAxisAlignment.start,
//
//                        children: <Widget>[
//                          TextFormField(
//                            decoration: new InputDecoration(
////                              border: InputBorder.none,
////                              focusedBorder: InputBorder.none,
////                              enabledBorder: InputBorder.none,
////                              errorBorder: InputBorder.none,
////                              disabledBorder: InputBorder.none,
//                                contentPadding:
//                                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
//                                hintText: "User Name"),
//                            validator: (value) {
//                              if (value.isEmpty) {
//                                return 'Please enter some text';
//                              }
//                              return null;
//                            },
//                          ),
//                          TextFormField(
//                            decoration: new InputDecoration(
////                              border: InputBorder.none,
////                              focusedBorder: InputBorder.none,
////                              enabledBorder: InputBorder.none,
////                              errorBorder: InputBorder.none,
////                              disabledBorder: InputBorder.none,
//                                contentPadding:
//                                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
//                                hintText: "Email"),
//                            validator: (value) {
//                              if (value.isEmpty) {
//                                return 'Please enter some text';
//                              }
//                              return null;
//                            },
//                          ),
//                          TextFormField(
//                            decoration: new InputDecoration(
////                              border: InputBorder.none,
////                              focusedBorder: InputBorder.none,
////                              enabledBorder: InputBorder.none,
////                              errorBorder: InputBorder.none,
////                              disabledBorder: InputBorder.none,
//                                contentPadding:
//                                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
//                                hintText: "Password"),
//                            validator: (value) {
//                              if (value.isEmpty) {
//                                return 'Please enter some text';
//                              }
//                              return null;
//                            },
//                          ),
//                          TextFormField(
//                            decoration: new InputDecoration(
////                border: InputBorder.none,
////                focusedBorder: InputBorder.none,
////                enabledBorder: InputBorder.none,
////                errorBorder: InputBorder.none,
////                disabledBorder: InputBorder.none,
//                                contentPadding:
//                                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
//                                hintText: "Confirm Password"),
//                            validator: (value) {
//                              if (value.isEmpty) {
//                                return 'Please enter some text';
//                              }
//                              return null;
//                            },
//                          ),
//                          Padding(
//                            padding: const EdgeInsets.symmetric(vertical: 16.0),
//                            child: ElevatedButton(
//                                onPressed: () {
//                                  // Validate returns true if the form is valid, or false
//                                  // otherwise.
//                                  if (_formKey.currentState.validate()) {
//                                    // If the form is valid, display a Snackbar.
//                                    Scaffold.of(context)
//                                        .showSnackBar(SnackBar(content: Text('Processing Data')));
//                                  }
//                                },
//                                child: Container(
//                                  width: 200.0,
//                                  child:Text('Submit',textAlign: TextAlign.center,),
//                                )
//                            ),
//                          ),
//                        ],
//                      ),
//                      alignment: FractionalOffset(0.5, 0.5),
//
//                    ),
//                  ),
//                )
//            )
//
//        )
//
//    );
//
//
//
////       Center(
////     child:
//
////
////
////    );
//  }
//}