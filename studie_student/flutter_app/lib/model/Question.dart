

import 'dart:io';

class Question {
  var _title;
  List<String> _options =[];
  var _correct_a = "";

  Question(this._title, this._options, this._correct_a);

  String get Title {
    return _title;
  }

  String get Correct {
    return _correct_a;
  }

  List<String> get Options {
    return _options;
  }

}