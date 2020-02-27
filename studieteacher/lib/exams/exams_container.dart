import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/exams/adding_scores.dart';
import 'package:studieteacher/starting.dart';


class exam_container extends StatelessWidget {
   var date;
  var name;
  var classes;
   var section;
   var subject;
   var boolean;

  exam_container(this.date, this.name, this.classes, this.section, this.subject, this.boolean);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FittedBox(fit:BoxFit.contain,child:Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20)
      ),
      margin: EdgeInsets.all(20),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: boolean?Colors.pinkAccent:Colors_pack.color,
        onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => adding_scores()));
      },
         child: Container(decoration:BoxDecoration(borderRadius: BorderRadius.circular(10)),child:Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisSize: MainAxisSize.min,
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Container(margin:EdgeInsets.all(5),padding:EdgeInsets.all(10),decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color:Colors.grey),child: Text('$date', style: TextStyle(color: Colors.blue[900]),),)
           ,Container(margin:EdgeInsets.all(10),child:Text('$name', style: TextStyle(color: Colors.white, fontSize: 22),)),
             Container(margin:EdgeInsets.all(10),child: Text("Class $classes Sec $section", style: TextStyle(color: Colors.grey[400]),),),
             Container(margin: EdgeInsets.all(10),child: Text("$subject", style: TextStyle(color: Colors.grey[200], fontSize: 22),),),
           ],
         ),
      ),
    )));
  }


}
