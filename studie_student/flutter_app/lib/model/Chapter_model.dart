import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/model/Doubts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Chapter.dart';

class Chapter_model extends ChangeNotifier {
  List<Chapter> _chapters = [];
  var _subject = "maths";

  Chapter_model() {
  }

  List<Chapter> get Chapters {
    return _chapters;
  }





  Future<bool> GetChapters(String sub) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    print(code);
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    String cla = sharedPreferences.get("class");
    String sec = sharedPreferences.get("section");
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/student/chapters/$school/$cla/$sec".toLowerCase(),{
      "subject": sub
    } );
    var res = await http.get(uri, headers: {
      "x-access-token": code,
      "type":"student"
    });

    print(res.body);
    var j = jsonDecode(res.body.toString());
    if(res.statusCode==200){
      if(j["status"]=="success"){
        List data = j["data"];
        List<Chapter> c=[];
        for(int i=0;i<data.length;i++){
          String ij = data[i]["id"];
          List ch = data[i]["data"]["chapters"];
          for(int j=0; j<ch.length; j++){
            print(ch[j]["name"]);
            print(ch[j]["doubts"].toString());
            print(ch[j]["started_on"].toString());
            c.add(Chapter(ch[j]["name"], ch[j]["ended_on"], ij , ch[j]["started_on"], data[i]["data"]["subject_code"], cla, sec));
          }

        }
       _chapters = c;
        notifyListeners();
        return true;
      }
       return false;
    }

      return false;
  }


}