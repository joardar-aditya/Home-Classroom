

class hw {
  var _id;
  var author;
  String description= "";
  var title;
  var subject;
  var classes;
  var section;
  var chapter;
  int _submissions;
  DateTime due_date;
  List<String> submissions = [];



  void AddSubmissions(List<String> su) {
    submissions = su;
  }

  bool HasSubmitted(String s){
    return submissions.contains(s);

  }

  String get Id {
    return _id;
  }


  int get Submissions {
    return _submissions;
  }

  void ChangeSubmissions(int i){
    _submissions = i;
  }

  String get Classe {
    return classes;
  }

  String get Section {
    return section;
  }

  String get Description {
    return description;
  }

  hw(this.description,this._id,this.author, this.title, this.subject, this.classes, this.section, this.chapter, this.due_date);
}