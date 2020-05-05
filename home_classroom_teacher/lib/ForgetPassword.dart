import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:studieteacher/colors/colors.dart';

class ForgetPassword extends StatelessWidget {

  final controllerIn = TextEditingController();
  final controllerPa = TextEditingController();
  final GlobalKey<ScaffoldState> globalKey  = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Reset Details', style: TextStyle(color: Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: TextField(
              controller: controllerIn,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors_pack.color)),
                hintText: "Enter institution code",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 24 ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: TextField(
              controller: controllerPa,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors_pack.color)),
                hintText: "Enter your Teacher Code",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 24 ),
              ),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(20),
                    child:RaisedButton(onPressed: () async{
                  Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/account/recover");
                  var res = await http.post(uri, body: {
                    "icode":controllerIn.text,
                    "uname": controllerPa.text,
                  }, headers: {
                    "type":"teacher"
                  });

                  print(res.body);
                  var j = jsonDecode(res.body);
                  globalKey.currentState.showSnackBar(SnackBar(content: Text(res.body)));
                },
                color: Colors_pack.color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "Send",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                ))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20)),
              child:Text("Studie will send you an email in your registered email address with your login id and temporary password.",
    style: TextStyle(color: Colors.pinkAccent, fontSize: 20, fontWeight: FontWeight.bold)),

              )

        ],
      ),
    );
  }

}