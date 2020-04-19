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

  int get Current {
    return _currentType;
  }

  exam_model() {
    GetExams();
    GetPrevious();
  }
  Future<bool> GetExams() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    print(code);
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");

    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/student/exam/$school/1/$_currentType");
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
                   c.add(Exam(_newDate, _fullMa, lk, _current["section"].toString(), _current["class"].toString(), _current["author"].toString(), _current["sub"].toString()));
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

  Future<bool> GetPrevious() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    print(code);
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");

    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/student/exam/$school/1/$_currentType");
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
          String _newDate = "NA";
          if(_current["date"]!=null){
            DateTime _dat = DateTime.parse(_current["date"]);
            _newDate = _dat.day.toString() +" "+ weeks[_dat.weekday -1] +" "+ _months[_dat.month-1]+" "+ _dat.year.toString();
            if(_dat.isBefore(DateTime.now())){

              List _ch = jsonDecode(_current["chapters"]);
              List<Sy_Ch> lk = [];
              for(int p=0; p<_ch.length;p++){
                lk.add(Sy_Ch(_ch[p]["name"], _ch[p]["desc"]));
              }
              c.add(Exam(_newDate, _fullMa, lk, _current["section"].toString(), _current["class"].toString(), _current["author"].toString(), _current["sub"].toString()));
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