//Individual Report of Students
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/Student.dart';
import 'package:studieteacher/colors/colors.dart';

import 'package:http/http.dart' as http;
import 'package:studieteacher/models/reports.dart';
class indiReport extends StatefulWidget {
  Student _student;

  indiReport(this._student);
  @override
  State<StatefulWidget> createState() => _Search(_student);

}

class _Search extends State<indiReport> {

  Student _s;
  var _code;

  GlobalKey<ScaffoldState> globalKey = new GlobalKey();

  void reportGiveDeMerit(reports model) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    String cl = model.classe;
    String se = model.section;
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/merits/class/$school/$cl/$se".toLowerCase());
    var res = await http.post(uri, body: {
      "reason": model.Reason,
      "merit": "false",
      "tcode": teacher

    }, headers: {
      "x-access-token":code,
      "type": "teacher",
    });

    print(res.body);
    if(res.statusCode==200){
      var j = jsonDecode(res.body);
      if(j["status"]=="success"){
        globalKey.currentState.showSnackBar(SnackBar(content: Text(j["message"]),));
      }
    }
  }

  void reportGiveMerit(reports model) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    String cl = model.classe;
    String s = model.section;
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/merits/class/$school/$cl/$s".toLowerCase());
    print(uri.toString());
    var res = await http.post(uri, body: {
      "scode":_s.code,
      "reason": model.Reason,
      "merit": "true",
      "tcode": teacher

    }, headers: {
      "x-access-token":code,
      "type": "teacher",
    });

    print(res.body);
    if(res.statusCode==200){
      var j = jsonDecode(res.body);
      if(j["status"]=="success"){
        globalKey.currentState.showSnackBar(SnackBar(content: Text(j["message"]),));
      }
    }
  }

  _Search(this._s);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: globalKey,
      appBar:AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Add merit/ demerit', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[Container(
                  padding:EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(padding:EdgeInsets.all(5), child: Image(image: AssetImage("assets/ellipse-2.png"), height: 100, width:100)),
                  Padding(padding:EdgeInsets.all(5),child:Align(alignment:Alignment.centerLeft,child:RichText(text: TextSpan(
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                      children: [TextSpan(text: _s.Name + "\n" ),
                        TextSpan(text:'Overall Grade A+', style: TextStyle(fontWeight: FontWeight.normal, fontSize:20 ))]
                  )))),
                ],

              ),
            ),
           ]
            )
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              'Choose a specific Class', style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child:Consumer<reports>(builder:
    (context, model, child){
              return TextField(
                onChanged: (v) {
                  //model.ChangeReport(v);
                  model.AddReason(v);
                },
              maxLines: 5,
              decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 16),
                hintText: "Write a reason",
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
              ),
            );}),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Center(
                    child:
                    Consumer<reports>(builder:(context, model, child){
                      return RaisedButton(
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: Colors_pack.color,
                        onPressed: () {reportGiveMerit(model);},
                        child:Center(child:Text('Give Merit',style: TextStyle(color:Colors.white, fontSize: 28),))
                    );})
                ),
                Center(
                    child:
                    Consumer<reports>(builder: (context, model, child) {
                      return RaisedButton(
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: Colors_pack.color,
                        onPressed: () {
                          reportGiveDeMerit(model);
                        },
                        child:Center(child:Text('Give Demerit',style: TextStyle(color:Colors.white, fontSize: 28),))
                    );}
                ))

              ],
            ),
          )
        ],
      ),
    );
  }

  void GiveMerit(BuildContext context, String report) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1ODU3NDM5MDQsImRhdGEiOiJ7XCIwXCI6XCJ0ZWFjaGVyXCIsXCIxXCI6XCJhMTAxXCIsXCIyXCI6XCJhMTAxMDAxXCIsXCIzXCI6MTU4NTY1NzUwNDQ4Nn0iLCJpYXQiOjE1ODU2NTc1MDR9.GQHkKn-3W2jPWWClpiQGzS7zHBENfvqJfkjz_ZkF5No";
    String type = "teacher";
    String scode = "a1011201";
    String reason = "Test Merit";
    String merits = "true";
    String tcode = "a101001";
    String classes = "1";
    String section = "a";
    Uri uri = Uri.https("https://studie-server-dot-project-student-management.appspot.com", "/teacher/merits/a101/$classes/$section");
    print(uri.toString());
    var res = await http.post(uri, body: {
      "scode": scode,
      "reason":reason,
      "merits": merits,
      "tcode": tcode,
    }, headers: {
      "x-access-token":code,
      "type":"teacher",
    });

    Map j = json.decode(res.body.toString());
    if(j.containsKey("status")){
    if("success".compareTo(j["status"])==0){
      print("done");
      Scaffold.of(context).showSnackBar(new SnackBar(content: Text('Report submitted')));
    }}
    else{
      Scaffold.of(context).showSnackBar(new SnackBar(content: Text('Some error in connection'),));
    }

  }

  void GiveDeMerit(BuildContext context, String report) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1ODU3NDM5MDQsImRhdGEiOiJ7XCIwXCI6XCJ0ZWFjaGVyXCIsXCIxXCI6XCJhMTAxXCIsXCIyXCI6XCJhMTAxMDAxXCIsXCIzXCI6MTU4NTY1NzUwNDQ4Nn0iLCJpYXQiOjE1ODU2NTc1MDR9.GQHkKn-3W2jPWWClpiQGzS7zHBENfvqJfkjz_ZkF5No";
    String type = "teacher";
    String scode = "a1011201";
    String reason = "Test Merit";
    String merits = "true";
    String tcode = "a101001";
    String classes = "1";
    String section = "a";
    Uri uri = Uri.https("https://studie-server-dot-project-student-management.appspot.com", "/teacher/merits/a101/$classes/$section");
    print(uri.toString());
    var res = await http.post(uri, body: {
      "scode": scode,
      "reason":reason,
      "merits": merits,
      "tcode": tcode,
    }, headers: {
      "x-access-token":code,
      "type":"teacher",
    });

    Map j = json.decode(res.body.toString());
    if(j.containsKey("status")){
      if("success".compareTo(j["status"])==0){
        print("done");
        Scaffold.of(context).showSnackBar(new SnackBar(content: Text('Report submitted')));
      }}
    else{
      Scaffold.of(context).showSnackBar(new SnackBar(content: Text('Some error in connection'),));
    }

  }

}