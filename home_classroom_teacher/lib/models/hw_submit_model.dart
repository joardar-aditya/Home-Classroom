import 'package:flutter/cupertino.dart';

import '../Student.dart';

class hw_submit extends ChangeNotifier {

  List<Student> _absentStudents = [];

  void AddSubmittion(Student id) {
    if (_absentStudents.contains(id)) {
      _absentStudents.remove(id);
      notifyListeners();
    } else {
      _absentStudents.add(id);
      notifyListeners();
    }
  }

  List<Student> get Submitted {
    return _absentStudents;
  }

  void ClearList() {
    _absentStudents.clear();
    notifyListeners();
  }
}