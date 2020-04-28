import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/Quiz/quiz.dart';
import 'package:flutterapp/model/current_q.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class result extends StatefulWidget {

  current_q model;
  result(this.model);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _stateR(model);
  }

}




class _stateR extends State<result> {
  current_q model2;
  _stateR(this.model2);
  GlobalKey<ScaffoldState> key = GlobalKey();
  void AddResults(current_q model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    String name = sharedPreferences.getString("name");
    String scode = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    String clas  = sharedPreferences.getString("class");
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/student/quiz");
    print(uri);
    var res= await http.post(uri, body: {
      "icode":school,
      "scode": scode,
      "sname": name,
      "score": model.Score.toString(),
      "class": clas,
      "quizId":model.Id,
    }, headers: {
      "x-access-token":code,
      "type" : "student"
    });

    print(res.body);
    if(res.statusCode == 200){
      if(jsonDecode(res.body)["status"]=="success"){
        key.currentState.showSnackBar(SnackBar(content: Text("Results Uploaded")));
      }else{
        key.currentState.showSnackBar(SnackBar(content: Text("Results Not Uploaded")));
      }
    }else{
      key.currentState.showSnackBar(SnackBar(content: Text("Results Not Uploaded")));
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AddResults(model2);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: key,
      appBar: AppBar(
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => quiz()
        ));},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Result', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
        body: Container(child:Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(child:Image(image: AssetImage("assets/merit.png"),height: 200,width: 200,)),
              Consumer<current_q>(builder:(context, model, child) {
                return Container(
                margin: EdgeInsets.all(10),
                child:Text('Excellent', style: TextStyle(color:Colors.pinkAccent, fontSize: 30, fontWeight: FontWeight.bold),),
              );}),
              Consumer<current_q>(builder: (context, model, child){
                return Container(
                  margin: EdgeInsets.all(10),
                  child:Text('You Scored '+model.Score.toString()+ " out of "+model.questions.length.toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.pinkAccent),)
                );
              },),
              RaisedButton(onPressed: () {
                showDialog(context: context, builder: (context){
                  return Dialog(
                    backgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    child: Consumer<current_q>(builder: (context, model, child) {
                      return ListView.builder(
                          itemCount: model.questions.length,
                          itemBuilder: (context, ind){
                        return Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color:Colors_pack.color,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            model.questions[ind].Correct, style: TextStyle(fontWeight:FontWeight.bold,color:Colors.white, fontSize: 24),
                          ),
                        );
                      });
                    },),
                  );
                });
              },
              color:Colors.pinkAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text("Answers", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),),
              ),)


            ],
          ),
        ),

    ));
  }

}