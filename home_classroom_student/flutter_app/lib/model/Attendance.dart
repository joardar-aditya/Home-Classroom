import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class attendance_model extends ChangeNotifier {
  var _totalClass = "1";
  var _attendedClass = "0";
  var _percentage= "0";
  var _classesAttended = "75";
  DateTime _startLeave = DateTime.now();
  DateTime _endLeave = DateTime.now();
  var _reason = "";
  var _currentMonth = "APR";
  var _currentYear = "2020";

  attendance_model() {
    GetAttendance();
  }


  String get ClassPerformance {
    if(_totalClass == "0"){
      return "0";
    }
    return ((int.parse(_attendedClass)/int.parse(_totalClass))*100).toString();
  }

  void ChangeReason(String s){
    _reason = s;
    notifyListeners();
  }

  void ChangeStartLeave(DateTime s){
    _startLeave = s;
    notifyListeners();
  }

  void ChangeEndLeave(DateTime s){
    _endLeave = s;
    notifyListeners();
  }

  void ChangeMonth(String ch){
    _currentMonth = ch;
    notifyListeners();
  }

  void ChangeYear(String ch){
    _currentYear = ch;
    notifyListeners();
  }


  String get currentMonth {
    return _currentMonth;
  }

  String get currentYear {
    return _currentYear;
  }

  Future<bool> GetAttendance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    print(code);
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "student/performance/$school/", {
      "scode":teacher,
    });
    var res = await http.get(uri, headers: {
      "x-access-token":code,
      "type":"student"
    });

    int totalClass = 0;
    int absentClass= 0;

    print(res.body.toString());
    var j = jsonDecode(res.body);
    if(j["status"]=="success"){
      if(j["data"]["data"]["classStats"] != null){
        if(j["data"]["data"]["absentRecord"] == null){
          absentClass = 0;
        }else{
      absentClass = j["data"]["data"]["absentRecord"].length;}
      List classes = j["data"]["data"]["classStats"];
      for(int i=0; i<classes.length; i++){
        totalClass += classes[i]["numClasses"];
      }
      _attendedClass = (totalClass - absentClass).toString();
      _totalClass = totalClass.toString();
      notifyListeners();
      return true;}else{
        return false;
      }
    }
    return false;
  }

  String get Reason {
    return _reason;
  }

  DateTime get EndLeave {
    return _endLeave;
  }

  DateTime get StartLeave {
    return _startLeave;
  }

  String get ClassAttended {
    return _classesAttended;
  }

  String get Percentage {
    if(_attendedClass == "0"||_totalClass == "0"){
      return "0";
    }else {
      return ((int.parse(_attendedClass) / int.parse(_totalClass)) * 100)
          .round()
          .toString();
    }}

  String get AttendedClass {
    return _attendedClass.toString();
  }

  String get TotalClass {
    return _totalClass;
  }


}