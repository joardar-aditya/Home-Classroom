import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:studieteacher/chapters/Chapter.dart';

import 'Doubts.dart';
class main_model extends ChangeNotifier {
  var Name = "NA";
  var Classes = "5";
  var section= "A";
  String teacher ;
  List<String> teachers = [];
  List<String> subjects = [];
  String _current_subject ;
  static var Classes_List = List<String>.generate(12, (index) => (index + 1).toString()).toList();
  static final List<String> Sections = ["A", "B", "C", "D", "E", "F", ];
  List<Chapter> list_of_chapters = [];
  List<String> chapters = [];
  String current_chapter;
  List<String> get Class_list {
    return Classes_List;
  }

  List<String> get Section_list {
    return Sections;
  }

  String get Current_Subject {
    return _current_subject;
  }

  void ChangeSubject(String s) {
    _current_subject =s;
    notifyListeners();
  }

  main_model(){
    getDetails();
    getChapters();
    getTeachers();

}


void ChangeTeacher(String s){
    teacher = s;
    notifyListeners();
}



void getTeachers() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String code = sharedPreferences.getString("user");
  String teacher = sharedPreferences.getString("tcode");
  String school = sharedPreferences.getString("icode");
  Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "teacher/teacher/$school");
  var res = await http.get(uri, headers: {
    "x-access-token": code,
    "type": "teacher"
  });
  var j = jsonDecode(res.body);
  List t = j["data"];
  List<String> tea = [];
  for(int i=0; i<t.length;i++){
    tea.add(t[i]["name"]);

  }
  teachers = tea;
  teacher = teachers[0];
  notifyListeners();

}

void getDetails() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String code = sharedPreferences.getString("user");
  String teacher = sharedPreferences.getString("tcode");
  String school = sharedPreferences.getString("icode");
  Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/subject/$school/$Classes/$section".toLowerCase(), {
    "code":teacher,
  });
  print(uri);
  var res =  await http.get(uri, headers: {
    "x-access-token": code,
    "type": "teacher"
  });
  if(res.statusCode == 200){
        var j = jsonDecode(res.body);
        print(res.body);
        if(j["status"]=="success"){
          print(res.body);
          List sub = j["data"];
          List<String> g = [];
          for(int i=0; i<sub.length; i++){
            g.add(j["data"][i].toString());
          }
          if(g.isNotEmpty){
          subjects = g;
          _current_subject = subjects[0];
          notifyListeners();}
        }
  }
  print(res.body);

}


void getChapters() async {
    chapters = [];
    list_of_chapters = [];
    notifyListeners();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String code = sharedPreferences.getString("user");
  print(code);
  String teacher = sharedPreferences.getString("tcode");
  String school = sharedPreferences.getString("icode");
  Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/chapters/$school/$Classes/$section".toLowerCase(),{
    "subject":_current_subject
  } );
  var res = await http.get(uri, headers: {
    "x-access-token": code,
    "type":"teacher"
  });

  print(res.body);
  var j = jsonDecode(res.body.toString());
  if(res.statusCode==200){
    if(j["status"]=="success"){
      List data = j["data"];
      List<Chapter> c=[];
      List<String> str = [];
      for(int i=0;i<data.length;i++){
        String ij = data[i]["id"];
        List ch = data[i]["data"]["chapters"];
        String cl = data[i]["data"]["class"];
        String sub = data[i]["data"]["subject_code"];
        String sec = data[i]["data"]["section"];
        for(int j=0; j<ch.length; j++){
          str.add(ch[j]["name"]);
          Chapter cu = Chapter(ij,ch[j]["name"],ch[j]["started_on"],ch[j]["ended_on"], cl, sec, sub);
          if(ch[j]["doubts"] != null){
            List d = ch[j]["doubts"];
            List<Doubts> dou = [];
            for(int l =0; l<d.length; l++){
              dou.add(Doubts(d[l]["class"], d[l]["sec"], d[l]["sname"], DateTime.fromMillisecondsSinceEpoch(d[l]["asked"]), d[l]["doubtText"],ch[j]["name"],ij,d[l]["scode"]));
            }
            cu.AddDoubts(dou);
          }
          c.add(cu);
        }

      }

      list_of_chapters = c;
      chapters = str;
      current_chapter = str[0];
      notifyListeners();

    }else{
      print("Problem!");
    }
  }
}

void ChangeChapter(String w){
    current_chapter = w;
    notifyListeners();
}

void ChangeClasses(String c){
    Classes =c;
    notifyListeners();
}

void ChangeSec(String sec){
    section = sec;
    notifyListeners();
}
}