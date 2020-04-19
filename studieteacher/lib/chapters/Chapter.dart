import 'package:studieteacher/models/Doubts.dart';

class Chapter {
  var _id;
  var _name;
  var _started;
  var _ended;
  List<Doubts> _doubts =[];
  var classe = "1";
  var section = "a";
  var Subject = "na";

  Chapter(this._id, this._name, this._started, this._ended, this.classe, this.section, this.Subject);

  void AddDoubts(List<Doubts> d){
    _doubts = d;
  }

  List<Doubts> get doubts_Ch {
    return _doubts;
  }
  String get Id {
    return _id;
  }

  String get Name {
    return _name;
  }

  String get started {
    if(_started==null){
      return "";
    }
    DateTime c= DateTime.parse(_started);
    String r= c.day.toString() + " " + c.month.toString() + " "+ c.year.toString();
    return r;
  }

  String get Ended {
    return _ended;
  }

}