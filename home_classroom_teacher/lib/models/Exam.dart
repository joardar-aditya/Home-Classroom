import 'package:flutter/cupertino.dart';

class ExamChapter {
  var name;
  var desc;
  ExamChapter(this.name, this.desc);
}

class Exam {
  var marks = [];
  String _title = "NA";
  String _dueDate = "NA";
  String _nameTeacher = "NA";
  String _subject = "NA";
  String _class = "X";
  String _section = "X";
  String Id ="NA";
  int full_marks = 0;
  List<ExamChapter> syllabus = [];

  Exam(this.Id,this.full_marks, this._title, this._dueDate, this._nameTeacher, this._subject,this._class, this._section, this.syllabus);

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

  String get Subject {
    return _subject;
  }

}