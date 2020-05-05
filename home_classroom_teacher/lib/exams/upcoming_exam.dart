import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/Exam.dart';

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
  List<String> months = ["", "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
  List<String> weeks = ["", "MON", "TUE", "WED", "THR", "FRI", "SAT", "SUN"];
  DateTime c = DateTime.now();
  _stateI(this.current);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      c = DateTime.parse(current.Date);
    });

  }
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
                        child: Text(c.day.toString() +" "+ months[c.month]+" "+weeks[c.weekday]+" "+c.year.toString()),
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
                        child: Text(current.Subject, style: TextStyle(fontSize: 18, color: Colors.deepPurpleAccent),),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Text("Class", style: TextStyle(fontSize: 18),),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Text(current.Class, style: TextStyle(color:Colors.deepPurpleAccent,fontSize: 18),),
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
                        child: Text(current.NameTeacher, style: TextStyle(fontSize: 18, color: Colors.deepPurpleAccent),),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Text("Section", style: TextStyle(fontSize: 18),),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Text(current.Section, style: TextStyle(fontSize: 18, color: Colors.deepPurpleAccent),),
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
                TextSpan(text:(c.difference(DateTime.now()).inDays+1).toString() ,style: TextStyle(color:Colors.deepPurpleAccent, fontSize: 24)),
                TextSpan(text: " days more to prepare for the exam", style: TextStyle(color: Colors.pinkAccent, fontSize: 24))
              ]),)),
          Container(
            margin: EdgeInsets.all(20),
            child: Text("Syllabus for the exam", style: TextStyle(fontSize: 22),),
          ),
          ListView.builder(
            shrinkWrap: true,
              itemCount: current.syllabus.length,
              itemBuilder: (context, item){
            return Container(

              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children:[Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
                  child:Text(current.syllabus[item].name, style: TextStyle(fontSize: 24),)),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(current.syllabus[item].desc, style: TextStyle(fontSize: 20),),
                )
              ])
            );
          })
        ],
      ),
    );
  }

}