import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutterapp/model/Teachers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Chapter.dart';
import 'Doubts.dart';
class main_model extends ChangeNotifier {

  List<Teachers> _schoolTeachers = [];
  Teachers current_teacher ;
  String subjects;
  String current_subject;
  main_model() {
    getTeachers();
    getDetails();
    getChapters();
  }


  List<Teachers> get Teachers_list {
    return _schoolTeachers;
  }

  void ChangeT(Teachers t){
    current_teacher = t;
    notifyListeners();
  }



  void getTeachers() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    print(code);
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/student/teacher/$school");
    var res = await http.get(uri, headers: {
      "x-access-token": code,
      "type": "student"
    });
    var j = jsonDecode(res.body);
    if(res.statusCode == 200) {
      if(j["status"]=="success"){
        List s = j["data"];
        List<Teachers> te = [];
        for(int i=0; i<s.length; i++){
          te.add(Teachers(j["data"][i]["name"], j["data"][i]["code"]));
        }
       _schoolTeachers = te;
        current_teacher = _schoolTeachers[0];
        notifyListeners();
      }
    }

  }

  //NewCode Added

  List<String> subjects_list = [];
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


  void getDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    String Classes = sharedPreferences.getString("class");
    String section = sharedPreferences.getString("section");
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/student/subject/$school/$Classes/$section".toLowerCase(), {
      "code":teacher,
    });
    print(uri);
    var res =  await http.get(uri, headers: {
      "x-access-token": code,
      "type": "student"
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
          subjects_list = g;
          _current_subject = g[0];
          notifyListeners();}
      }
    }
    print(res.body);

  }


  void getChapters() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    print(code);
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    String Classes = sharedPreferences.getString("class");
    String section = sharedPreferences.getString("section");
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/student/chapters/$school/$Classes/$section".toLowerCase(),{
      "subject":_current_subject
    } );
    var res = await http.get(uri, headers: {
      "x-access-token": code,
      "type":"student"
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
                dou.add(Doubts(d[l]["class"], d[l]["sec"], d[l]["sname"], DateTime.fromMillisecondsSinceEpoch(d[l]["asked"]), d[l]["doubtText"]));
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



}