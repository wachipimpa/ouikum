
import 'package:sqflite/sqflite.dart';

import 'DatabaseHelper.dart';

class DeleteDatabase {
  var instance = DatabaseHelper.instance;
  Future<int> delete_purchasemoveline(int purchasemoveline_id) async
  {
    Database db = await instance.database ;
    return db.delete('purchase_move_line',where: "purchase_move_line_id = ?",whereArgs: [purchasemoveline_id]);
  }

}