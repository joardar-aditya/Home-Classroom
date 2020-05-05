import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutterapp/models/document.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Announce.dart';
class announce_model extends ChangeNotifier {
  List<Document> docs = [];
  announce_model() {
    GetAnnouncement();

  }

  void AddAnnounce(Document a){
    docs.add(a);
    notifyListeners();
  }

  List<Document> get AllAnnounce {
    return docs;
  }

  int get AnnounceSize {
    return docs.length;
  }

  void GetAnnouncement() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String icode = sharedPreferences.getString("icode");
    String code = sharedPreferences.getString("user");
    String school = sharedPreferences.getString("icode");
    String classe = sharedPreferences.getString("class");
    String sec = sharedPreferences.getString("section");
    print(code);
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com","/student/docs/$school/$classe/$sec");
    print(uri);

    var resp = await http.get(uri, headers: {
      "type" : "student",
      "x-access-token":code
    });
    print(resp.body);
    var j = json.decode(resp.body);
    print(j);
    var an = j["data"];
    print(an.toString());
    for(var i=0; i<an.length; i++){
      var current = an[i]["data"];
      this.AddAnnounce(Document(an[i]["docId"],current["filePath"], current["class"].toString(),current["section"].toString(),"Another File"));
    }
  }

}