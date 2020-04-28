class question {
  var answers = [];
  var correct_a;
  var milli;
  var title;
  var file ;

  question(this.file,this.answers, this.correct_a, this.title);

  String get quesTitle {
    return title;
  }

  String get Status {
    return file.toString();
  }

  String get quesmilli {
    return 0.toString();
  }

  String get quesSec {
    return 10.round().toString();
  }

  String get quizCorrect {
    return correct_a;
  }

  get quizAnswers{
    return answers;
  }

  int get TotalAnswer {
    return answers.length;
  }


}