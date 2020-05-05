import 'dart:io';

class Question {

  var _title;
  List<String> _options = ["","","",""];
  File _file = null;
  var _correct_a = "";
  var time_limit = 1000;

  Question(this._title, this._options, this._file, this._correct_a);

  List<String> get Options {
    return _options;
  }

  File get file {
    return _file;
  }

  String get CorrectA {
    return _correct_a;
  }

  String get TimeLimit {
    return time_limit.toString();
  }

  String get thedoc {
    var status = true.toString();
    if(_file == null){
      status = false.toString();
    }
    String op = Options.toString();
    return "{\"answers\":$op,\"correct_a\":$CorrectA,\"file\":\"$status\",\"title\":\"$_title\"}";
  }

}