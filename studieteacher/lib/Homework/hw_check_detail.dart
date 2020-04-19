import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/containers/attendance_name_container.dart';
import 'package:studieteacher/containers/hw_container.dart';
import 'package:studieteacher/data/students_a.dart';
import 'package:http/http.dart' as http;
import 'package:studieteacher/models/hw_submit_model.dart';
import '../Student.dart';
import 'hw.dart';

class hw_check_detail extends StatefulWidget{
  hw _Hw;
  hw_check_detail(this._Hw);
  @override
  State<StatefulWidget> createState() => _attendance_g_state(_Hw);


}

class _attendance_g_state extends State<hw_check_detail> {

   hw _hw;
   var loading = true;
   List<Student> students = [];
   _attendance_g_state(this._hw);
   GlobalKey<ScaffoldState> globalKey = new GlobalKey();

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStudents();
  }
   void getStudents() async{
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     String code = sharedPreferences.getString("user");
     String teacher = sharedPreferences.getString("tcode");
     String school = sharedPreferences.getString("icode");
     String classe = _hw.Classe;
     String sec = _hw.Section;
     Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/attendance/$school/$classe/$sec".toLowerCase() );
     print(uri.toString());
     var res = await http.get(uri, headers: {
       "x-access-token": code,
       "type":"teacher"
     });
     var res_total = jsonDecode(res.body);
     if(res.statusCode==200){
       if(res_total["status"]=="success"){
         List stud = res_total["students"];
         print(res_total);
         List<Student> students_c = [];
         if(stud.isEmpty){
           globalKey.currentState.showSnackBar(SnackBar(content: Text('No Students Available'),));
           Timer(Duration(seconds: 3), () {
             Navigator.pop(context);
           });
         }else{
           print(stud.toString());
           for(int i=0; i<stud.length; i++) {
             students_c.add(Student(stud[i]["name"].toString(), stud[i]["id"].toString(), stud[i]["code"].toString()));
           }
           setState(() {
             loading = false;
             students = students_c;
           });
         }
       }else{
         print(res_total);
         print('Error Obtaining Students, Call Helpline for help! or LogIn Again! ');
         globalKey.currentState.showSnackBar(SnackBar(content: Text('Error Obtaining Students, Call Helpline for help!'),));
         Timer(Duration(seconds: 3), () {
           Navigator.pop(context);
         });
       }
     }else{
       print('Error Obtaining Students, CheckConnection');
       globalKey.currentState.showSnackBar(SnackBar(content: Text('Error Obtaining Students, Check your Connection!'),));
       Timer(Duration(seconds: 3), () {
         Navigator.pop(context);
       });
     }
   }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: globalKey,
      appBar:  AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Homework', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body:Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(
              flex:2,
              child: Container(margin:EdgeInsets.symmetric(vertical: 10),child:FittedBox(fit:BoxFit.contain,child:Text('Select the students who have submitted', textAlign:TextAlign.center,style: TextStyle(fontSize: 22),),
              ))),
          Flexible(
            flex:16,
            child:Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child:loading?Container(child:Center(child: CircularProgressIndicator(),)):ListView.builder(itemCount:students.length,itemBuilder: (context, i) {
                  return hw_container(students[i], i+1);
                },)
            ),
          ),
          Flexible(flex:2,child:FittedBox(
              fit: BoxFit.contain,
              child:Consumer<hw_submit>(builder:(context, model, child){
                return Center(child:RaisedButton(onPressed: () {
                  Add_submissions(model, model.Submitted);
                },
                  color: Colors_pack.color,
                  child:Center(
                      child:Text('Done', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold
                      ),)
                  )
              ),
              );})))



        ],
      ),

    );
  }

  void Add_submissions(hw_submit m,List<Student> sts) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    String classe = _hw.Classe;
    String sec = _hw.Section;
    List<String> submit = [];
    for(int j=0; j<sts.length; j++) {
      String id = sts[j].dId;
      String code = sts[j].code;
      String name = sts[j].Name;
      submit.add("{\"id\":\"$id\",\"scode\":\"$code\",\"sname\":\"$name\"}");
    }
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/homework/submit/$school/$classe/$sec".toLowerCase() );
    print(submit.toString());
    print(_hw.Id);
    var res = await http.post(uri, body: {
      "id":_hw.Id.toString(),
      "submissions": submit.toString()
    },headers: {
      "x-access-token":code,
      "type": "teacher"
    } );

    print(res.body);
    var j = jsonDecode(res.body);
    if(res.statusCode == 200){
      if(j["status"]=="success"){
        globalKey.currentState.showSnackBar(SnackBar(content: Text("Homework submission data updated"),));
        m.ClearList();
        Timer(Duration(seconds: 3), () {
          Navigator.pop(context);
        });

      }else{
        globalKey.currentState.showSnackBar(SnackBar(content: Text("Homework submission data not updated"),));
      }
    }else{
      globalKey.currentState.showSnackBar(SnackBar(content: Text("Homework submission data not updated"),));
    }

   }





}