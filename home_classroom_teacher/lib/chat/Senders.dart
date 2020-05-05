class Senders {
  var _name = "";
  var _documentId = "";
  var studentCode = "";
  var Class = "";
  var section = "";
  var role = "";

  Senders(this._name, this.role, this.studentCode);

  String get Name {
    return _name;
  }

  String get Role {
    return role;
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