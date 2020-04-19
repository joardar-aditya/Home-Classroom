
import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'Question.dart';

class current_q extends ChangeNotifier {
  var score = 0;
  List<Question> questions = [];
  int current= 0;
  String _id ="";
  String _selected = "";

  int minute = 0;
  int second = 0;

  String get Minutes {
    return minute.toString();
  }

  void StopExam() {
    cancel.cancel();
    notifyListeners();
  }

  void AddId(String id){
    _id = id;
    notifyListeners();
  }

  String get Seconds {
    return second.toString();
  }

  String get Id {
    return _id;
  }
  Timer cancel;
  void StartExam(int min, int sec){
    minute = min;
    second = sec;

    notifyListeners();
    cancel = Timer.periodic(Duration(seconds: 1), (timer) {
      if(minute<0){
        cancel.cancel();
      }
      if(second<1){
        minute -= 1;
        second = 60;
        notifyListeners();
      }else{
        second -= 1;
        notifyListeners();

      }
    });
  }

  String get Selected {
    return _selected;
  }

  void Change_selected(String s){
    _selected = s;
    notifyListeners();
  }

  Question get Current {
    return questions[current];
  }

  void MakeQuestions(List<Question> q) {
    questions = q;
    current = 0;
    score = 0;
    notifyListeners();
  }

  int get Score {
    return score;
  }

  void AddCScore() {
    score += 1;
    current += 1;
    notifyListeners();
}
  void AddIScore() {
    current += 1;
    notifyListeners();
  }
  int get TotalScore {
    return questions.length;
  }

  void ClearCurrentQ() {
    score = 0;
    questions = [];
    current = 0;
    _selected = "";
    notifyListeners();

  }
}