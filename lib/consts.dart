import 'package:flutter/material.dart';

/// Color used as app background
//const Color lightBackgroundColor = Color(0xFFF9F8F4);
const Color lightBackgroundColor = Color(0xFFf6f6f6);
const Color DarkBlue = Color.fromRGBO(36, 90, 166, 1);
const Color Orange = Color.fromRGBO(241, 136, 18, 1);
const Color AppBlue = Color.fromRGBO(45, 87, 163, 1);

/// This decoration is used as the custom card decoration
/// for any elevated card in the app
final cardDecoration = BoxDecoration(
  color: Colors.white,
  border: Border.all(color: Colors.black26),
  boxShadow: [
    BoxShadow(
      color: Colors.black26,
      offset: Offset(0,3),
      blurRadius: 6.0,
    ),
  ],
);


// Shared Pref key
const String userKey = "userData";


// Path to get json data
const String productJsonPath = 'assets/json/product.json';
const String orderJsonPath = 'assets/json/order.json';

// Convert money string to comma seperated
RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
Function mathFunc = (Match match) => '${match[1]},';

// base usl
//const String baseURL = 'https://api.movenpickicecream.ae/api/';
//const String baseURL = 'https://orangeroomdigital.com/mnp_dev/public/api/';
//const String baseURL = 'https://mnpbackend.ordd.tk/api/';

//const String baseURL = 'https://backend.dev-ssep.tk/api/';
const String baseURL = 'https://wewatch.ordd.tk/api/';

