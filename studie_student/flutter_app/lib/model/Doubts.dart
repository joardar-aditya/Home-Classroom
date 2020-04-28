import 'dart:io';

class Doubts {
  var _name = "";
  var _class = "";
  var _section = "";
  var _question = "";
  var _role = "student";
  File _file = null;
  var _answer = null;
  DateTime date;

  Doubts(this._answer,this._class, this._section, this._name,this.date, this._question);

  String get Name {
    return _name;
  }

  bool AnsweredOrNot() {
    return !(_answer == null);
  }

  String get Answer {
    return _answer;
  }

  File get attachment {
    return _file;
  }

  String get Role {
    return _role;
  }


  String get Class {
    return _class;
  }
  String get Section {
    return _section;
  }
  String get Question {
    return _question;
  }
}