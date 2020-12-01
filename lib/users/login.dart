import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ouikum/users/mainmenu.dart';
import 'package:ouikum/users/register.dart';
import '../datamodel/path_url.dart';
import 'package:flutter_session/flutter_session.dart';

class Login extends StatefulWidget{
  @override
  _Login createState()=> _Login();
}
class _Login extends State<Login>{
  var slug = 'GenAPI/checklogin_mobile';
  var url = PathUrl();

  var userlogin = TextEditingController();
  var userpwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            Center(
              child: Card(
                elevation: 8.0,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/logo.png'),
                      TextField(
                        controller: userlogin,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: "Username or Email",
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextField(
                        controller: userpwd,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: "Password",
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(30.0),
                        //elevation: 5.0,
                        child: MaterialButton(
                          onPressed: () {
                            checklogin();
                          },
                          minWidth: 150.0,
                          height: 50.0,
                          color: Colors.amber,
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              children: <Widget>[
                Expanded(child: Text("Don't Have a Account?")),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Register()));
                  },
                  child: Text("Sign Up",
                      style: TextStyle(
                        color: Colors.blue,
                      )),
                )
                
              ],
            ),
          ],
        ),
      ),
    );
  }
  checklogin() async
  {
    var token = await FlutterSession();
    final reslogin = await http.get(url.urlset + slug +'?user_login='+userlogin.text+'&user_pwd='+userpwd.text);
    final checklogin = json.decode(reslogin.body);
    if(checklogin.length != 0){
      checklogin.forEach((item){
        token.set('MemberID',item['MemberID']);
        token.set('FirstName',item['FirstName']);
        token.set('LastName',item['LastName']);
        token.set('Mobile',item['Mobile']);
      });
      Navigator.push(context, MaterialPageRoute(builder: (context)=> MainMenu()));
    }
  }
}