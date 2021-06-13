import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wewatchapp/consts.dart';
import 'package:wewatchapp/data/models/loginModel.dart';


/// This class is responsible for hendling the network request related to login
class LoginRepository {
//  project: List<Project>.from(json["project"].map((x) => Project.fromJson(x))),
//  "project": List<dynamic>.from(project.map((x) => x.toJson())),

  /// The function takes email and password as parameters and than recives a
  /// Customer object if the credentials are valid else throws exceptions
  Future<LoginModel> login(String email, String password) async {

    String url = baseURL + 'login';

    Map<String, String> headers = {"Content-type": "application/json"};

    String body = '{"email": "${email.toLowerCase()}", "password": "$password", "device_type" : "mobile"}';

    print(body);

    Response response = await post(Uri.parse(url), headers: headers, body: body);

    print(response.body);

    if (response.statusCode == 200){
      return LoginModel.fromJson(json.decode(response.body));

    } else if (response.statusCode == 422) {
//      SharedPreferences prefs = await SharedPreferences.getInstance();

      throw json.decode(response.body)['error'];
    }

    else if (response.statusCode == 500) {
//      SharedPreferences prefs = await SharedPreferences.getInstance();

      throw "email or password is incorrect";
    }
    else {
      throw "Someting went wrong please try again!";
    }

  }
}