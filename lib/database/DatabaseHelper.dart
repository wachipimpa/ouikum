import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static final _databaseName = "buffet.db";
  static final _databaseVersion = 1;

  //company start
  static final company = 'company';
  static final company_id = 'company_id';
  static final company_name = 'company_name';
  static final company_phone = 'company_phone';
  static final company_address = 'company_address';
  //company end
  //dining_table start
  static final dining_table = 'dining_table';
  static final dining_table_id = 'dining_table_id';
  static final dining_table_code = 'dining_table_code';
  static final dining_table_name = 'dining_table_name';
  static final dining_table_status = 'dining_table_status';
  static final dining_table_drop = 'dining_table_drop';
  //dining_table end

  //price category move
  static final category_price_move = 'category_price_move';
  static final category_price_move_id = 'category_price_move_id';
  static final category_price_move_name = 'category_price_move_name';
  static final category_price_move_price = 'category_price_move_price';

  //purchase move
  static final purchase_move = 'purchase_move';
  static final purchase_move_id = 'purchase_move_id';
  static final purchase_move_serial = 'purchase_move_serial';
  static final purchase_move_totalprice = 'purchase_move_totalprice';
  static final purchase_move_date = 'purchase_move_date';
  //purchase move line
  static final purchase_move_line = 'purchase_move_line';
  static final purchase_move_line_id = 'purchase_move_line_id';
  static final purchase_move_id_fk = 'purchase_move_id_fk';
  static final purchase_move_line_name = 'purchase_move_line_name';
  static final purchase_move_line_price = 'purchase_move_line_price';
  static final purchase_move_line_total_unit = 'purchase_move_line_total_unit';
  static final purchase_move_line_unit = 'purchase_move_line_unit';

  //saler move
  static final saler_move = 'saler_move';
  static final saler_move_id = 'saler_move_id';
  static final saler_move_serial = 'saler_move_serial';
  static final saler_move_totalprice = 'saler_move_totalprice';
  static final saler_move_date = 'saler_move_date';
  static final saler_move_status = 'saler_move_status';
  static final saler_move_table_id = 'saler_move_table_id';

  //saler move line
  static final saler_move_line = 'saler_move_line';
  static final saler_move_line_id = 'saler_move_line_id';
  static final saler_move_id_fk = 'saler_move_id_fk';
  static final saler_move_line_category_id = 'saler_move_line_category_id';
  static final saler_move_line_price = 'saler_move_line_category_price';
  static final saler_move_line_total = 'saler_move_line_total';
  //spend
  static final spend_move = 'spend_move';
  static final spend_move_id = 'spend_move_id';
  static final spend_move_serial = 'spend_move_serial';
  static final spend_move_price = 'spend_move_price';
  static final spend_move_date = 'spend_move_date';
  //spend
  static final spend_move_line = 'spend_move_line';
  static final spend_move_line_id = 'spend_move_line_id';
  static final spend_move_id_fk = 'spend_move_id_fk';
  static final spend_move_line_name = 'spend_move_line_name';
  static final spend_move_line_price = 'spend_move_line_price';
  static final spend_move_line_total_detail = 'spend_move_line_total_detail';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $dining_table (
            $dining_table_id INTEGER PRIMARY KEY,
            $dining_table_code TEXT NOT NULL,
            $dining_table_name TEXT NOT NULL,
            $dining_table_status INTEGER NOT NULL,
            $dining_table_drop INTEGER NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $company (
            $company_id INTEGER PRIMARY KEY,
            $company_name TEXT NOT NULL,
            $company_phone TEXT NOT NULL,
            $company_address TEXT NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $category_price_move (
            $category_price_move_id INTEGER PRIMARY KEY,
            $category_price_move_name TEXT NOT NULL,
            $category_price_move_price INTEGER NOT NULL
          )
          ''');


    await db.execute('''
          CREATE TABLE $purchase_move (
            $purchase_move_id INTEGER PRIMARY KEY,
            $purchase_move_serial TEXT NOT NULL,
            $purchase_move_totalprice REAL NOT NULL,
            $purchase_move_date DATETIME NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $purchase_move_line (
            $purchase_move_line_id INTEGER PRIMARY KEY,
            $purchase_move_id_fk INTEGER NOT NULL,
            $purchase_move_line_name TEXT NOT NULL,
            $purchase_move_line_price INTEGER NOT NULL,
            $purchase_move_line_total_unit  INTEGER NOT NULL,
            $purchase_move_line_unit TEXT NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $saler_move (
            $saler_move_id INTEGER PRIMARY KEY,
            $saler_move_serial TEXT NOT NULL,
            $saler_move_totalprice INTEGER NOT NULL,
            $saler_move_date DATETIME NOT NULL,
            $saler_move_status TEXT,
            $saler_move_table_id INTEGER
          )
          ''');

    await db.execute('''
          CREATE TABLE $saler_move_line (
            $saler_move_line_id INTEGER PRIMARY KEY,
            $saler_move_id_fk INTEGER NOT NULL,
            $saler_move_line_category_id INTEGER NOT NULL,
            $saler_move_line_price REAL,
            $saler_move_line_total INTEGER
          )
          ''');

    await db.execute('''
          CREATE TABLE $spend_move (
            $spend_move_id INTEGER PRIMARY KEY,
            $spend_move_serial TEXT NOT NULL,
            $spend_move_price REAL NOT NULL,
            $spend_move_date DATETIME NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $spend_move_line (
            $spend_move_line_id INTEGER PRIMARY KEY,
            $spend_move_id_fk INTEGER NOT NULL,
            $spend_move_line_name TEXT NOT NULL,
            $spend_move_line_price REAL NOT NULL,
            $spend_move_line_total_detail  TEXT
          )
          ''');

  }

}