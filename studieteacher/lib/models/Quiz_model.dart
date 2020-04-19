import 'package:flutter/cupertino.dart';
import 'package:studieteacher/chapters/Chapter.dart';
import 'package:studieteacher/quiz/Question.dart';

class Quiz_model extends ChangeNotifier {

  var _title;
  var _subject = "maths";
  List<String> _chapters = [];
  var _class = "";
  var _sec = "";
  var _current_Min = 00;
  var _current_Sec = 00;
  List<Question> _questions = [];
  var _dueDate = "0000";

  void ClearQuiz(){
    _title = "";
    _chapters = [];
    _class = "";
    _sec = "";
    _current_Min = 00;
    _current_Sec = 0;
    _questions = [];
    notifyListeners();
  }

  void AddQuestion(Question q){
    _questions.add(q);
    notifyListeners();
  }


  void ChangeClass(String cl) {
    _class = cl;
    notifyListeners();
  }

  void ChangeSection(String s){
    _sec = s;
    notifyListeners();
  }

  void AddSeconds() {
    _current_Sec += 1;
    notifyListeners();
  }

  String get Questions_n {
    return _questions.length.toString();
  }

  void AddMinutes() {
    _current_Min += 1;
    notifyListeners();
  }

  void SubMinutes() {
    if(_current_Min>0){
    _current_Min -= 1;}
    notifyListeners();
  }

  void SubSeconds() {
    if(_current_Sec>0){
    _current_Sec -= 1;}
    notifyListeners();
  }

  void ResetTime() {
    _current_Sec = 0;
    _current_Min = 0;
    notifyListeners();
  }


  void changeTitle(String ch){
    _title = ch;
    notifyListeners();
  }

  void add_chapters(String ch){
    if(_chapters.contains("\"$ch\"")){
      _chapters.remove("\"$ch\"");
      notifyListeners();
    }else{
      _chapters.add("\"$ch\"");
      notifyListeners();}


  }

  String get Title {
    return _title;
  }

  String get Subject {
    return _subject;
  }

  List<String> get Chapters {
    return _chapters;
  }

  String get Class {
    return _class;
  }

  String get Section {
    return _sec;
  }

  String get Minutes {
    return _current_Min.toString();
  }

  String get Seconds {
    return _current_Sec.toString();
  }

  String get DueDate {
    return (_current_Min).toString()+"," +_current_Sec.toString();
  }

  List<Question> get GetQuestions {
    return _questions;
  }



}