import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Question.dart';
import 'Quiz.dart';

class Quiz_Model extends ChangeNotifier{


  var _status = 0;


  Quiz_Model() {
    GetQuizzes();
  }




  Future<bool> GetQuizzes() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    String school = sharedPreferences.getString("icode");
    String cla = sharedPreferences.getString("class");
    String sec = sharedPreferences.getString("section");
    print(cla);
    print(sec);
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "student/quiz/$school/$cla/$sec");
    var res = await http.get(uri,
    headers: {
      "type":"student",
      "x-access-token":code
    });
    if(res.statusCode == 200) {
      var j = jsonDecode(res.body);
      print(j.toString());
      if(j["status"]=="success"){
        List quiz = j["quiz"];
        List<Quiz> c = [];
        if(!quiz.isEmpty){
          for(int i=0; i<quiz.length;i++){
            Map p = quiz[i];
            String id = p["id"];
            String _ti= p["data"]["title"].toString();
            String _au = p["data"]["author_name"].toString();
            String _su = p["data"]["subject"].toString();
            String _cl = cla;
            String _se = sec;
            String _sy = p["data"]["syllabus"].toString();
            String _i = p["id"];
            String to_t = p["data"]["total_time"].toString();
            List qu = p["data"]["questions"];
            print("");
            List<Question> cq = [];
            if(qu.length==0){
              print("It's empty");
              break;
            }else{
              for(int j=0; j<qu.length; j++){
                Map qj = qu[j];
                String _title = qj["title"];
                List _op = qj["answers"];
                List<String> _options = [];
                print(_op.length);
                for(int o=0; o<_op.length; o++){
                  _options.add(_op[o].toString());
                }
                print(_options.toString());
                String _corr_a = qj["correct_a"].toString();
                cq.add(Question(_title, _options, _corr_a));

              }
            }
            c.add(Quiz(id,_au, _se, cq, _ti, _sy, _cl, _su, to_t));
            print(c.length);
          }
          _quizzes = c;
          lengthQ = _quizzes.length;
          _status = 200;
          notifyListeners();
          return true;
        }
        _status = 300;
        return false;
      }
      _status = 100;
      return false;
    }
    _status = 400;

    return false;
  }


  List<Quiz> _quizzes = [];
  int lengthQ = 0;
  List<Quiz> get Quizzes {
    return _quizzes;
  }



}

