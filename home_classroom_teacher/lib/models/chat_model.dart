import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/Student.dart';
import 'package:studieteacher/chat/Senders.dart';
class chat_model extends ChangeNotifier {
  List<Senders> students = [];
  List<Senders> participants = [];
  chat_model() {
    gettingStudents();
  }

  void AddParticipant(Senders s){
    participants.add(s);
    notifyListeners();
  }

  void RemoveParticipants(Senders s){
    if(participants.contains(s)){
      participants.remove(s);
      notifyListeners();
    }
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
        List<Senders> cur = [];
        List s = res_total["students"];
        for(int j=0; j<s.length;j++){
          Senders ne = Senders(s[j]["name"], "students", s[j]["code"]);
          ne.AddClass(s[j]["class"]);
          ne.AddSection(s[j]["section"]);
          cur.add(ne);
        }
        Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/parent/$school/".toLowerCase() );
        print(uri.toString());
        var res = await http.get(uri, headers: {
          "x-access-token": code,
          "type":"teacher"
        });
        print(res.body);
        if(res.statusCode == 200){
          var j = jsonDecode(res.body);
          if(j["status"]=="success"){
            List l = j["data"];
            print("done");
            for(int j=0; j<l.length;j++){
              Senders se = Senders(l[j]["name"], "parents", l[j]["code"]);
              cur.add(se);
            }
            print(cur);
          }
        }
        print(cur);
        students = cur;
        notifyListeners();
      }
    }
    }
}