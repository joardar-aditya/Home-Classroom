import 'Doubts.dart';

class Chapter {

  DateTime _Started_on;
  DateTime _ended_on;
  var _name;
  List<Doubts> _doubts = [];
  var _id;
  var subject = "NA";
  var classe;
  var section;
  List<String> months = ["", "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
  List<String> weekday = ["", "MON", "TUE", "WED", "THR", "FRI", "SAT", "SUN"];


  void AddDoubts(List<Doubts> d){
    _doubts = d;
  }


  Chapter(this._id, this._name, this._Started_on,this._ended_on,this.classe, this.section, this.subject);

  String get Started {
    if(_Started_on == null){
      return "Not Started Yet";
    }else {
      return "${_Started_on.day.toString()} ${months[_Started_on
          .month]} ${weekday[_Started_on.weekday]} ${_Started_on.year
          .toString()}  ";
    }}

  String get Id {
    return _id;
  }

  String get Ended {
    if(_ended_on == null){
      return "Not Ended Yet";
    }else {
      return "${_ended_on.day.toString()} ${months[_ended_on
          .month]} ${weekday[_ended_on.weekday]} ${_ended_on.year
          .toString()}  ";
    }}

  String get Name {
    return _name;
  }

  List<Doubts> get doubts {
    return _doubts;
}
}