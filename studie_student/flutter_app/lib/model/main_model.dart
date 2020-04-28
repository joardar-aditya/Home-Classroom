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

  String current_pressed = "Summary";
  List<String>  perf_subjects = [];

  void ChangePressd(String s){
    current_pressed = s;
    _current_subject = s;
    getChapters();
    notifyListeners();
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
  List<Chapter> currentChapters = [];
  List<String> get Class_list {
    return Classes_List;
  }


  Map icons = {
    "Summary" : "assets/Group81.png",
    "math":"assets/Group84.png",
    "chem": "assets/Group63.png",
  };

  List<String> get Section_list {
    return Sections;
  }

  String get Current_Subject {
    return _current_subject;
  }

  void ChangeSubject(String s) {
    _current_subject =s;
    getChapters();
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
          subjects_list = g.map((e) => e).toList();
          _current_subject = g[0];
          g.add("Summary");
          perf_subjects = g;
          current_pressed = g[0];
          notifyListeners();}
      }
    }
    print(res.body);

  }


  void getChapters() async {
    chapters = [];
    list_of_chapters = [];
    currentChapters = [];
    notifyListeners();
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
        List<Chapter> o = [];
        List<String> str = [];
        for(int i=0;i<data.length;i++){
          String ij = data[i]["id"];
          List ch = data[i]["data"]["chapters"];
          String cl = data[i]["data"]["class"];
          String sub = data[i]["data"]["subject_code"];
          String sec = data[i]["data"]["section"];
          String ongoing =  data[i]["data"]["ongoing"].toString();
          for(int j=0; j<ch.length; j++){
            str.add(ch[j]["name"]);
            Chapter cu;
            if(ch[j]["started_on"]==null ){
              cu = Chapter(ij,ch[j]["name"],null,null, cl, sec, sub);
            }else if (ch[j]["ended_on"]==null){
              cu = Chapter(ij,ch[j]["name"],DateTime.parse(ch[j]["started_on"]),null, cl, sec, sub);
              if(ch[j]["ongoing"].toString() == "true"){
                ongoing = "true";
              }
            }else {
              cu = Chapter(
                  ij,
                  ch[j]["name"],
                  DateTime.parse(ch[j]["started_on"]),
                  DateTime.fromMillisecondsSinceEpoch(ch[j]["ended_on"]),
                  cl,
                  sec,
                  sub);
            }if(ch[j]["doubts"] != null){
              List d = ch[j]["doubts"];
              List<Doubts> dou = [];
              for(int l =0; l<d.length; l++){
                var ans = d[l]["answer"];
                if(ans == null) {
                  dou.add(
                      Doubts(null,d[l]["class"], d[l]["sec"], d[l]["sname"], DateTime.fromMillisecondsSinceEpoch(d[l]["asked"]),
                      d[l]["doubtText"]));
    }else{
                  dou.add(
                      Doubts(ans["answer"],d[l]["class"], d[l]["sec"], d[l]["sname"], DateTime.fromMillisecondsSinceEpoch(d[l]["asked"]),
                          d[l]["doubtText"]));
                }
              }
              cu.AddDoubts(dou);
            }
            if(ongoing == "true"){
              o.add(cu);
              print(o.length);
            }
            c.add(cu);
          }

        }

        list_of_chapters = c;
        chapters = str.map((e) => e).toList();
        current_chapter = str[0];
        currentChapters = o;
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