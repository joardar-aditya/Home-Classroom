import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/Exams/indi_test_container.dart';
import 'package:flutterapp/model/Exam.dart';

class exam_marks extends StatelessWidget {

  Exam _c;
  exam_marks(this._c);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Exam', style: TextStyle(color: Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body:Container(child: ListView(children:[
        indieTest(_c),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color:Colors.grey[300],
            borderRadius: BorderRadius.circular(20)
          ),
          margin: EdgeInsets.all(20),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text("Subject", style: TextStyle(color:Colors.black, fontSize: 20),),
                  ),
                  Container(
                    child: Text(_c.subject, style:  TextStyle(color:Colors.purple, fontSize: 20),),
                  ),
                  Container(
                    child: Text("Class", style: TextStyle(color:Colors.black, fontSize: 20)),
                  ),
                  Container(
                    child: Text(_c.classes.toString(), style: TextStyle(color:Colors.purple, fontSize: 20)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text("Teacher", style: TextStyle(color:Colors.black, fontSize: 20),),
                  ),
                  Container(
                    child: Text(_c.author, style:  TextStyle(color:Colors.purple, fontSize: 20),),
                  ),
                  Container(
                    child: Text("Section", style: TextStyle(color:Colors.black, fontSize: 20)),
                  ),
                  Container(
                    child: Text(_c.section.toString().toUpperCase(), style: TextStyle(color:Colors.purple, fontSize: 20)),
                  ),
                ],
              )
            ],
          )
        ),
        Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(color:Colors.grey[300], borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text("FullMarks", style: TextStyle(color:Colors.purple, fontSize: 30)),
              ),
              Container(
                child: Text(_c.FullMarks.toString().toUpperCase(), style: TextStyle(color:Colors.purple, fontSize: 30)),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(color:Colors.grey[300], borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text("Score", style: TextStyle(color:Colors.purple, fontSize: 30)),
              ),
              Container(
                child: Text("", style: TextStyle(color:Colors.purple, fontSize: 30)),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(color:Colors.grey[300], borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text("AvgMarks", style: TextStyle(color:Colors.purple, fontSize: 30)),
              ),
              Container(
                child: Text(_c.avg_marks.toString().toUpperCase(), style: TextStyle(color:Colors.purple, fontSize: 30)),
              ),
            ],
          ),
        )
      ]),),
    );
  }

}