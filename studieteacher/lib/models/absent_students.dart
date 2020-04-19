import 'package:flutter/cupertino.dart';

class absent_s_model extends ChangeNotifier {

  List<String> _absentStudents = [];

  void AddAbsentee(String id){
    if(_absentStudents.contains(id)){
      _absentStudents.remove(id);
      notifyListeners();
    }else{
      _absentStudents.add("\"$id\"");
      notifyListeners();
    }
  }

  List<String> get absentee{
    return _absentStudents;
  }

  void ClearList() {
    _absentStudents.clear();
  }
}