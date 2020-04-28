import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutterapp/model/Homework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class Homework_model extends ChangeNotifier {

   List<Homework> homeworks = [];

   Homework_model() {
        GetHomework();
   }

   Future<bool> GetHomework() async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     String code = sharedPreferences.getString("user");
     print(code);
     String teacher = sharedPreferences.getString("tcode");
     String school = sharedPreferences.getString("icode");
     String clas = sharedPreferences.getString("class");
     String sec = sharedPreferences.getString("section");

     Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/student/homework/$school/$clas/$sec",{
     });
     var res = await http.get(uri,headers: {
       "x-access-token":code,
       "type":"student"
     });
     var j = jsonDecode(res.body);
     print(res.body);
     List<Homework> g = [];
     if(res.statusCode==200) {
       if (j["status"] == "success") {
         List m = j["homeworks"];
         for (int i = 0; i < m.length; i++) {
           var current = m[i]["data"];
           var date = DateTime.parse(m[i]["data"]["due_date"]);
           Homework c = Homework(m[i]["id"],date, current["desc"],
               current["title"], current["author_name"], current["class"],
               current["section"], current["subject"]);
           g.add(c);
         }
         homeworks = g;
         print("done");
         notifyListeners();
         print(homeworks.length);

         return true;
       }
       return false;
     }
     return false;

}

}