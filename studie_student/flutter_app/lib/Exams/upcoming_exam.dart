import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/Exams/syllabus_container.dart';
import 'package:flutterapp/model/Exam.dart';
import 'package:provider/provider.dart';

class upcoming_exam extends StatefulWidget {

  Exam _c;
  upcoming_exam(this._c);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _stateI(_c);
  }

}

class _stateI extends State<upcoming_exam>{

  Exam current;
  static List<String> _months = <String>[
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP",
    "OCT",
    "NOV",
    "DEC"
  ];

  List<String> weeks = ["MON", "TUE", "WED", "THR", "FRI", "SAT", "SUN"];

  _stateI(this.current);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Exam', style: TextStyle(color: Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.grey[300], borderRadius:BorderRadius.circular(20) ),
            child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        margin:EdgeInsets.all(10),
                        child: Text(
                          current.Title, style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 25),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(color:Colors.white, borderRadius: BorderRadius.circular(20)),
                        child: Text(current.Date.day.toString() +" "+ weeks[current.Date.weekday -1] +" "+ _months[current.Date.month-1]+" "+ current.Date.year.toString()),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child:Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Text("Subject", style: TextStyle(fontSize: 18),),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Text(current.subject, style: TextStyle(fontSize: 18, color: Colors.deepPurpleAccent),),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Text("Class", style: TextStyle(fontSize: 18),),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Text(current.classes, style: TextStyle(color:Colors.deepPurpleAccent,fontSize: 18),),
                      ),
                    ],
                  )),
                  Container(
                    margin: EdgeInsets.all(5),
                    child:Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Text("Teacher", style: TextStyle(fontSize: 18),),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Text(current.author, style: TextStyle(fontSize: 18, color: Colors.deepPurpleAccent),),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Text("Section", style: TextStyle(fontSize: 18),),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Text(current.section, style: TextStyle(fontSize: 18, color: Colors.deepPurpleAccent),),
                      ),
                    ],
                  ))
                ],
            ),
          ),
          Container(
              padding: EdgeInsets.all(10),
              margin:EdgeInsets.all(10),
              decoration:BoxDecoration(color:Colors.grey[300],borderRadius: BorderRadius.circular(20)),
              child:RichText(text: TextSpan(children: [
                TextSpan(text: "Student has ", style:TextStyle(color: Colors.pinkAccent, fontSize: 24)),
                TextSpan(text:current.Date.difference(DateTime.now()).inDays.toString(),style: TextStyle(color:Colors.deepPurpleAccent, fontSize: 24)),
                TextSpan(text: " days more to prepare for the exam", style: TextStyle(color: Colors.pinkAccent, fontSize: 24))
              ]),)),
          Container(
            margin: EdgeInsets.all(20),
            child: Text("Syllabus for the exam", style: TextStyle(fontSize: 22),),
          ),
          ListView.builder(
            shrinkWrap: true,
              itemCount: current.Chapters.length  ,
              itemBuilder: (context, item){
            return syllabus_container(current.Chapters[item]);
          })
        ],
      ),
    );
  }

}