import 'DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';

class InsertDatabase {
  var instance = DatabaseHelper.instance ;
  Future<int> create_company(Map<String, dynamic> row) async{
    Database db = await instance.database ;
    return await db.insert('company', row);
  }

}
