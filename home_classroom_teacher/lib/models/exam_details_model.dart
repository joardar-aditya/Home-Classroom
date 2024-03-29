
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Exam.dart';

class exam_details_model extends ChangeNotifier {

  List<Exam> upcoming = [];
  List<Exam> leftout = [];
  List<Exam> past = [];
  String cl = "1";
  String type = "1";
  int mon = DateTime.now().month;
  int year = DateTime.now().year;
  exam_details_model() {
    GetUpcomingExams();
    PastExams(mon, year);
  }

  void ChangeClass(String c){
    cl = c;
    notifyListeners();
    GetUpcomingExams();
    PastExams(mon, year);
  }


  void GetUpcomingExams() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com","/teacher/exam/$school/$cl/1");
    var res = await  http.get(uri, headers: {
      "x-access-token":code,
      "type":"teacher",
    });
    print(res.body);
    if(res.statusCode==200) {
      Map j = jsonDecode(res.body);
      List<Exam> c =[];
      var today = DateTime.now();
      if (j["status"] == "success") {
        List ex = j["exams"];
        for(int i=0; i<ex.length; i++){
          Map _current = ex[i]["data"];
          String id= ex[i]["id"];
          String _fullMa = _current["full_marks"];
          String _dat = _current["date"];
          String _ch = _current["title"].toString();
          String _cl = _current["class"];
          String _sec = _current["section"];
          String sub = _current["sub"];
          String tea = _current["author"];
          List v = _current["chapters"];
          List<ExamChapter> e = [];
          if(today.isAtSameMomentAs(DateTime.parse(_dat)) || today.isBefore(DateTime.parse(_dat))){
          for(int j=0; j<v.length; j++){
            e.add(ExamChapter(v[j]["name"], v[j]["desc"]));
          }
          c.add(Exam(id,int.parse(_fullMa),_ch, _dat,tea, sub , _cl,_sec, e));
        }}
        Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com","/teacher/exam/$school/$cl/2");
        var res = await  http.get(uri, headers: {
          "x-access-token":code,
          "type":"teacher",
        });
        print(res.body);
        if(res.statusCode==200) {
          Map j = jsonDecode(res.body);
          var today = DateTime.now();
          if (j["status"] == "success") {
            List ex = j["exams"];
            for (int i = 0; i < ex.length; i++) {
              Map _current = ex[i]["data"];
              String id = ex[i]["id"];
              String _fullMa = _current["full_marks"];
              String _dat = _current["date"];
              String _ch = _current["title"].toString();
              String _cl = _current["class"];
              String _sec = _current["section"];
              String sub = _current["sub"];
              String tea = _current["author"];
              List v = _current["chapters"];
              List<ExamChapter> e = [];
              if (today.isAtSameMomentAs(DateTime.parse(_dat)) ||
                  today.isBefore(DateTime.parse(_dat))) {
                for (int j = 0; j < v.length; j++) {
                  e.add(ExamChapter(v[j]["name"], v[j]["desc"]));
                }
                c.add(Exam(
                    id,
                    int.parse(_fullMa),
                    _ch,
                    _dat,
                    tea,
                    sub,
                    _cl,
                    _sec,
                    e));
              }
            }
          }
        }
        upcoming = c;
        print(upcoming);
        notifyListeners();
      }
  }



  }



  void PastExams(int Month, int Year) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    Uri uri = Uri.https(
        "studie-server-dot-project-student-management.appspot.com",
        "/teacher/exam/$school/$cl/1");
    var res = await http.get(uri, headers: {
      "x-access-token": code,
      "type": "teacher",
    });
    print(res.body);
    print("PAST EXAM CALLED");
    if (res.statusCode == 200) {
      Map j = jsonDecode(res.body);
      List<Exam> c = [];
      var today = DateTime.now();
      if (j["status"] == "success") {
        List ex = j["exams"];
        for (int i = 0; i < ex.length; i++) {
          Map _current = ex[i]["data"];
          String id= ex[i]["id"];
          String _fullMa = _current["full_marks"];
          String _dat = _current["date"];
          String _ch = _current["title"].toString();
          String _cl = _current["class"];
          String _sec = _current["section"];
          String sub = _current["sub"];
          String tea = _current["author"];
          List v = _current["chapters"];
          List<ExamChapter> e = [];
          if(DateTime.parse(_dat).month == Month && DateTime.parse(_dat).year == Year){
          for(int j=0; j<v.length; j++){
            e.add(ExamChapter(v[j]["name"], v[j]["desc"]));
          }
          c.add(Exam(id,int.parse(_fullMa),_ch, _dat,tea, sub , _cl,_sec, e));
        }
        }}
        print(c);
        past = c;
        notifyListeners();
      }
    }
  }