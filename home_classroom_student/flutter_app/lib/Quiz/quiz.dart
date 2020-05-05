import 'package:flutter/material.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/Quiz/container.dart';
import 'package:flutterapp/model/Quiz_model.dart';
import 'package:provider/provider.dart';

import 'edit_quiz.dart';

class quiz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateQuiz();

}

class _stateQuiz extends State<quiz> {

  var _status = "loading";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkStatus();

  }

  void checkStatus() async{
    Quiz_Model quiz_model = new Quiz_Model();
    if(quiz_model.lengthQ>0){
      setState(() {
        _status = "done";
      });
    }
    bool s = await quiz_model.GetQuizzes();
    if(s){
      setState(() {
        _status = "done";
      });
    }else{
      setState(() {
        _status = "not done";
      });

    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
          title: Text('Quiz', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
          elevation: 0.0,
        ),







      body:(_status=="loading")?Container(child: Center(child: CircularProgressIndicator(),),):
      (_status=="done")?Consumer<Quiz_Model>(builder:(context, model, child){return (model.lengthQ==0)?Container(
        child:Container(child:Center(child:Text("No Quiz available for you!")))
      ):ListView.builder(
          shrinkWrap:true,itemCount:model.Quizzes.length,itemBuilder: (context, index) {
        return InkWell(onTap:() {
          Navigator.push(context, MaterialPageRoute(builder: (context) => edit_quiz(model.Quizzes[index])));
        },child:quiz_container(model.Quizzes[index]));
      });}):Container(child: Center(child:Text("Problem loading Quiz!") ,),));
  }

}