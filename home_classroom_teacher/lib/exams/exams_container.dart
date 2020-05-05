

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/exams/adding_scores.dart';
import 'package:studieteacher/exams/upcoming_exam.dart';
import 'package:studieteacher/models/Exam.dart';
import 'package:studieteacher/starting.dart';


class exam_container extends StatelessWidget {
   var date;
  var name;
  var classes;
   var section;
   var subject;
   var boolean;
   Exam current;
   List<String> months = ["", "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
   List<String> weeks = ["", "MON", "TUE", "WED", "THR", "FRI", "SAT", "SUN"];

  exam_container(this.current, this.date, this.name, this.classes, this.section, this.subject, this.boolean);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DateTime dateTime = DateTime.parse(date);

    return Container(
      height:120,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20)
      ),
      margin: EdgeInsets.all(20),
      child: FittedBox(
          fit: BoxFit.contain,
          child:RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: boolean?Colors.pinkAccent:Colors_pack.color,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => upcoming_exam(current)));
      },
         child: Container(decoration:BoxDecoration(borderRadius: BorderRadius.circular(10)),child:Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisSize: MainAxisSize.min,
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Container(margin:EdgeInsets.all(5),padding:EdgeInsets.all(5),
               decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color:Colors.grey),child:
               Text(dateTime.day.toString() + " " + months[dateTime.month]+" "+weeks[dateTime.weekday]+" "+dateTime.year.toString(), style: TextStyle(color: Colors.blue[900]),),)
           ,Container(margin:EdgeInsets.all(10),child:Text('$name', style: TextStyle(color: Colors.white, fontSize: 22),)),
             Container(margin:EdgeInsets.all(10),child: Text("Class $classes Sec $section", style: TextStyle(color: Colors.grey[400]),),),
             Container(margin: EdgeInsets.all(10),child: Text("$subject", style: TextStyle(color: Colors.grey[200], fontSize: 22),),),
           ],
         ),
      ),
    )));
  }


}
