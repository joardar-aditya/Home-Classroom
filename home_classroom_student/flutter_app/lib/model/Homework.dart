class Homework {
  var _title ;
  var _author ;
  var _class;
  var _section ;
  var description ="na";
  DateTime _current = DateTime.now();
  String _subject;
  String id;

  Homework(this.id,this._current,this.description, this._title, this._author, this._class, this._section, this._subject);

  DateTime get Date{
    return _current;
  }


  String get Class {
    if(_class==null){
      return "";
    }
    return _class;
  }

  String get Title {
    if(_title==null){
      return "No Title Given";
    }
    return _title;
  }

  String get Subject {
    if(_subject==null){
      return "NA";
    }
    return _subject;
  }

  String get Author {
    if(_author==null){
      return "Author not Available";
    }
    return _author;
  }

  String get Section {
    if(_section==null){
      return "";
    }
    return _section;
  }
}