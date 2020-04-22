import 'dart:developer';

import 'package:studieteacher/quiz/question.dart';
import 'package:studieteacher/quiz/results.dart';
import 'package:studieteacher/quiz/results.dart';

class quiz {
  var classes = "na";
  var section = "na";
  var author = "na";
  var subject = "na";
  var title = "na";
  var due_date = 'na';
  var questions = [];
  var syllabus = "na";
  var total_part = "na";
  var parti = "na";
  var total_marks = "na";
  var result_t = [];

  quiz(this.classes, this.section, this.title, this.subject, this.author, this.due_date,this.syllabus, this.parti, this.total_part, this.total_marks) ;



  void AddQuestion(question q){
    questions.add(q);

  }

  void AddResult(results r) {
    result_t.add(r);

  }


  String get Minutes {
    List<String> l = due_date.split(",");
    return l[0];
  }

  String get Seconds {
    List<String> l = due_date.split(",");
    return l[1];
  }

  String get TotalQuestion {
    return questions.length.toString();
  }

  String get TotalResults {
    return result_t.length.toString();
  }

  String get quizTotal {
    if(total_part == null){
      return "NA";
    }
    return total_part;
  }

  String get quizParti {
    if(parti == null){
      return "NA";
    }
    return parti;
  }

  get quizSyllabus {
    if(syllabus == null){
      return "NA";
    }
    return syllabus;
  }

  String get quizClass {
    if(classes==null){
      return "NA";
    }
    return classes.toString();
  }

  String get quizTotalM {
    if(total_marks == null){
      return "NA";
    }
    return total_marks;
  }

  get quizQuestions {
    if(questions == null){
      return "NA";
    }
    return questions;
  }

  get quizResults {
    if(result_t == null){
      return "NA";
    }
    return result_t;
  }


  String get quizSection {
    if(section == null){
      return "NA";
    }
    return section;
  }

  String get quizAuthor {
    if(parti == null){
      return "NA";
    }
    return parti;
  }

  String get quizSubject {
    return subject;
  }

  String get quizTitle {
    return title;
  }

  String get quizLimit {
    return due_date.toString();
  }
}