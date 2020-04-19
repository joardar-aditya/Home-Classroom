
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Exam.dart';

class exam_details_model extends ChangeNotifier {

  List<Exam> upcoming = [];
  List<Exam> leftout = [];
  List<Exam> past = [];

  exam_details_model() {
    GetUpcomingExams();
    GetLeftOutExams();
    PastExams(DateTime.now().month, DateTime.now().year);
  }


  void GetUpcomingExams() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com","/teacher/exam/$school/1/1");
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
          //TODO:Teacher and Subject to be Added
          c.add(Exam(id,_ch, _dat,teacher, "maths", _cl,_sec));
        }
        upcoming = c;
        print(upcoming);
        notifyListeners();
      }
  }



  }

  void GetLeftOutExams() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    Uri uri = Uri.https(
        "studie-server-dot-project-student-management.appspot.com",
        "/teacher/exam/$school/1/1");
    var res = await http.get(uri, headers: {
      "x-access-token": code,
      "type": "teacher",
    });
    print(res.body);
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
          if (DateTime
              .parse(_dat).isBefore(today)) {
            String _ch = _current["chapters"].toString();
            String _cl = _current["class"];
            String _sec = _current["section"];
            //Teacher and Subject to be Added
            c.add(Exam(id,_ch, _dat,teacher, "maths", _cl,_sec));
          }
        }
        print(c);
        leftout = c;
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
        "/teacher/exam/a101/1/1");
    var res = await http.get(uri, headers: {
      "x-access-token": code,
      "type": "teacher",
    });
    print(res.body);
    if (res.statusCode == 200) {
      Map j = jsonDecode(res.body);
      List<Exam> c = [];
      var today = DateTime.now();
      if (j["status"] == "success") {
        List ex = j["exams"];
        for (int i = 0; i < ex.length; i++) {
          Map _current = ex[i]["data"];
          String id = ex[i]["id"];
          String _fullMa = _current["full_marks"];
          String _dat = _current["date"];
          if (DateTime
              .parse(_dat)
              .month == Month && DateTime.parse(_dat).year == Year) {
            String _ch = _current["chapters"];
            String _cl = _current["class"];
            String _sec = _current["section"];
            //Teacher and Subject to be Added
            c.add(Exam(id,_ch, _dat,teacher, "maths", _cl,_sec));
          }
        }
        print(c);
        past = c;
        notifyListeners();
      }
    }
  }}