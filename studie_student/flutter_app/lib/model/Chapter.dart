import 'Doubts.dart';

class Chapter {

  var _Started_on;
  var _ended_on;
  var _name;
  List<Doubts> _doubts = [];
  var _id;
  var subject = "NA";
  var classe;
  var section;


  void AddDoubts(List<Doubts> d){
    _doubts = d;
  }


  Chapter(this._id, this._name, this._Started_on,this._ended_on,this.classe, this.section, this.subject);

  String get Started {
    return _Started_on;
  }

  String get Id {
    return _id;
  }

  String get Ended {
    return _ended_on;
  }

  String get Name {
    return _name;
  }

  List<Doubts> get doubts {
    return _doubts;
}
}