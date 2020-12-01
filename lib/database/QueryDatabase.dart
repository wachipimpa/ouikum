import 'package:sqflite/sqflite.dart';

import 'DatabaseHelper.dart';

class QueryDatabase {
    var instance = DatabaseHelper.instance;

    Future<List<Map<String, dynamic>>> get_company() async{
        Database db = await instance.database ;
        return await db.query('company');
    }
    Future<List<Map<String, dynamic>>> get_purchasemove() async{
        Database db = await instance.database ;
        return await db.rawQuery('select * from purchase_move order by purchase_move_id DESC');
    }

}