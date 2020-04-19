import 'package:flutter/cupertino.dart';

class Score {
  String name = "NA";
  int score = 0;
  String id ="NA";

  void ChangeScore(String sc){
    score = int.parse(sc);
  }


  Score(this.name, this.score, this.id);

  String get Data {
    String sc = score.toString();
    return "{\"scode\":\"$id\",\"sname\":\"$name\",\"marks\":\"$sc\"}";
  }
}