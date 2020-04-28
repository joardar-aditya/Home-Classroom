import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/Student.dart';
import 'package:studieteacher/attendance.dart';
import 'package:studieteacher/containers/attendance_name_container.dart';
import 'package:studieteacher/data/students_a.dart';
import 'package:studieteacher/models/absent_students.dart';
import 'colors/colors.dart';
import 'package:http/http.dart' as http;

import 'models/main_model.dart';

class attendance_g extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _attendance_g_state(mq, Month, Year, day, Period);
  main_model mq;
  var Period = "";
  var Month = "";
  var Year ="";
  var day="";


  attendance_g(this.mq, this.Month, this.Year, this.day, this.Period);

}

class _attendance_g_state extends State<attendance_g> {

  //TODO:Implement empty view and list of students with onAdd feature.
  var Month = "";
  var Year ="";
  var day="";
  var Period = "";
  List<String> names_of_absentees = [];
  main_model m;
  _attendance_g_state(this.m, this.Month, this.Year, this.day,this.Period);

  void getPresentAttendance(main_model model) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    print(code);
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    String cl = model.Classes;
    String se = model.section;
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/attendance/class/$school/$cl/$se",{
      "subject": model.Current_Subject,
      "tcode":teacher,
      "date": "$Year$Month$day"
    });

    var res = await http.get(uri, headers: {
      "x-access-token": code,
      "type": "teacher"
    });

    print(res.body + "called first");
    List j = jsonDecode(res.body)["data"];
    List<String> _current = [];
    for(int i=0; i<j.length; i++){
      if(!_current.contains(j[i]["studentName"])){
       if(DateTime.parse(j[i]["date"]).isAtSameMomentAs(DateTime.parse("$Year$Month$day"))){
      _current.add(j[i]["studentName"]);}}
    }

    setState(() {
      names_of_absentees = _current;
    });


  }



  static List<Student> list_of_students = [];
  static List<String> absent = [];
  var _subject = "";
  var loading = true;
  var  _currentClass = "";
  var _section = "";
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingStudents(m);
    getPresentAttendance(m);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);
        names_of_absentees = [];},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Attendance', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body:loading?Container(child: Center(
        child: CircularProgressIndicator(strokeWidth: 10,),
      ),):Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(flex:2, child:Container(
              margin: EdgeInsets.all(5),
              child:Text("Students absent on the given date", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),)
            )),
            (names_of_absentees.isNotEmpty)?Flexible(flex:3, child:Container(
              height: 60,
              child:ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: names_of_absentees.length,
                itemBuilder: (context, ind){
                  return FittedBox(
                      fit: BoxFit.contain,
                      child:Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(names_of_absentees[ind], style: TextStyle(fontSize: 20, color:Colors.white),),
                  ));
                },

              )
            )):Container(
                margin: EdgeInsets.all(10),
                child:Center(child:
            Text("No Absent students recorded for the given date", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),

            )),
            Flexible(
              flex:2,
              child: Container(margin:EdgeInsets.symmetric(vertical: 10),child:FittedBox(fit:BoxFit.contain,child:
              Text('Select the students who are Absent', textAlign:TextAlign.center,style: TextStyle(fontSize: 22),),
            ))),
            Flexible(
              flex:16,
              child:loading?Container(child: Center(child: CircularProgressIndicator(strokeWidth: 10,),),):Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(itemCount:list_of_students.length,itemBuilder: (context, i) {
                  return
                      Container(child:attendance_name_container(list_of_students[i].Name, i+1,list_of_students[i].dId));
                },)
                ),
              ),
            Flexible(flex:2,child:FittedBox(
              fit: BoxFit.contain,
              child:Consumer<absent_s_model>(builder: (context, model, child){
                return Center(child:RaisedButton(onPressed: () async{
                print(model.absentee.toString());
                await MarkAbsentee(model.absentee);
                model.ClearList();
                setState(() {
                  loading = true;
                });

              },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors_pack.color,
                child:Center(
                  child:Text('Done', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold
                  ),)
                )
              ),
            );})))



          ],
        ),

    );
  }

  void gettingStudents(main_model model) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    String cl = model.Classes;
    String se = model.section;
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/attendance/$school/$cl/$se".toLowerCase() );
    print(uri.toString());
    var res = await http.get(uri, headers: {
      "x-access-token": code,
      "type":"teacher"
    });
    var res_total = jsonDecode(res.body);
    if(res.statusCode==200){
      if(res_total["status"]=="success"){
        List students = res_total["students"];
        print(res_total);
        List<Student> students_c = [];
        if(students.isEmpty){
          globalKey.currentState.showSnackBar(SnackBar(content: Text('No Students Available'),));
          Timer(Duration(seconds: 3), () {
            Navigator.pop(context);
          });
        }else{
          print(students.toString());
          for(int i=0; i<students.length; i++) {
            students_c.add(Student(students[i]["name"].toString(), students[i]["id"].toString(), students[i]["code"].toString()));
          }
          setState(() {
            loading = false;
            list_of_students = students_c;
          });
        }
      }else{
        print(res_total);
        print('Error Obtaining Students, Call Helpline for help! or LogIn Again! ');
        globalKey.currentState.showSnackBar(SnackBar(content: Text('Error Obtaining Students, Call Helpline for help!'),));
        Timer(Duration(seconds: 3), () {
          Navigator.pop(context);
        });
      }
    }else{
      print('Error Obtaining Students, CheckConnection');
      globalKey.currentState.showSnackBar(SnackBar(content: Text('Error Obtaining Students, Check your Connection!'),));
      Timer(Duration(seconds: 3), () {
        Navigator.pop(context);
      });
    }

  }

  void MarkAbsentee(List<String> absentee) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    print(code);
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    String cl = m.Classes;
    String se = m.section;
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/attendance/$school/$cl/$se".toLowerCase() );
    print(uri.toString());
    print(uri.toString());
    print("$Year$Month$day");
    print(Period);
    print(m.Current_Subject);
    print(absentee.toString());
    var res = await http.post(uri, headers: {
      "x-access-token": code,
      "type":"teacher"
    },body: {
      "absentStudents":absentee.toString(),
      "date":DateTime.parse("$Year$Month$day").toIso8601String(),
      "tcode":teacher,
      "period":Period,
      "subject":m.Current_Subject

    });
    var res_total = jsonDecode(res.body);
    print(res_total.toString());
    if(res.statusCode==200){
      if(res_total["status"]=="success"){
        globalKey.currentState.showSnackBar(SnackBar(content: Text('Student Attendance Sent for the given date!'),));
        Timer(Duration(seconds: 3), () {
          Navigator.pop(context);
        });
        }
      else{

        print('Error Obtaining Students, Call Helpline for help!');
        globalKey.currentState.showSnackBar(SnackBar(content: Text('Error in Process, Call Helpline for help!or LogIn Again!'),));

      }}
     else{
      print('Error Obtaining Students, CheckConnection');
      globalKey.currentState.showSnackBar(SnackBar(content: Text('Attendance couldn\'t be uploaded, Check your Connection!'),));

    }
  }



}