import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class performance_model extends ChangeNotifier {
  double _hw_sub = 0;
  double _ex_pe = 0;
  double _qi_per = 0;
  double _class_per = 0;
  double _OverallPerformance = 0;
  var _type1 = "Overall";
  var _type2 = "Maths";
  Map exam_scores = {};

  performance_model() {
    GetPerformance(_type1, _type2);
  }


  void GetPerformance(String type1, String type2) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("user");
    String scode = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    var uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "student/performance/$school/", {
      "scode": scode,
    });
    print(uri);
    var res = await http.get(uri, headers: {
      "x-access-token": token,
      "type":"student"
    });
    print(res.body);
    var j = jsonDecode(res.body);
    List hw_submissions = j["data"]["data"]["homeworkSubmissions"]["submissions"];
    int total_sub = j["data"]["data"]["homeworkSubmissions"]["total"];
    _hw_sub = hw_submissions.length/total_sub*100;
    List exams = j["data"]["data"]["examScores"];
    _ex_pe = 0;
    for(int h=0; h<exams.length; h++) {
      int p = exams[h]["avgMarks"];
      int m = int.parse(exams[h]["maxMarks"]);
      _ex_pe += p/m;
    }
    _ex_pe = _ex_pe*100;
    _OverallPerformance = (_ex_pe + _hw_sub)/2;
    notifyListeners();

  }



  void Change1(String s){
    _type1 = s;
    notifyListeners();
  }

  void Change2(String s){
    _type2 = s;
    notifyListeners();
  }



  double get Hw_sub {
    return _hw_sub;
  }

  String get Type1 {
    return _type1;
  }

  String get Type2 {
    return _type2;
  }

  double get Ex_Pe {
    return _ex_pe;
  }

  double get Qi_pe {
    return _qi_per;
  }

  double get Class_pe {
    return _class_per;
  }

  double get OverallPerformance {
    return _OverallPerformance;
  }

}

