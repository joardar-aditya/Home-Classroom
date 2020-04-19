import 'package:flutter/cupertino.dart';
import 'package:flutterapp/model/Syllabus_Chapter.dart';

class Exam {
  var _title = "Current Test";
  var _date = "";
  var _full_marks = "";
  List<Sy_Ch> _chapters = [];
  var section;
  var classes;
  var author;
  var subject;

  Exam(this._date, this._full_marks, this._chapters, this.section, this.classes, this.author, this.subject );

  String get Title {
    return _title;
  }

  DateTime get Date {
    return DateTime.parse(_date);
  }

  String get FullMarks {
    return _full_marks;
  }

  List<Sy_Ch> get Chapters {
    return _chapters;
  }
}