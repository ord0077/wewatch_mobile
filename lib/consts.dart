import 'package:flutter/material.dart';
import 'dart:ui';
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
const String projectKey = "projectData";

// Path to get json data
const String productJsonPath = 'assets/json/product.json';
const String orderJsonPath = 'assets/json/order.json';

// Convert money string to comma seperated
RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
Function mathFunc = (Match match) => '${match[1]},';

// base url
//const String baseURL = 'https://backend.dev-ssep.tk/api/';
// const String baseURL = 'https://wewatch.ordd.tk/api/';
const String baseURL = 'https://wewatch.dev-ord.tk/api/';


// Colors
const Color WBlue = Color(0xFF245AA6);
const Color WOrange = Color(0xFFFF8404);
const Color kBlue = Color(0xFF306EFF);
const Color kLightBlue = Color(0xFF4985FD);
const Color kDarkBlue = Color(0xFF1046B3);
const Color kWhite = Color(0xFFFFFFFF);
const Color kGrey = Color(0xFFF4F5F7);
const Color kBlack = Color(0xFF2D3243);
const Color AccidentColor = Color.fromRGBO(45,86,165, 1);
const Color CovidColor = Color.fromRGBO(244,93,82, 1);
const Color TrainingColor = Color.fromRGBO(110,76,66, 1);
const Color SiteColor = Color.fromRGBO(207,71,233, 1);
const Color ObservationColor = Color.fromRGBO(76,176,80, 1);
const Color SecurityColor = Color.fromRGBO(228,119,62, 1);
const Color HSEColor = Color.fromRGBO(74,194,182, 1);


// Padding
const double kPaddingS = 8.0;
const double kPaddingM = 16.0;
const double kPaddingL = 32.0;

// Spacing
const double kSpaceS = 8.0;
const double kSpaceM = 16.0;

// Assets
const String kGoogleLogoPath = 'assets/images/google_logo.png';