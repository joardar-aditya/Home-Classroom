import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studieteacher/containers/attendance_name_container.dart';
import 'package:studieteacher/data/students_a.dart';
import 'colors/colors.dart';

class attendance_g extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _attendance_g_state();


}

class _attendance_g_state extends State<attendance_g> {

  List<students_a> students = [students_a("Aditya Joardar", true),students_a("Aditya Joardar", false),students_a("Aditya Joardar", true)
  ,students_a("Aditya Joardar", false),students_a("Aditya Joardar", false),students_a("Aditya Joardar", false),students_a("Aditya Joardar", true),
    students_a("Aditya Joardar", false),students_a("Aditya Joardar", false),students_a("Aditya Joardar", false)];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance", style: TextStyle(color: Color(0xff261FFF), fontSize: 24, fontWeight: FontWeight.bold),),
        elevation: 0.0,
      ),
      body:Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              flex:2,
              child: Container(margin:EdgeInsets.symmetric(vertical: 10),child:FittedBox(fit:BoxFit.contain,child:Text('Select the students who are present', textAlign:TextAlign.center,style: TextStyle(fontSize: 22),),
            ))),
            Flexible(
              flex:16,
              child:Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(itemCount:students.length,itemBuilder: (context, i) {
                  return attendance_name_container(students[i].name_a, i+1, students[i].current_a);
                },)
                ),
              ),
            Flexible(flex:2,child:FittedBox(
              fit: BoxFit.contain,
              child:Center(child:RaisedButton(onPressed: () {},
                color: Colors_pack.color,
                child:Center(
                  child:Text('Done', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold
                  ),)
                )
              ),
            )))



          ],
        ),

    );
  }


}