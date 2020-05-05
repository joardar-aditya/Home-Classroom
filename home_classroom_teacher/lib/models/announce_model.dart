
import 'dart:io';

import 'package:flutter/cupertino.dart';

class announce_model extends ChangeNotifier {

  var title;
  var genAnnounce = false;
  var file;


  bool get isGen {
    return genAnnounce;
  }

  void ChangeFile(File f){
    file = f;
    notifyListeners();
  }

  File get announceFile {
    return file;
  }

  String get atitle {
    return title;
  }

  void ChangeAnnounce(String t){
    title = t;
    notifyListeners();
  }

  void makeGen(){
    genAnnounce = true;
    notifyListeners();
  }

}