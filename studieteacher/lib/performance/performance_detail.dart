import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/performance_model.dart';
import 'package:studieteacher/performance/pref_container.dart';

import '../Student.dart';

class performance_detail extends StatefulWidget {
  Student student;
  performance_detail(this.student);
  @override
  State<StatefulWidget> createState() => _state(student);

}

class _state extends State<performance_detail> {

  Student s;
  static List<String> options = ["Overall", "Homework", "Exam", "Quiz"];
  static List<String> icons_options = ["assets/Group26.png", "assets/Group46.png", "assets/Group4.png", "assets/Group93.png"];
  static var currentPressed = options[0];
  static var currentSubject = subjects[0];
  static List<String> subjects = ["Summary", "Mathematics", "Physics", "Chemistry"];
  static List<String> subjects_icons = ["assets/Group81.png", "assets/Group84.png", "assets/Group49.png", "assets/Group63.png"];
  _state(this.s);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('View Performance', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body: ListView(children: <Widget>[
        Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(color:Colors.grey[300],
            borderRadius: BorderRadius.circular(10)),
          child:  Consumer<performance_model>(builder: (context, model, child) { return Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors_pack.color, shape: BoxShape.circle),
                height: 100,
                width: 100,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(s.Name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  Text("Class " + model.classe +  " Sec " + model.section, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700]),),
                  Text("Overall Grade A+", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700]),)
                ],
              )
            ],
          );}),
        ),
        Container(
            margin: EdgeInsets.all(20),
            height: 160,
            child:
            ListView.builder(itemCount:4,itemBuilder: (context, ind){
              bool pressed = false;
              if(options[ind].compareTo(currentPressed) == 0){
                pressed = true;
              }
              return InkWell(
                  onTap: () {
                    setState(() {
                      currentPressed = options[ind];
                    });

                  },
                  child:Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child:pref_container(pressed, options[ind],icons_options[ind])));
            }, shrinkWrap: true, scrollDirection: Axis.horizontal, physics: ScrollPhysics(),)
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Text('Subject', style: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),),
        ),
        Container(
            margin: EdgeInsets.all(20),
            height: 160,
            child:
            ListView.builder(itemCount:4,itemBuilder: (context, ind){
              bool pressed_i = false;
              if(subjects[ind].compareTo(currentSubject) == 0){
                pressed_i = true;
              }
              return InkWell(
                  onTap: () {
                    setState(() {
                      currentSubject = subjects[ind];
                    });

                  },
                  child:Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child:pref_container(pressed_i, subjects[ind],subjects_icons[ind])));
            }, shrinkWrap: true, scrollDirection: Axis.horizontal, physics: ScrollPhysics(),)
        ),
        Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(20),
            child:Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                    child:Text(
                      'Overall\nPerformance',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:Colors_pack.color,
                        fontSize: 28,
                      ),
                    )
                ),
                Expanded(
                    child:Text('60%',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:Colors_pack.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 56,
                      ),
                    )
                )
              ],
            )
        ),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color:Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(flex:3,child:Text('Homework Submission',style: TextStyle(fontSize: 18),)),
                  Expanded(child:Text('40%', textAlign: TextAlign.right,style: TextStyle(fontSize: 24),)),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(flex:3,child:Text('Homework Submission',style: TextStyle(fontSize: 18),)),
                  Expanded(child:Text('40%', textAlign: TextAlign.right,style: TextStyle(fontSize: 24),)),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(flex:3,child:Text('Homework Submission',style: TextStyle(fontSize: 18),)),
                  Expanded(child:Text('40%', textAlign: TextAlign.right,style: TextStyle(fontSize: 24),)),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(flex:3,child:Text('Homework Submission', style: TextStyle(fontSize: 18),)),
                  Expanded(child:Text('40%', textAlign: TextAlign.right,style: TextStyle(fontSize: 24),)),

                ],
              )
            ],
          ),
        )
      ],),
    );
  }


}