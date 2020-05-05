

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:studieteacher/quiz/Question.dart';

class current_q_model extends ChangeNotifier {

  var _title;
 List<String> _options = ["","","",""];
 File _file = null;
 var _correct_a = "";

 void ChangeFile(File f){
   _file = f;
   notifyListeners();
 }

 void MakeTF() {
   _options = ["\"True\"", "\"False\""];
   notifyListeners();
 }

 void AddCorrect(String s){
   _correct_a = s;
   notifyListeners();
 }

 void AddOption(String o,int i){

   _options[i] = "\"$o\"";
   notifyListeners();

 }

 List<String> get Options {
   return _options;
 }

 File get GetFile {
   return _file;
 }

 String get correct_a {
   return _correct_a;
 }

 String get Title {
   return _title;
 }

 File get file {
   return _file;
 }

 void MakeSingle() {
   _options = [];
 }

 void ChangeTitle(String t){
   _title = t;
 }

 Question give_me_question() {
   var _op = _options.toString();
   var fi = false.toString();
   if(_file != null) {
     fi = true.toString();
   }
   return Question(_title, _options, _file, _correct_a);
 }

 void ClearQuestion() {
   _title= "";
   _options = ["", "", "" , ""];
   _correct_a = "";
   _file = null;
   notifyListeners();
 }



}