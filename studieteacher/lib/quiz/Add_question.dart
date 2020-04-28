import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/basic/basics.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/Quiz_model.dart';
import 'package:studieteacher/models/main_model.dart';
import 'package:studieteacher/quiz/Question.dart';
import 'package:studieteacher/quiz/add_on_ques.dart';
import 'package:http/http.dart' as http;
import 'package:studieteacher/quiz/quizstart.dart';

class add_question extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateAdd_ques();



}

class _stateAdd_ques extends State<add_question> {

  GlobalKey<ScaffoldState> _key = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _key,
      appBar: AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Add Questions', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Text('Select the time limit', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),),
          ),
          Consumer<Quiz_model>(builder: (context, model, child){
             var Minu = model.Minutes;
             var Sec = model.Seconds;
            return Container(
            margin: EdgeInsets.all(10),
            child: Text('$Minu M $Sec S', style: TextStyle(color: Colors_pack.color, fontWeight: FontWeight.bold, fontSize: 27),),
          );}),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[Column(
                children: <Widget>[
                  Text('Minutes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  Consumer<Quiz_model>(builder:(context, model, child){
                    var Minutes = model.Minutes;
                    return Container(margin:EdgeInsets.symmetric(horizontal: 5),child:RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      disabledColor:Colors.grey[300],
                      child:Center(child:Text('$Minutes', style: TextStyle(color:Colors.black,fontSize: 32, fontWeight: FontWeight.bold), ))));}),
                  Consumer<Quiz_model>(builder:(context, model, child){return Row(mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      InkWell(
                          onTap: () {
                            model.AddMinutes();
                          },
                          child:Container(decoration:BoxDecoration(shape: BoxShape.circle, color: Colors_pack.color),child:Icon(Icons.add, color: Colors.white,))),
                      InkWell(
                        onTap: () {
                        model.SubMinutes();
                  },
                        child:Container(margin:EdgeInsets.only(left: 3),decoration:BoxDecoration(shape: BoxShape.circle, color: Colors_pack.color),child:Icon(Icons.remove, color: Colors.white,)),
                      )],);})

                ],
              ),
                Column(
                  children: <Widget>[
                    Text('Seconds', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    Consumer<Quiz_model>(builder:(context, model, child){
                      var Seconds = model.Seconds;
                      return
                      Container(margin:EdgeInsets.symmetric(horizontal: 5),child:RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        disabledColor:Colors.grey[300],
                        child:Center(child:Text('$Seconds', style: TextStyle(color:Colors.black,fontSize: 32, fontWeight: FontWeight.bold), ))));}),
                    Consumer<Quiz_model>(builder:(context, model, child){return
                      Row(mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                       InkWell(
                         onTap:() {
                            model.AddSeconds();

                    },
                           child:Container(margin:EdgeInsets.only(right: 3),decoration:BoxDecoration(shape: BoxShape.circle, color: Colors_pack.color),child:Icon(Icons.add, color: Colors.white,))),
                        InkWell(
                            onTap: () {
                              model.SubSeconds();
                            },
                            child:Container(decoration:BoxDecoration(shape: BoxShape.circle, color: Colors_pack.color),child:Icon(Icons.remove, color:Colors.white)),
                        )],);})

                  ],
                ),Container(
                  child:RaisedButton(
                    disabledColor: Colors_pack.color,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child:Center(child: Text('Done', style: TextStyle(color:Colors.white, fontSize: 22),),)
                  )
                )],
            )
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 50,
                width: 200,
                margin: EdgeInsets.all(10),
                child: RaisedButton(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color:Colors_pack.color,
                    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => add_on_ques()));},
                    disabledColor: Colors_pack.color,padding: EdgeInsets.all(10),
                  child:Row(children: <Widget>[
                    Container(margin: EdgeInsets.only(right: 3),child: Icon(Icons.add, color: Colors.white, size: 20,),),
                    Text('Add a question', style: TextStyle(color:Colors.white, fontSize: 20),)
                  ],)
                )
              )
            ],
          ),
          Container(
            margin: EdgeInsets.all(10),
            child:Consumer<Quiz_model>(builder: (context,model,child){
              return Container(
              child:GridView.count(shrinkWrap:true,crossAxisCount:3,
              children: List.generate(int.parse(model.Questions_n), (index) {
                return Container(
                  decoration: BoxDecoration(
                    color:Colors_pack.color,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  margin: EdgeInsets.all(10),
                  child:Center(
                    child:Text('Q 0$index', style: TextStyle(fontWeight:FontWeight.bold,color: Colors.white, fontSize: 32),),
                  )
                );
              }),))
            ;})
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: 50,
                  width: 150,
                  margin: EdgeInsets.all(10),
                  child: Consumer2<Quiz_model, main_model>(builder:(context, model, model2,  child){return RaisedButton(
                      onPressed: () async{
                        //Adding Quiz
                        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                        String code = sharedPreferences.getString("user");
                        String type = "teacher";
                        String tcode = sharedPreferences.getString("tcode");
                        String icode = sharedPreferences.getString("icode");
                        String tname = sharedPreferences.getString("name");
                        String classes = model2.Classes;
                        String section = model2.section;
                        Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/quiz/$icode/$classes/$section".toLowerCase());
                        print(uri);
                        var _request = await http.MultipartRequest('POST', uri);
                        _request.fields["tcode"] = tcode;
                        _request.fields["tname"] = tname;
                        _request.fields["dueDate"] = DateTime.now().toIso8601String();
                        _request.fields["syllabus"] = model.Chapters.toString();
                        print(model.Chapters.toString());
                        _request.fields["subject"] = model2.Current_Subject;
                        _request.fields["title"] = model.Title;
                        _request.fields["qTime"] = model.DueDate;
                        List<Question> questions = model.GetQuestions;
                        List<String> q = [];
                        for(int i=0; i<questions.length; i++){
                          if(questions[i].file!=null){
                            var file = await http.MultipartFile.fromPath('fileq$i', questions[i].file.path, contentType:MediaType.parse("image/png"));
                          _request.files.add(file);}
                          q.add(questions[i].thedoc);
                          print(questions[i].thedoc);
                        }
                        _request.fields["questions"] = q.toString();
                        _request.headers["x-access-token"] = code;
                        _request.headers["type"] = "teacher";
                        var res = await _request.send();
                        var res_b = await res.stream.bytesToString();
                        print(res_b.toString());
                        if(res.statusCode ==200){
                          var j = jsonDecode(res_b);
                          if(j["status"]=="success"){
                              _key.currentState.showSnackBar(SnackBar(content: Text("Quiz Uploaded Successfully"),));
                              model.ClearQuiz();
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => quizstart()));
                          }else{
                            _key.currentState.showSnackBar(SnackBar(content:Text("Quiz not Uploaded")));
                          }
                        }else{
                          _key.currentState.showSnackBar(SnackBar(content: Text("Quiz not uploaded, please check your internet"),));
                        }
















                      },

                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),color: Colors_pack.color,padding: EdgeInsets.all(10),
                      child:
                        Text('Add Quiz', style: TextStyle(color:Colors.white, fontSize: 20),)
                  );})
              )
            ],
          ),
        ],
      ),
    );
  }

}