class Student {
  var _name = "";
  var _documentId = "";
  var studentCode = "";
  var Class = "";
  var section = "";

  Student(this._name, this._documentId, this.studentCode);

  String get Name {
    return _name;
  }

  void AddClass(String s) {
    Class = s;
  }
  void AddSection(String sec){
    section = sec;
  }

  String get dId {
    return _documentId;
  }

  String get code {
    return studentCode;
  }

  void changeName(String name){
    _name = name;
  }

  void changeId(String id){
    _documentId =  id;
  }
}