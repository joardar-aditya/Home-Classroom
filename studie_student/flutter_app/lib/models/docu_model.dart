import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Announce.dart';
class docu_model extends ChangeNotifier {
  List<Announce> genAnnouncements = [];
  docu_model() {
        GetAnnouncement();

  }

  void AddAnnounce(Announce a){
    genAnnouncements.add(a);
    notifyListeners();
  }

  List<Announce> get AllAnnounce {
    return genAnnouncements;
  }

  int get AnnounceSize {
    return genAnnouncements.length;
  }

  void GetAnnouncement() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String icode = sharedPreferences.getString("icode");
    String code = sharedPreferences.getString("user");
    String school = sharedPreferences.getString("icode");
    print(code);
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com","/student/announce/$school");
    print(uri);

    var resp = await http.get(uri, headers: {
      "type" : "student",
      "x-access-token":code
    });
    print(resp.body);
    var j = json.decode(resp.body);
    print(j);
    var an = j["announcements"];
    print(an.toString());
    for(var i=0; i<an.length; i++){
      var current = an[i]["data"];
      this.AddAnnounce(Announce(current["section"], current["date"].toString(),current["announcement"]));
    }
  }

}