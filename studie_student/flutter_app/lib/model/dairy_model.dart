import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutterapp/Diary/diary.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'Notes.dart';

class dairy_model extends ChangeNotifier {
  List<Notes> notes = [];
  String status = "";

  dairy_model(){
    getreports();
}

  void getreports() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("user");
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    String name = sharedPreferences.getString("name");
    String cl = sharedPreferences.getString("class");
    String sec = sharedPreferences.getString("section");
    var uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "student/performance/$school/", {
      "scode": teacher,
    });

    var res = await http.get(uri, headers: {
      "x-access-token": token,
      "type":"student"
    });
    print(res.body);
    var j = jsonDecode(res.body);
    List merits = j["data"]["data"]["merits"]["meritHistory"];
    List<Notes> temp = [];
    for(int i =0; i< merits.length; i++ ){
      temp.add(Notes(DateTime.fromMillisecondsSinceEpoch(merits[i]["date"]), merits[i]["reason"]));
    }
    notes = temp;
    notifyListeners();

  }

  void getAnnouncements() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    print(code);
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "student/announce/$school/", {
      "gen_announce":"true",
    });
    var res = await http.get(uri, headers: {
      "x-access-token":code,
      "type":"student"
    });

    notifyListeners();


  }

  List<Notes> get Notes_comp {
    return notes;
  }


}