import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'Calendar.dart';
class calendar_model extends ChangeNotifier {
  DateTime current_Date = DateTime.now();
  var _listofDates = ["Monday", "Tuesday", "Wednesday", "Thrusday", "Friday", "Saturday", "Sunday"];
  List<Schedule> list_of_sc_monday = [];
  List<Schedule> list_of_sc_tuesday = [];
  List<Schedule> list_of_sc_wednesday = [];
  List<Schedule> list_of_sc_thrusday = [];
  List<Schedule> list_of_sc_friday = [];
  List<Schedule> list_of_sc_saturday = [];

  calendar_model() {
    GetSchedule();
  }




  void GetSchedule() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    print(code);
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    String student = sharedPreferences.getString("student");
    String cl = sharedPreferences.getString("class");
    String sec = sharedPreferences.getString("section");
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/student/routine/$school/$cl/$sec");
    var res = await http.get(uri, headers: {
      "x-access-token": code,
      "type": "student",
    });

    var j = jsonDecode(res.body);
    print(res.body);
    //Monday
    List list_m = j["data"][0]["routine"]["Monday"];
    if(list_m != null){
    for(int m=0; m<list_m.length; m++){
      list_of_sc_monday.add(Schedule(list_m[m]["start"],list_m[m]["end"],list_m[m]["subject"], list_m[m]["tcode"]));
    }}
    //Tuesday
    List list_t = j["data"][0]["routine"]["Tuesday"];
    if(list_t != null){
      for(int m=0; m<list_t.length; m++){
        list_of_sc_tuesday.add(Schedule(list_t[m]["start"],list_t[m]["end"],list_t[m]["subject"], list_t[m]["tcode"]));
      }}
    //Wednesday
    List list_w = j["data"][0]["routine"]["Wednesday"];
    print(list_w.toString());
    if(list_w != null){
      print("Wednesday was called");
      for(int w=0; w<list_w.length; w++){
        list_of_sc_wednesday.add(Schedule(list_w[w]["start"],list_w[w]["end"],list_w[w]["subject"], list_w[w]["tcode"]));
      }
    print(list_of_sc_wednesday.toString());
    }

    //Thrusday
    List list_th = j["data"][0]["routine"]["Thrusday"];
    if(list_th != null){
      for(int m=0; m<list_th.length; m++){
        list_of_sc_thrusday.add(Schedule(list_th[m]["start"],list_th[m]["end"],list_th[m]["subject"], list_th[m]["tcode"]));
      }}
    //Friday
    List list_f = j["data"][0]["routine"]["Friday"];
    if(list_f != null){
      for(int m=0; m<list_f.length; m++){
        list_of_sc_friday.add(Schedule(list_f[m]["start"],list_f[m]["end"],list_f[m]["subject"], list_f[m]["tcode"]));
      }}

    //Saturday
    List list_sa = j["data"][0]["routine"]["Saturday"];
    if(list_sa != null){
      for(int m=0; m<list_sa.length; m++){
        list_of_sc_saturday.add(Schedule(list_sa[m]["start"],list_sa[m]["end"],list_sa[m]["subject"], list_sa[m]["tcode"]));
      }}
    notifyListeners();
  }

  void ChangeCurrentDate(DateTime dateTime){
    current_Date = dateTime;
    notifyListeners();
  }

   List<Schedule> GetTodaySchedule(){
    int week = current_Date.weekday;
    print(current_Date.weekday);
    switch(week) {
      case 1:
        return list_of_sc_monday;
        break;
      case 2:
        return list_of_sc_tuesday;
        break;
      case 3:
        return list_of_sc_wednesday;
        break;
      case 4:
        return list_of_sc_thrusday;
        break;
      case 5:
        return list_of_sc_friday;
        break;
      case 6:
        return list_of_sc_saturday;
        break;
      default:
        return [];
        break;
    }
   }

}