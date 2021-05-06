import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteDatabaseHelper {

  SqfliteDatabaseHelper.internal();
  static final SqfliteDatabaseHelper instance = new SqfliteDatabaseHelper.internal();
  factory SqfliteDatabaseHelper() => instance;

  static final observationTable = 'observationTable';
  static final trainingInductionTable = 'trainingInductionTable';
  static final accidentIncidentTable = 'accidentIncidentTable';
  static final covid19Table = 'covid19Table';
  static final dailySiteVisitorTable = 'dailySiteVisitorTable';
  static final dailySecurityTable = 'dailySecurityTable';
  static final dailyHscTable = 'dailyHscTable';





  static final _version = 1;
  final String columnId = '_id';
  static Database _db;

  Future<Database> get db async {
    if (_db !=null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb()async{
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path,'syncdatabase.db');
    print(dbPath);
    var openDb = await openDatabase(dbPath,version: _version,
        onCreate: (Database db,int version)async{
          await db.execute("""
        CREATE TABLE $observationTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          project_id INTEGER,
          user_id INTEGER NOT NULL,
          observation_description TEXT,
          location TEXT,
          action TEXT,
          attachments TEXT,
          image BLOB
          
          )""");
          await db.execute("""
        CREATE TABLE $trainingInductionTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          project_id INTEGER,
          user_id INTEGER NOT NULL,
          session_type TEXT,
          subject TEXT,
          no_attendees INTEGER,
          attachments TEXT,
          image BLOB
          
          )""");

          await db.execute("""
        CREATE TABLE $accidentIncidentTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          project_id INTEGER,
          user_id INTEGER NOT NULL,
          location TEXT,
          reported_date TEXT,
          reported_time TEXT,
          category_incident TEXT,
          type_injury TEXT,
          type_incident TEXT,
          other TEXT,
          fatality TEXT,
          describe_incident TEXT,
          immediate_action TEXT,
          attachment TEXT
          
          )""");

          await db.execute("""
        CREATE TABLE $covid19Table (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          project_id INTEGER,
          user_id INTEGER NOT NULL,
          temperature TEXT,
          staff_name TEXT,
          company TEXT,
          remarks TEXT,
          image TEXT
         
          )""");

          await db.execute("""
        CREATE TABLE $dailySiteVisitorTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          project_id INTEGER,
          user_id INTEGER NOT NULL,
          company_name TEXT,
          driver_contact TEXT,
          visit_reason TEXT,
          car_attachment TEXT,
          id_attachment TEXT
         
          )""");

          await db.execute("""
        CREATE TABLE $dailySecurityTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          project_id INTEGER,
          user_id INTEGER NOT NULL,
          daily_report_elements TEXT,
          guard_organization TEXT,
          no_staff INTEGER,
          no_incidents_daily INTEGER,
          no_visitors INTEGER,
          inspections TEXT,
          observations TEXT,
          travel_security_updates TEXT,
          red_flag TEXT,
          attachments TEXT
         
          )""");

          await db.execute("""
        CREATE TABLE $dailyHscTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          project_id INTEGER,
          user_id INTEGER NOT NULL,
          name TEXT,
          date TEXT,
          contact_no TEXT,
          weather_conditions TEXT,
          work_timings TEXT,
          workforce_size TEXT,
          subcontractors TEXT,
          progress_activity TEXT,
          session_attendees TEXT,
          attachment TEXT,
          red_flag TEXT,
          incidents TEXT,
          incidents_remarks TEXT,
          near_misses TEXT,
          near_misses_remarks TEXT,
          violations_noncompliance TEXT,
          violations_noncompliance_remarks TEXT,
          first_aid TEXT,
          first_aid_remarks TEXT,
          environment_incidents TEXT,
          environment_incidents_remarks TEXT,
          housekeeping TEXT,
          housekeeping_remarks TEXT,
          safety_signs TEXT,
          safety_signs_remarks TEXT,
          work_permit TEXT,
          work_permit_remarks TEXT,
          drums_cylinders TEXT,
          drums_cylinders_remarks TEXT,
          safety_concerns TEXT,
          safety_concerns_remarks TEXT,
          covid_face_mask TEXT,
          covid_face_mask_remarks TEXT,
          covid_respiratory_hygiene TEXT,
          covid_respiratory_hygiene_remarks TEXT,
          social_distancing TEXT,
          social_distancing_remarks TEXT,
          cleaning_disinfecting TEXT,
          cleaning_disinfecting_remarks TEXT
        
          )""");
        },
        onUpgrade: (Database db, int oldversion,int newversion)async{
          if (oldversion<newversion) {
            print("Version Upgrade");
          }
        }
    );
    print('db initialize');
    return openDb;
  }

}