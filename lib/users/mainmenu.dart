import 'package:flutter/material.dart';
import '../main.dart';

class MainMenu extends StatefulWidget{
  @override
  _MainMenu createState()=> _MainMenu();
}
class _MainMenu extends State<MainMenu>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> MyApp()));
          },
        ),
        title: Text('ข้อมูลส่วนตัว'),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: ListTile(
                  leading: Icon(Icons.supervised_user_circle),
                  title: Text('ประวัติส่วนตัว'),
                  trailing: Icon(Icons.more_vert),
                  onTap: (){

                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.add_shopping_cart),
                  title: Text('ข้อมูลการสั่งชื้อ'),
                  trailing: Icon(Icons.more_vert),
                  onTap: (){

                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.add_business),
                  title: Text('ข้อมูลสินค้า'),
                  trailing: Icon(Icons.more_vert),
                  onTap: (){

                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.app_registration),
                  title: Text('ข้อมูลการขาย'),
                  trailing: Icon(Icons.more_vert),
                  onTap: (){

                  },
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

}