
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutterapp/model/Chapter.dart';

import 'Doubts.dart';


class doubts_model extends ChangeNotifier {


  List<Doubts> _doubt = [];
  File _file = null;
  Chapter _chapter ;//TODO:Id of the Chapter
  String _question = "";

  void AddDoubt(Doubts doubts ){
    _doubt.add(doubts);
    notifyListeners();
  }

  void NewDoubt(String s, File f){

  }

  String get Current_Question {
    return _question;
  }

  void ChangeQuestion(String s){
    _question = s;
    notifyListeners();
  }

  void ChangeFile(File f){
    _file = f;
  }



  void CurrentChapter(Chapter s){
    _chapter = s;
    notifyListeners();
  }

  Chapter get Current_Ch {
    return _chapter;
  }

  List<Doubts> get doubts {
    return _doubt;
  }

  File get GetFile {
    return _file;
  }


}
