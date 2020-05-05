

import 'package:flutter/cupertino.dart';
import 'package:studieteacher/exams/Scores.dart';

class add_scores extends ChangeNotifier {
  var teacher_name = "";
  var due_date = "";
  var title = "";
  var id = "";
  var subject = "";
  List<Score> scores = [];
}