import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/Homework/hw_check_detail.dart';
import 'package:studieteacher/basic/basics.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:http/http.dart' as http;
import 'container_check.dart';
import 'hw.dart';

class homework_details extends StatefulWidget {
  hw Hw;
  homework_details(this.Hw);
  @override
  State<StatefulWidget> createState() => _detail_hw_state(Hw);


}




class _detail_hw_state extends State<homework_details>{
  hw _Hw;
  _detail_hw_state(this._Hw);
  int current_submissions = 0;
  List<String> months = ["", "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
  List<String> weeks = ["", "MON", "TUE", "WED", "THR", "FRI", "SAT", "SUN"];



  void check_submissions() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    String classe = _Hw.Classe;
    String section = _Hw.Section;
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com","/teacher/homework/submissions/$school/$classe/$section",{
      "id": _Hw.Id
    });
    var res = await http.get(uri, headers: {
      "x-access-token": code,
      "type": "teacher"
    });

    print(res.body);
    var j = jsonDecode(res.body);
    if(j["status"]=="success"){
      List v = j["data"]["submissions"];
      setState(() {

        current_submissions = v.length;
      });
      List<String> s = [];
      for(int i=0; i<v.length; i++){
        s.add(v[i]["id"]);
      }
      _Hw.AddSubmissions(s);

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_submissions();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:  AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Homework', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body:ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child:  Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child:Text('Submision Date', style: TextStyle(fontSize: 22),)
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  
                  child: Center(
                    child: Text(_Hw.due_date.day.toString() + " " + months[_Hw.due_date.month] + " " + weeks[_Hw.due_date.weekday] + " " +  _Hw.due_date.year.toString(), style: TextStyle(color: Colors.blue, fontSize: 18),),
                  ),
                )
              ],
            ),
          ),
    Container(margin:EdgeInsets.all(10),child:container_check(_Hw)),
          Container(margin:EdgeInsets.all(10),child:
          Text('Solve the given problems', style: TextStyle(color: Colors_pack.color, fontSize: 24),)),
          Container(margin:EdgeInsets.all(10),child:
          Text(_Hw.description, style: TextStyle(color: Colors.black, fontSize: 22),)),
          Container(margin:EdgeInsets.all(10),child:
          Text('Attached File', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 24),)),
          Container(margin:EdgeInsets.all(10),
           child: RaisedButton(
             color: Colors_pack.color,
             onPressed: () {},
             child:Text('1026.pdf',textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
           ),
          ),
          Container(margin:EdgeInsets.all(10),
            child: Center(child:Text("Submitted by "+ current_submissions.toString()  +" students", style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold, fontSize: 24),)),
          ),
          Column(crossAxisAlignment:CrossAxisAlignment.center,children:[
            Container(
                margin: EdgeInsets.all(10),
                width: 200,
                child:RaisedButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => hw_check_detail(_Hw)));},
                    color: Colors.pinkAccent,
                    disabledColor: Colors.grey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child:Padding(padding:EdgeInsets.all(10),child:Text('Check', textAlign: TextAlign.center, style: TextStyle(fontSize:22,fontWeight:FontWeight.bold, color:Colors.white
                    )))))])


        ],
      ),
    );
  }

}