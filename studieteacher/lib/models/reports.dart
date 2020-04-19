import 'package:flutter/cupertino.dart';

class reports extends ChangeNotifier {
  var reason = "";
  var classe = "1";
  var section = "a";

  void AddReason(String s){
    reason = s;
    notifyListeners();
  }

  void ChangeClass(String cl){
    classe = cl;
    notifyListeners();
  }

  void ChangeSection(String s){
    section  = s;
    notifyListeners();
  }

  String get Reason {
    return reason;
  }

  String get Classe{
    return classe;
  }
  String get Section {
    return section;
  }
}