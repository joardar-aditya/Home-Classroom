import 'package:flutter/cupertino.dart';
import 'package:flutterapp/model/Syllabus_Chapter.dart';

class Exam {
  var _title = "Current Test";
  var _date ="";
  var _full_marks = "";
  List<Sy_Ch> _chapters = [];
  var section;
  var classes;
  var author;
  var subject;
  var avg_marks = "";
  var max = "";
  var ob_ma = "";

  Exam(this._date,this.ob_ma,this.max, this._full_marks,this.avg_marks, this._chapters, this.section, this.classes, this.author, this.subject );

  String get Title {
    return _title;
  }

  String get ObtainedMarks {
    if(ob_ma == "null"){
      return "0";
    }else{
      return ob_ma.toString();
    }
  }

  String get MAX {
    if(max == "null"){
      return "0";
    }else{
      return max;
    }
  }

  String get AVG {
    if(avg_marks == "null"){
      return "0";
    }else{
      return avg_marks;
    }
  }

  DateTime get Date {
    return DateTime.parse(_date);
  }

  String get FullMarks {
    if(_full_marks == null) {
      return "0";
    }
    return _full_marks;
  }

  List<Sy_Ch> get Chapters {
    return _chapters;
  }
}