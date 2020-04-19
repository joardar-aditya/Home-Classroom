
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/Homework/hw.dart';
import 'package:http/http.dart' as http;

class hw_model extends ChangeNotifier {
  var current_class = "1";
  var current_section = "a";
  var current_subject;
  var current_chapter;
  var title;
  var desc;
  var c_file;
  var date_sub = DateTime.now();
  List<hw> homeworks = [];

  hw_model() {
    GetHomework();
  }


  void changeClass(String c){
    current_class = c;
    notifyListeners();
  }

  void AddHomework(hw h) {
    homeworks.add(h);
    notifyListeners();
  }

  List<hw> get ListHomework {
    return homeworks;
  }

  int get LengthHw {
    return homeworks.length;
}
  bool get HwEmpty {
    return homeworks.length == 0;
  }

  void ChangeSection(String s){
    current_section = s;
    notifyListeners();
  }

  void ChangeSubject(String sub){
    current_subject = sub;
    notifyListeners();
  }

  void ChangeChapter(String ch){
    current_chapter = ch;
    notifyListeners();
  }

  void ChangeTitle(String ti){
    title = ti;
    notifyListeners();
  }

  void ChangeDesc(String ti){
    desc = ti;
    notifyListeners();
  }

  void ChangeFile(File file){
    c_file = file;
    notifyListeners();
  }

  void ChangeDate(DateTime d){
    date_sub = d;
  }

  void GetHomework() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com","/teacher/homework/$school/$current_class/$current_section",{
      "tcode":teacher
    });
    var res= await http.get(uri, headers: {
      "x-access-token" : code,
      "type" : "teacher"
    });

    var j = json.decode(res.body.toString());
    print(j.toString());
    List l_h = j["homeworks"];
    List<hw> current = [];
    for(var i=0; i<l_h.length; i++ ){
      var m = l_h[i]["data"];
      DateTime submit = DateTime.parse(m["due_date"]);
      current.add(hw(m["desc"],l_h[i]["id"],m["author"], m["title"], m["subject"], m["class"], m["section"], m["chapter"], submit));
    }
    homeworks = current;
    print(l_h.toString());
    notifyListeners();

}




  String get hwClass {
    return current_class;
  }

  String get hwSection {
    return current_section;
  }

  String get hwSubject {
    return current_subject;
  }

  String get hwChapter {
    return current_chapter;
  }

  String get hwTitle {
    return title;
  }

  String get hwDesc {
    return desc;
  }

  File get hwFile {
    return c_file;
  }

  DateTime get hwSub {
    return date_sub;
  }



}