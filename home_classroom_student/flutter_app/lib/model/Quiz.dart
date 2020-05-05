import 'package:flutter/cupertino.dart';

import 'Question.dart';

class Quiz {
  List<Question> questons = [];
  var _Subject = "";
  var _syllabus = "";
  var _class = "1";
  var _section = "a";
  var _author = "";
  var _title = "";
  var _id = "";
  var total_time;
  Quiz(this._id,this._author, this._section, this.questons, this._title, this._syllabus, this._class, this._Subject, this.total_time);

  int get Question_n{
    return questons.length;
  }

  String get Subject {
    return _Subject;
  }

  int get Minutes {
    List<String> l = total_time.toString().split(",");
    String min = l[0];
    return int.parse(min);
  }

  int get Seconds {
    List<String> l = total_time.toString().split(",");
    String sec = l[1];
    return int.parse(sec);
  }

  String get String_time {
    List<String> l = total_time.toString().split(",");
    String min = l[0];
    String sec = l[1];
    return  min + " M " + sec + " S";
  }


  String get Syllabus {
    return _syllabus;
  }
  String get Class {
    return _class;
  }

  String get Id {
    return _id;
  }
  String get Section {
    return _section;
  }

  String get Title {
    return _title;
  }

  String get Author {
    return _author;
  }


}