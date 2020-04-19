//Report search_dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/performance_model.dart';
import 'package:studieteacher/report/indiReport.dart';
import 'package:http/http.dart' as http;

class reportSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Search();

}

class _Search extends State<reportSearch> {

  List<String>_listofStudents = [];
  List<String>  _code_list = [];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Report', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body: Consumer<performance_model>(builder:(context, model, child){ return (model.Current.isEmpty)?Container(
          child: Center(child: Text("Wait for some time or try other string"),)):ListView.builder(itemCount:model.Current.length,itemBuilder: (context, ind) {
              return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => indiReport(model.Current[ind]) ));
                  },
                  child:Container(
                decoration: BoxDecoration(
                  color: Colors_pack.color,
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child:Text(model.Current[ind].Name, style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize: 21),),
              ));
      });}),
    );
  }

  void GetStudent(String name) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1ODU3NDM5MDQsImRhdGEiOiJ7XCIwXCI6XCJ0ZWFjaGVyXCIsXCIxXCI6XCJhMTAxXCIsXCIyXCI6XCJhMTAxMDAxXCIsXCIzXCI6MTU4NTY1NzUwNDQ4Nn0iLCJpYXQiOjE1ODU2NTc1MDR9.GQHkKn-3W2jPWWClpiQGzS7zHBENfvqJfkjz_ZkF5No";
    String type = "teacher";
    String classes = "1";
    String section = "a";
    Uri uri = Uri.https("https://studie-server-dot-project-student-management.appspot.com", "/teacher/merits/a101/$classes/$section");
    print(uri.toString());
    var res = await http.get(uri,headers:{
      "x-access-token" : code,
      "type": "teacher"
    });
    var j = json.decode(res.body.toString());
    print(j.toString());
    List l_h = j["students"];
    List<String> codes = [];
    List<String> list_of_students = [];
    for(var i = 0; i< l_h.length; i++){
      var s = json.decode(l_h[i]);
      if(s["name"] == name){
      list_of_students.add(s["name"]);
      codes.add(s["code"]);}
    }

    print(l_h.toString());

    setState(() {
      _listofStudents = list_of_students;
      _code_list = codes;
    });



  }

}