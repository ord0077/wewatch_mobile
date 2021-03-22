import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:wewatchapp/CustomAppBar.dart';


class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';

    return MaterialApp(
        title: appTitle,
        home: SafeArea(
          child: Scaffold(
            body: MyCustomForm(),
          ),
        )
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateCtl = TextEditingController();
  final List<String> items = List<String>.generate(10000, (i) => "Item $i");
  final dateController = TextEditingController();
  final dateController2 = TextEditingController();


  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return new Scaffold(
        appBar: CustomAppBar(   height: 250,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                    height: 150.0,
                    padding: const EdgeInsets.only(left: 20.0,top: 20.0,right: 20.0,bottom: 8.0,),



                    child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width:50.0,
                                child:Image(image: AssetImage('assets/images/wewatch_logo.png')),

                              ),
//                            Spacer(),
                              Container(

//                              height: 80,
                                child:Image(image: AssetImage('assets/images/wewatch_logo.png')),

                              )
                            ],
                          )



                        ]
                    )
                ),
                Container(
                    height: 100.0,
                    padding: const EdgeInsets.only(left: 20.0,top: 20.0,right: 20.0,bottom: 8.0,),
//                  color: Colors.black54,
                    color: Color.fromRGBO(45, 87, 163, 1),




                    child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Text('User List',
                            style: TextStyle( fontSize: 30,color: Colors.white),),
                        )


                    )
                ),

              ],
            )
        ),
        body: SafeArea(
            child:Container(
              padding: EdgeInsets.all(20.0),
              child: Column(

                children: [

                  new Expanded(child:
                  Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.center,

                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          new Flexible(
                              child: Container(
                                  width: 230.0,
                                  child:Center(
                                    child: Text(
                                      "Start Date",

                                      textAlign: TextAlign.center,
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
                                      "End Date",
                                      textAlign: TextAlign.center,
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
                                  child:TextField(
                                    readOnly: true,
                                    controller: dateController,
                                    decoration: InputDecoration(
                                      hintText: 'Pick your Date',
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                    onTap: () async {
                                      var date =  await showDatePicker(
                                          context: context,
                                          initialDate:DateTime.now(),
                                          firstDate:DateTime(1900),
                                          lastDate: DateTime(2100));
                                      dateController.text = date.toString().substring(0,10);
                                    },)
                              )

                          ),
                          SizedBox(width: 20.0,),
                          new Flexible(
                              child: Container(
                                  width: 230.0,
                                  child:TextField(
                                    readOnly: true,
                                    controller: dateController2,
                                    decoration: InputDecoration(
                                      hintText: 'Pick your Date',
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                    onTap: () async {
                                      var date =  await showDatePicker(
                                          context: context,
                                          initialDate:DateTime.now(),
                                          firstDate:DateTime(1900),
                                          lastDate: DateTime(2100));
                                      dateController2.text = date.toString().substring(0,10);
                                    },)
                              )

                          ),
                          SizedBox(width: 20.0,),
                        ],
                      ),
                      Container(
                        height: 600.0,
                        child: ListView(
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.insert_drive_file),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              title: Text('dates'),
                            ),
                            ListTile(
                              leading: Icon(Icons.insert_drive_file),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              title: Text('dates'),
                            ), ListTile(
                              leading: Icon(Icons.insert_drive_file),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              title: Text('dates'),
                            ), ListTile(
                              leading: Icon(Icons.insert_drive_file),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              title: Text('dates'),
                            ), ListTile(
                              leading: Icon(Icons.insert_drive_file),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              title: Text('dates'),
                            ), ListTile(
                              leading: Icon(Icons.insert_drive_file),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              title: Text('dates'),
                            ), ListTile(
                              leading: Icon(Icons.insert_drive_file),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              title: Text('dates'),
                            ), ListTile(
                              leading: Icon(Icons.insert_drive_file),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              title: Text('dates'),
                            ), ListTile(
                              leading: Icon(Icons.insert_drive_file),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              title: Text('dates'),
                            ),
                          ],
                        ),
                      )

                    ],
                  ),

                  ),


                ],
              )

            ) ,


        )

    );



//       Center(
//     child:

//
//
//    );
  }
}