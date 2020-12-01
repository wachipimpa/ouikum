import 'package:sqflite/sqflite.dart';

import 'DatabaseHelper.dart';

class UpdateDatabase{
  var instance = DatabaseHelper.instance ;
  Future<int> update_company(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['company_id'];
    return await db.update(
        'company', row, where: 'company_id = ?', whereArgs: [id]);
  }
}