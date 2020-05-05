import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutterapp/model/Syllabus_Chapter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Exam.dart';

class exam_model extends ChangeNotifier {

  static List<String> _months = <String>[
  "JAN",
  "FEB",
  "MAR",
  "APR",
  "MAY",
  "JUN",
  "JUL",
  "AUG",
  "SEP",
  "OCT",
  "NOV",
  "DEC"
  ];

  List<String> weeks = ["MON", "TUE", "WED", "THR", "FRI", "SAT", "SUN"];

  List<Exam> _upcomingexams = [];
  List<Exam> _previousexams = [];
  int _currentType = 1;
  int month = DateTime.now().month;
  int year = DateTime.now().year;

  int get Current {
    return _currentType;
  }

  void ChangeMonth(int m){
    month = m;
    notifyListeners();
  }

  void ChangeYear(int y){
    year = y;
    notifyListeners();
  }

  exam_model() {
    GetExams();
    GetPrevious(month, year);
  }
  Future<bool> GetExams() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    print(code);
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    String cl = sharedPreferences.getString("class");
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/student/exam/$school/$cl/$_currentType");
    var res = await http.get(uri,headers: {
      "x-access-token":code,
      "type":"student"
    });

    if(res.statusCode==200) {
      print(res.body);
      Map j = jsonDecode(res.body);
      List<Exam> c =[];
      if (j["status"] == "success") {
             List ex = j["exams"];
             for(int i=0; i<ex.length; i++){
               Map _current = ex[i]["data"];
               String _fullMa = _current["full_marks"];
               String avgMarks = _current["avgMarks"].toString();
               String maxMar = _current["maxMarks"].toString();
               List students = _current["student_list"];
               String ob_ma = "";
               for(int l=0; l<students.length; l++) {
                 if(students[l]["scode"]==teacher){
                   ob_ma = students[l]["marks_obtained"].toString();
                 }
               }
               String _newDate = "NA";
               if(_current["date"]!=null){
                 DateTime _dat = DateTime.parse(_current["date"]);
                 _newDate = _current["date"];
                 if(_dat.isAfter(DateTime.now())){

                   List _ch = _current["chapters"];
                   List<Sy_Ch> lk = [];
                   for(int p=0; p<_ch.length;p++){
                     lk.add(Sy_Ch(_ch[p]["name"], _ch[p]["desc"]));
                   }
                   c.add(Exam(_newDate,ob_ma,maxMar, _fullMa,avgMarks, lk, _current["section"].toString(), _current["class"].toString(), _current["author"].toString(), _current["sub"].toString()));
                 }
               }else{
                 continue;
               }


             }
             _upcomingexams = c;
             print(_upcomingexams.toString());
             notifyListeners();
             return true;
      }
      return false;
    }
    return false;
  }

  Future<bool> GetPrevious(int month, int year) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    print(code);
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    String clas = sharedPreferences.getString("class");

    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/student/exam/$school/$clas/$_currentType");
    var res = await http.get(uri,headers: {
      "x-access-token":code,
      "type":"student"
    });

    if(res.statusCode==200) {
      print(res.body);
      Map j = jsonDecode(res.body);
      List<Exam> c =[];
      if (j["status"] == "success") {
        List ex = j["exams"];
        for(int i=0; i<ex.length; i++){
          Map _current = ex[i]["data"];
          String _fullMa = _current["full_marks"];
          String avg_marks = _current["avgMarks"].toString();
          String max_marks = _current["maxMarks"].toString();
          String _newDate = "NA";
          String ob_ma = "NA";
          List students = _current["student_list"];
          for(int l=0; l<students.length; l++) {
            if(students[l]["scode"]==teacher.toString()){
              ob_ma = students[l]["marks_obtained"].toString();
            }
          }
          if(_current["date"]!=null){
            DateTime _dat = DateTime.parse(_current["date"]);
            _newDate = _current["date"];
            if(_dat.isBefore(DateTime.now()) && (_dat.month == month && _dat.year == year)){

              List _ch = _current["chapters"];
              List<Sy_Ch> lk = [];
              for(int p=0; p<_ch.length;p++){
                lk.add(Sy_Ch(_ch[p]["name"], _ch[p]["desc"]));
              }
              c.add(Exam(_newDate,ob_ma,max_marks, _fullMa,avg_marks, lk, _current["section"].toString(), _current["class"].toString(), _current["author"].toString(), _current["sub"].toString()));
            }
          }else{
            continue;
          }


        }
        _previousexams = c;
        print(_previousexams.toString());
        notifyListeners();
        return true;
      }
      return false;
    }
    return false;
  }

  void ChangeCat(int p){
    _currentType = p;
    notifyListeners();
  }

  List<Exam> get UpcomingExams {
    return _upcomingexams;
  }

  List<Exam> get PreviousExams{
    return _previousexams;
  }
}