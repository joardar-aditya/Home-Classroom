import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/Student.dart';
class chat_model extends ChangeNotifier {
  List<Student> students = [];
  chat_model() {
    gettingStudents();
  }
  void gettingStudents() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/attendance/$school/1/a".toLowerCase() );
    print(uri.toString());
    var res = await http.get(uri, headers: {
      "x-access-token": code,
      "type":"teacher"
    });
    var res_total = jsonDecode(res.body);
    if(res.statusCode==200){
      if(res_total["status"]=="success"){
        List<Student> cur = [];
        List s = res_total["students"];
        for(int j=0; j<s.length;j++){
          Student ne = Student(s[j]["name"], s[j]["id"], s[j]["code"]);
          ne.AddClass(s[j]["class"]);
          ne.AddSection(s[j]["section"]);
          cur.add(ne);
        }
        students = cur;
        notifyListeners();
      }
    }
    }
}