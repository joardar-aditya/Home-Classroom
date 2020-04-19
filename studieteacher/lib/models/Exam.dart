import 'package:flutter/cupertino.dart';

class Exam {
  var marks = [];
  String _title = "NA";
  String _dueDate = "NA";
  String _nameTeacher = "NA";
  String _subject = "NA";
  String _class = "X";
  String _section = "X";
  String Id ="NA";

  Exam(this.Id, this._title, this._dueDate, this._nameTeacher, this._subject,this._class, this._section);

  String get Date {
    return _dueDate;
  }
  String get Title{
    return  _title;
  }

  String get NameTeacher {
    return _nameTeacher;
  }

  String get Class  {
    return _class;
  }

  String get Section {
    return _section;
  }

}