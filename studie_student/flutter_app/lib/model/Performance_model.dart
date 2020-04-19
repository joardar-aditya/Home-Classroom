import 'package:flutter/cupertino.dart';

class performance_model extends ChangeNotifier {
  var _hw_sub = 0;
  var _ex_pe = 0;
  var _qi_per = 0;
  var _class_per = 0;
  var _OverallPerformance = 0;
  var _type1 = "Overall";
  var _type2 = "Maths";


  Future<bool> GetPerformance(String type1, String type2) async{
    var user = false;
        if (user){
      return true;
    } else{
          return false;
    }
  }



  void Change1(String s){
    _type1 = s;
    notifyListeners();
  }

  void Change2(String s){
    _type2 = s;
    notifyListeners();
  }



  int get Hw_sub {
    return _hw_sub;
  }

  String get Type1 {
    return _type1;
  }

  String get Type2 {
    return _type2;
  }

  int get Ex_Pe {
    return _ex_pe;
  }

  int get Qi_pe {
    return _qi_per;
  }

  int get Class_pe {
    return _class_per;
  }

  int get OverallPerformance {
    return _OverallPerformance;
  }

}

