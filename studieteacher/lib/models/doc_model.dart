import 'dart:io';
import 'package:flutter/cupertino.dart';

class doc_model extends ChangeNotifier{
  final String URI = "studie-server-dot-project-student-management.appspot.com";

  File file;
  String desc;
  String clas;
  String sec;

  void change_file(File doc){
    file = doc;
    print('file was changed');
    notifyListeners();
  }

  String getClass() {
    return clas;
  }

  void setClass(String c){
    clas = c;
    notifyListeners();
  }

  String get_sec(){
    return sec;
  }

  void setSec(String s){
    sec = s;
    notifyListeners();
  }


  File get_file() {
     return file;
  }

  String get_url() {
    return URI;
  }

  String get_desc() {
    return desc;
  }

  String add_desc(String di){
    desc = di;
    notifyListeners();
  }



}