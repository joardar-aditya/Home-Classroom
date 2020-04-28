import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/Quiz/container.dart';
import 'package:flutterapp/Quiz/quizView.dart';
import 'package:flutterapp/model/Quiz.dart';
import 'package:flutterapp/model/current_q.dart';
import 'package:provider/provider.dart';

class edit_quiz extends StatefulWidget {


  Quiz _quiz;
  edit_quiz(this._quiz);
  @override
  State<StatefulWidget> createState() => _stateEdit(_quiz);

}

class _stateEdit extends State<edit_quiz> {

  Quiz _q2;
  _stateEdit(this._q2);
  List<String> sy = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List hi = _q2.Syllabus.substring(1,_q2.Syllabus.length-1).split(",");
    for(int i=0; i<hi.length; i++){
      var h = hi[i];
    sy.add("\"$h\"");}
    print(sy);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Quiz', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
        elevation: 0.0,
        actions: <Widget>[
          Container(
              margin: EdgeInsets.all(10),
              child:RaisedButton(
            child:Container(
              padding: EdgeInsets.all(2),
              child:Text('See the Rules', style: TextStyle(color:Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors_pack.color,
            onPressed: () {},
          ))
        ],
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          container_inner_quiz(_q2),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
               Consumer<current_q>(builder:(context, model, ind){return RaisedButton(
                  child:Container(
                    padding: EdgeInsets.all(10),
                    child:Text('Start', style: TextStyle(color:Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: Colors_pack.color,
                  onPressed: () {
                    model.MakeQuestions(_q2.questons);
                    model.AddId(_q2.Id);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewQuiz(_q2.Minutes,_q2.Seconds, model,_q2.Id)));
                  },
                );})
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text('Chapters Covered', style: TextStyle(color:Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap:true, itemCount:sy.length,itemBuilder: (context, ind) {
              return Container(
                decoration: BoxDecoration(
                  color:Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child:Text(sy[ind].substring(1,sy[ind].length-1), style: TextStyle(color:Colors.deepPurpleAccent, fontSize: 24, fontWeight: FontWeight.bold),),
              );
            }),
          )
        ],
      ),
    );
  }

}