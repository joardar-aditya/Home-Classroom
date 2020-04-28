import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/main_model.dart';
import 'package:studieteacher/models/performance_model.dart';
import 'package:studieteacher/performance/pref_container.dart';
import 'package:http/http.dart' as http;
import '../Student.dart';

class performance_detail extends StatefulWidget {
  Student student;
  var cla;
  var sec;
  performance_detail(this.student,this.cla, this.sec);
  @override
  State<StatefulWidget> createState() => _state(student, cla, sec);

}

class _state extends State<performance_detail> {

  Student s;
  var cla;
  var sec;
  static List<String> options = ["Overall", "Homework", "Exam", "Quiz"];
  static List<String> icons_options = ["assets/Group26.png", "assets/Group46.png", "assets/Group4.png", "assets/Group93.png"];
  static var currentPressed = options[0];
  static var currentSubject = subjects[0];
  static List<String> subjects = ["Summary", "Mathematics", "Physics", "Chemistry"];
  static List<String> subjects_icons = ["assets/Group81.png", "assets/Group84.png", "assets/Group49.png", "assets/Group63.png"];
  _state(this.s,this.cla, this.sec);
  var _hw_sub = 0.0;
  var _ex_pe = 0.0;
  var _OverallPerformance = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPerformance(s);
  }

  void getPerformance(Student s) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("user");
    String scode = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    var uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "teacher/performance/student/$school/${cla.toString()}/${sec.toString()}", {
      "scode": s.code,
    });
    print(uri);
    var res = await http.get(uri, headers: {
      "x-access-token": token,
      "type":"teacher"
    });
    print(res.body);
    var j = jsonDecode(res.body);
    List hw_submissions = j["data"]["data"]["homeworkSubmissions"]["submissions"];
    int total_sub = j["data"]["data"]["homeworkSubmissions"]["total"];
    List exams = j["data"]["data"]["examScores"];
    _ex_pe = 0;
    for(int h=0; h<exams.length; h++) {
      int p = exams[h]["avgMarks"];
      int m = int.parse(exams[h]["maxMarks"].toString());
      _ex_pe += p/m;
    }
    setState(() {
      _hw_sub = hw_submissions.length/total_sub*100;
      _ex_pe = _ex_pe*100;
      _OverallPerformance = (_ex_pe + _hw_sub)/2;
    });




  }

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
          child:  Consumer2<performance_model, main_model>(builder: (context, model,model2, child) { return Row(
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
        Consumer2<performance_model, main_model>(builder:(context,model,model2, child){
          print(model2.PerformanceSubject.length);

          return Container(
              margin: EdgeInsets.all(20),
              height: 160,
              child:
              ListView.builder(itemCount:model2.PerformanceSubject.length,itemBuilder: (context, ind){
                bool pressed_i = false;
                if(model2.PerformanceSubject[ind] == model2.current_pressed){
                  pressed_i = true;
                }
                return InkWell(
                    onTap: () {
                      setState(() {
                        currentSubject = subjects[ind];
                        model2.CurrentPressed(model2.PerformanceSubject[ind]);
                      });

                    },
                    child:Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child:pref_container(pressed_i, model2.PerformanceSubject[ind], (model2.Icons[model2.PerformanceSubject[ind]]==null)?"assets/faltuKa.png":model2.Icons[model2.PerformanceSubject[ind]])));
              }, shrinkWrap: true, scrollDirection: Axis.horizontal, physics: ScrollPhysics(),)
          );}),
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
                    child:Text(_OverallPerformance.toString(),
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
                  Expanded(child:Text(_hw_sub.toString(), textAlign: TextAlign.right,style: TextStyle(fontSize: 24),)),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(flex:3,child:Text('Exam Performance',style: TextStyle(fontSize: 18),)),
                  Expanded(child:Text(_ex_pe.toString(), textAlign: TextAlign.right,style: TextStyle(fontSize: 24),)),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(flex:3,child:Text('Quiz Performace',style: TextStyle(fontSize: 18),)),
                  Expanded(child:Text('0%', textAlign: TextAlign.right,style: TextStyle(fontSize: 24),)),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(flex:3,child:Text('Class Performance', style: TextStyle(fontSize: 18),)),
                  Expanded(child:Text('0%', textAlign: TextAlign.right,style: TextStyle(fontSize: 24),)),

                ],
              )
            ],
          ),
        )
      ],),
    );
  }


}