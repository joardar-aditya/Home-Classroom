import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/exams/adding_scores.dart';
import 'package:studieteacher/models/Exam.dart';


class exam_past_container extends StatelessWidget {

  Exam _current;
  exam_past_container(this._current);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DateTime current = DateTime.parse(_current.Date);
    return InkWell(
        child:Container(
      margin: EdgeInsets.all(10),
      child: FittedBox(fit
          : BoxFit.contain,child:RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => adding_scores(_current)));},
        color: Colors.pinkAccent,
        disabledColor: Colors.pinkAccent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(margin: EdgeInsets.all(10),
                child:Text(_current.Title, style: TextStyle(color: Colors.white, fontSize: 20),)),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text(current.day.toString()+ " "+ current.month.toString()+" "+current.year.toString(), style: TextStyle(color:Colors_pack.color),),),
                )
              ],
            ),//TODO:Add subject
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(margin: EdgeInsets.all(10),
                    child:Text(_current.NameTeacher, textAlign:TextAlign.left,style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)),
               Container(
                  child: Center(child: Text("Maths",textAlign: TextAlign.right, style: TextStyle(color:Colors.white, fontSize: 18,fontWeight: FontWeight.bold),),),
                )
              ],
            ),

          ],
        ),
      ),
    )));
  }
}