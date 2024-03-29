import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Student.dart';
class performance_model extends ChangeNotifier {
  var hw_perf = "0";
  var e_p = "0";
  var q_p = "0";
  var cl_p = "0";
  var classe = "5";
  var section = "a";
  var subject = "all";
  List<Student> current = [];

  void ChangeClass(String c){
    classe = c;
    getPerformance();

    notifyListeners();
  }

  void ChangeSection(String s){
    getPerformance();
    section = s;
    notifyListeners();
  }
  performance_model(){
    getPerformance();
  }

  void getStudents(String p, String cl, String se) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    String cla = classe;
    String sec = section;
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/attendance/$school/$cl/$se".toLowerCase() );
    print(uri.toString());
    var res = await http.get(uri, headers: {
      "x-access-token": code,
      "type":"teacher"
    });
    var res_total = jsonDecode(res.body);
    if(res.statusCode==200){
      if(res_total["status"]=="success"){
        List stud = res_total["students"];
        print(res_total);
        List<Student> students_c = [];
        if(stud.isEmpty){
        }else{
          print(stud.toString());
          for(int i=0; i<stud.length; i++) {
            if(stud[i]["name"].toString().toLowerCase().startsWith(p)){
              Student si = Student(stud[i]["name"].toString(), stud[i]["id"].toString(), stud[i]["code"].toString());
              si.AddSection(stud[i]["section"].toString());
              si.AddClass(stud[i]["class"].toString());
            students_c.add(si);
          }}

          current = students_c;
          notifyListeners();

        }
      }else{
        print(res_total);
        print('Error Obtaining Students, Call Helpline for help! or LogIn Again! ');

      }
    }else{
      print('Error Obtaining Students, CheckConnection');

    }
  }

  String get Overall {
    double e = 0;
    double h = 0;
    double q = 0;
    if(e_p is int || e_p is double){
      e = double.parse(e_p);
    }
    if(hw_perf != null){
      h = double.parse(hw_perf);
    }
    if(q_p != null){
      q = double.parse(q_p);
    }



    return ((e+h+q)/3).round().toString();
  }

  List<Student> get Current {
    return current;
  }
  
  void getPerformance() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    String type = "teacher";
    String tcode = sharedPreferences.getString("tcode");
    String icode = sharedPreferences.getString("icode");
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/stats/quiz/$icode/$classe/$section",
    );
    var res = await http.get(uri, headers: {
      "x-access-token": code,
      "type": type
    });
    print(res.body);
    var j = jsonDecode(res.body);
    if(res.statusCode == 200){
      if(j["status"]=="success"){
        q_p = j["data"].toString();
        notifyListeners();
      }
    }

    Uri uri_h = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/stats/homework/$icode/$classe/$section", {
      "sub":subject
    });
    var res_h = await http.get(uri_h, headers: {
      "x-access-token": code,
      "type": type
    });
    print(res_h.body);
    var j_h = jsonDecode(res_h.body);
    if(res_h.statusCode == 200){
      if(j["status"]=="success"){
        hw_perf = j_h["data"].toString();
        notifyListeners();
      }
    }
    Uri uri_e = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/stats/exam/$icode/$classe/$section", {
      "sub":subject
    });
    var res_e = await http.get(uri_e, headers: {
      "x-access-token": code,
      "type": type
    });
    print(res_e.body);
    var j_e = jsonDecode(res_e.body);
    if(res_e.statusCode == 200){
      if(j_e["status"]=="success"){
        e_p = j_e["data"].toString();
        notifyListeners();
      }
    }

  }

  void ChangeSubject(String string){
    subject =string;
    getPerformance();
    notifyListeners();
  }
  
  String get HW_perf {
    if(hw_perf == null || hw_perf == "null"){
      return "0";
    }else{
    return hw_perf;}
  }

  String get Exam_perf {
    if(e_p == null || e_p == "null"){
      return "0";
    }else {
      return e_p;
    }}
  String get Quiz_perf {
    if(q_p == null || q_p == "null"){
      return "0";
    }else {
      return q_p;
    }}
  String get Class_perf {
    if(cl_p == null || cl_p == "null"){
      return "0";
    }else {
      return cl_p;
    }
  }
}