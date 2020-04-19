import 'package:flutter/cupertino.dart';

class exam_add_model extends ChangeNotifier {

  var date = DateTime.now();
  var current_class;
  var current_section;
  var title;
  var subject;
  var fullMarks = "0";
  Map chapters = {};
  List<String> examTypes = ["Class Test", "MidTerm Test", "Final Test"];
  String current = "Class Test";

  void change_current(String s){
    current = s;
    notifyListeners();
  }

  int get Current_Type {
    return examTypes.indexOf(current) +1;
  }


  void change_marks(String f){
    fullMarks = f;
    notifyListeners();
  }
  void change_date(DateTime dateTime){
    date = dateTime;
    notifyListeners();
  }

  bool exam_empty() {
    return chapters.length == 0;
  }

  void change_class(String c){
    current_class = c;
    notifyListeners();
  }

  void change_section(String sec){
    current_section = sec;
    notifyListeners();
  }

  void change_title(String ti){
    title = ti;
    notifyListeners();
  }

  void change_subjects(String sub){
    subject = sub;
    notifyListeners();
  }

  void addDescription(String s, String key){
    chapters[key] = s;
    notifyListeners();
  }

  void add_chapters(String ch){
    if(chapters.containsKey(ch)){
      chapters.remove(ch);
      notifyListeners();
    }else{
    chapters.putIfAbsent(ch, () => "");
    notifyListeners();}


  }

  DateTime get exam_date {
    return date;
  }

  String get exam_class {
    return current_class;
  }

  String get exam_section {
    return current_section;
  }

  String get exam_title {
    return title;
  }

  String get exam_subject {
    return subject;
  }

  Map get exam_chapters {
    return chapters;
  }



}