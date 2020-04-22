import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/Exam.dart';
import 'package:studieteacher/models/absent_students.dart';
import '../Student.dart';
import 'Scores.dart';
import 'exam_details_container.dart';
import 'package:http/http.dart' as http;

class adding_scores extends StatefulWidget {

  Exam _current;
  adding_scores(this._current);
  @override
  State<StatefulWidget> createState() => _stateAddingScore(_current);


}

class _stateAddingScore extends State<adding_scores> {
  Exam current_Exam ;
  _stateAddingScore(this.current_Exam);
  var loading = true;
  var classes = 1;
  var section = "a";
  List<Score> stud = [];
  GlobalKey<ScaffoldState> globalKey = new GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStudents();
  }

  void getStudents() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/attendance/$school/$classes/$section".toLowerCase() );
    print(uri.toString());
    var res = await http.get(uri, headers: {
      "x-access-token": code,
      "type":"teacher"
    });
    var res_total = jsonDecode(res.body);
    if(res.statusCode==200){
      if(res_total["status"]=="success"){
        List students = res_total["students"];
        print(res_total);
        List<Score> students_c = [];
        if(students.isEmpty){
          globalKey.currentState.showSnackBar(SnackBar(content: Text('No Students Available'),));
        }else{
          print(students.toString());
          for(int i=0; i<students.length; i++) {
            students_c.add(Score(students[i]["name"], 0, students[i]["code"]));
          }
          setState(() {
            loading = false;
            stud = students_c;
          });
        }
      }else{
        print(res_total);
        print('Error Obtaining Students, Call Helpline for help! or LogIn Again! ');
        globalKey.currentState.showSnackBar(SnackBar(content: Text('Error Obtaining Students, Call Helpline for help!'),));
      }
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
        title: Text('Add Scores', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(flex:2,child:FittedBox(fit:BoxFit.contain,child:exam_details_container(current_Exam))),
          Flexible(flex:1,child: Container(padding: EdgeInsets.only(left: 10),
              child:Text('Add Scores to Students', style: TextStyle(fontSize: 20),)
          )),
          Flexible(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  width: 200,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(10),
                  ),
                    margin: EdgeInsets.all(10),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text('Class $classes Sec $section', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  width: 100,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.all(10),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Center(child:Text('Scores', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
                  ),
                ),
              )
            ],
          )),
          Flexible(flex: 6, child:
              Container(margin:EdgeInsets.all(10), child:
              ListView.builder(scrollDirection:Axis.vertical,itemCount:stud.length,itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  child:Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[

                      Container(
                        child: Center(
                            child:Image.asset("assets/ellipse-2.png",width: 40,height: 40)

                        ),
                      ),
                      Container(
                        margin:EdgeInsets.only(left: 5),
                        child:Text(stud[index].name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Container(
                          child: Align(alignment:Alignment.centerRight,child:
                          Container(
                            width:50,
                            child:TextFormField(
                            onChanged: (value) {
                              stud[index].ChangeScore(value);
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.grey[300],
                                filled: true,
                                hintText: "100",
                                hintStyle: TextStyle(color: Colors.pinkAccent, fontSize: 16),
                                border: OutlineInputBorder(borderSide: BorderSide(width:0.0, style: BorderStyle.none),borderRadius: BorderRadius.circular(10))
                            ),
                              keyboardType: TextInputType.number,
                          ),
                      )))),
                        Container(child:
                        RaisedButton(disabledColor:Colors_pack.color,color:Colors_pack.color,child:Container(child: Center(child:Icon(Icons.add, color: Colors.white,size: 30,)),),shape: CircleBorder(side: BorderSide.none),))


                    ],
                  ) ,
                );
              })


            )),
          Flexible(flex:1,child:FittedBox(
              fit: BoxFit.contain,
              child:Consumer<absent_s_model>(builder: (context, model, child){
                return Center(child:RaisedButton(onPressed: () {
                      AddScores();
                },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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

  void AddScores() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    List<String> lists = [];
    for(int j=0; j<stud.length; j++){
      lists.add(stud[j].Data);
    }
    print(current_Exam.Id);
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/exam");
    var res = await http.patch(uri, headers: {
      "x-access-token":code,
      "type": "teacher"
    }, body: {
      "id": current_Exam.Id,
      "marksList": lists.toString()
    });

    globalKey.currentState.showSnackBar(SnackBar(content: Text(res.body),));


  }



}