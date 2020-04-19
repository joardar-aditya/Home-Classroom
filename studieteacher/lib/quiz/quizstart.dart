import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:studieteacher/basic/basics.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/quiz/add_quiz.dart';
import 'package:studieteacher/quiz/container.dart';
import 'package:studieteacher/quiz/edit_quiz.dart';
import 'package:studieteacher/quiz/question.dart';
import 'package:studieteacher/quiz/quiz.dart';
import 'package:http/http.dart' as http;
import 'package:studieteacher/quiz/results.dart';

class quizstart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateQuiz();

}

class _stateQuiz extends State<quizstart> {

  final List<String> _classes = List<String>.generate(12, (index) => (index + 1).toString()).toList();
  final List<String> _sections = ["A", "B", "C", "D", "E", "F"];
  static String _currentClass = "5";
  static String _section = "A";
  List<quiz> quizzes = [];
  
  @override
  void initState() {
    // TODO: implement initState

    loadQuizzes().then((value) {
      setState(() {
        quizzes = value;
      });

      print(value);
    });
    super.initState();


  }

  void _changeSections(String v){
    setState(() {
      _section = v;
      loadQuizzes().then((value) {
        setState(() {
          quizzes = value;
        });

        print(value);
      });
    });
  }

  void _changeClass(String valu) async{
    setState(() {
      _currentClass = valu;
      loadQuizzes().then(
          (value) {
            setState(() {
              quizzes = value;
            });

          }
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:  AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Quiz', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body:ListView(
          children: [
        Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Container(margin:EdgeInsets.all(10),child:SizedBox(width: 200, height:50, child:RaisedButton(
            onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Add_quiz()));},
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color:Colors_pack.color,
            disabledColor: Colors_pack.color,
            child: Row(
              children: <Widget>[Icon(Icons.add, color: Colors.white,size: 20,),
                Container(margin: EdgeInsets.symmetric(horizontal:5),child:
                Text('Add a Quiz', style: TextStyle(color: Colors.white, fontSize: 20),),)],
            ),
          ),
          ))]),
        Container(
          margin: EdgeInsets.all(10),
          child: Text('Ongoing Quiz', style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(64), fontWeight: FontWeight.bold),),
        ),
        StickyHeader(header:Container(
            child:Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color:Colors.white,
                  border: Border(top:BorderSide(color:Colors.white, width: 5)),
                ),
                child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,

              children: <Widget>[
                FittedBox(fit:BoxFit.contain,child:Padding(padding:EdgeInsets.all(10),child:
                Text("Class", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 24),))),

                FittedBox(fit:BoxFit.contain,child:Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:
                DropdownButton<String>(
                  value: _currentClass,
                  onChanged: (String string) => _changeClass(string),
                  underline: Container(),
                  iconSize: 0,
                  selectedItemBuilder: (BuildContext context) {
                    return _classes.map<Widget>((String item) {
                      return Container(
                          width: 80,
                          decoration: BoxDecoration(
                              color: Color(0xff261FFF),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child:Center(child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:[ Text(item, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
                      Container(margin:EdgeInsets.all(10),height:15,width: 15,decoration: BoxDecoration(color:Colors.blue[200], shape: BoxShape.circle),)])));
                    }).toList();
                  },
                  items: _classes.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item'),
                      value: item,
                    );
                  }).toList(),
                ),)) ,
                FittedBox(fit: BoxFit.contain,
                    child:
                    Padding(padding:EdgeInsets.all(10),child:
                    Text("Sec", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 24),))),
                FittedBox(fit:BoxFit.contain,child:
                Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:
                DropdownButton<String>(
                  value: _section,
                  onChanged: (String string) => _changeSections(string),
                  underline: Container(),
                  iconSize: 0,
                  selectedItemBuilder: (BuildContext context) {
                    return _sections.map<Widget>((String item) {
                      return Container(
                          width: 80,
                          decoration: BoxDecoration(
                              color: Color(0xff261FFF),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child:Center(child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:[ Text(item, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
                      Container(margin:EdgeInsets.all(10),height:15,width: 15,decoration: BoxDecoration(color:Colors.blue[200], shape: BoxShape.circle),)])));
                    }).toList();
                  },
                  items: _sections.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item'),
                      value: item,
                    );
                  }).toList(),
                ),) ),


              ],
            ))),content: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child:quizzes.isEmpty?Container(
              margin: EdgeInsets.all(50),
              child: Center(
                child:Text('No quiz available', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),)
              ),
            ):ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap:true,itemCount:quizzes.length,itemBuilder: (context, index) {
          return InkWell(onTap:() {
            Navigator.push(context,MaterialPageRoute(builder: (context) => edit_quiz(quizzes[index])) );
          },child:quiz_container(quizzes[index]));
        })),),

        ]),
    );
  }

  Future<List<quiz>> loadQuizzes() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    String school = sharedPreferences.getString("icode");
    String tcode = sharedPreferences.getString("tcode");
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com","/teacher/quiz/$school/$_currentClass/$_section".toLowerCase(),{
      "author" : tcode
    });
    print(uri.toString());
    var res = await http.get(uri,headers: {
      "x-access-token": code,
      "type": "teacher"
    } );
    Map quizzes = json.decode(res.body);
    print(quizzes);
    List list_quiz = quizzes["quiz"];
    List<quiz> new_list = [];
    for(var i =0; i< list_quiz.length; i++){
      var json = list_quiz[i]["data"];
      quiz current = quiz(json["class"], json["section"], json["title"], json["subject"], json["name"], json["total_time"], json["syllabus"].toString(), json["author_name"],
          json["total_part"], json["total_marks"]);

      List que = json["questions"];
      for(var i=0; i<que.length; i++){
        question c = question(que[i]["answers"], que[i]["correct_a"], que[i]["title"]);
        current.AddQuestion(c);
      }
      List res = json["results"];
      if(res != null){
      for(var i=0; i<res.length; i++){
        results r = results(res[i]["name"], res[i]["marks"]);
        current.AddResult(r);
      }}
      new_list.add(current);
    }
    return new_list;
  }

}