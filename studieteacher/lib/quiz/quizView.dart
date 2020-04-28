import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:studieteacher/quiz/question.dart';
import 'package:studieteacher/quiz/quiz.dart';
import 'package:http/http.dart' as http;


class ViewQuiz extends StatefulWidget {

  quiz current_quiz;
  ViewQuiz(this.current_quiz);
  @override
  State<StatefulWidget> createState() => _stateView(current_quiz);



}

class _stateView extends State<ViewQuiz>{
  int index = 0;
  quiz currentQuiz;
  Uint8List quizfile;
  bool load = true;
  _stateView(this.currentQuiz);

  void getImage() async{
    setState(() {
      load = true;
    });
    question c = currentQuiz.quizQuestions[index];
    if(c.Status.toLowerCase() == "true") {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String code = pref.getString("user");
      Uri uri = Uri.https(
          "studie-server-dot-project-student-management.appspot.com",
          "/teacher/quiz/q", {
        "id": currentQuiz.Id,
        "q": index.toString()
      });
      var res = await http.get(uri, headers: {
        "x-access-token": code,
        "type": "teacher"
      });
      setState(() {
        quizfile = res.bodyBytes;
        load = false;
      });
    }else{
      setState(() {
        quizfile = null;
        load = false;
      });

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImage();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var slider_basic = CarouselSlider.builder(
        height: double.maxFinite,
        viewportFraction: 1.0,
        onPageChanged: (item){
          setState(() {
            index = item;

          });
          getImage();
        },
        scrollDirection: Axis.horizontal,
        itemCount: int.parse(currentQuiz.TotalQuestion), itemBuilder: (context, item) {
          question q = currentQuiz.quizQuestions[item];
        return Container(
            child:ListView(
              children: <Widget>[
                Container(
                    height: 400,
                    child:
                Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[

                        Center(
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                (load)?LinearProgressIndicator():Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  height:200,
                                  width: 200,
                                  
                                  child: (quizfile == null)?Center(
                                    child: Text(
                                      "No Image Available",
                                      style: TextStyle(
                                        color:Colors.white,
                                        fontSize: 18
                                      ),
                                    ),
                                  ):Image.memory(quizfile),


                                ),
                                Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child:Text(q.quesTitle, style: TextStyle(color:Colors.white, fontSize: 22),)
                                )
                              ],
                            )
                        ),

                      ],
                    ))
                ,Container(
                      height:400,
                      margin: EdgeInsets.only(bottom: 20),
                      child:Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Positioned(
                              top: -20.0,
                              left:30.0,
                              child:InkWell(
                                  child:Container(
                                    height:50,
                                    width:120,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color:Colors.pinkAccent,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                        child:Text(currentQuiz.Minutes+":"+currentQuiz.Seconds, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),)
                                    ),
                                  )

                              )),
                          Positioned(
                              top: -20.0,
                              right:30.0,
                              child:InkWell(
                                  child:Container(
                                    height:50,
                                    width:120,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color:Colors.pinkAccent,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                        child:Text('Edit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),)
                                    ),
                                  )

                              )),

                          (q.answers.isEmpty)?Container(
                            child:Center(
                              child:Text("Answer is -: "+
                                q.correct_a.toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              )
                            )
                          ):Center(
                            child:Container(
                                child:ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: q.TotalAnswer,
                              itemBuilder: (context, ind) {
                                var a = q.quizAnswers;
                                return Container(
                                  margin:EdgeInsets.all(10),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color:(q.quizCorrect.compareTo(a[ind])==0)?Colors_pack.color:Colors.grey[300]
                                  ),
                                  child:Text(a[ind],style: TextStyle(fontWeight:FontWeight.bold,color:Colors.pinkAccent, fontSize: 22),)
                                );

                              },
                            )
                          ))


                        ],
                      ),
                      color:Colors.white,
                    ),


              ],
            )
        );});
    return Scaffold(
      extendBody: true,
      bottomSheet: Container(height:70,child:RaisedButton(color:Colors_pack.color,
          disabledColor:Colors_pack.color,
          onPressed: () {slider_basic.nextPage(duration:Duration(milliseconds: 500),curve: Curves.linear);},
          child:Center(child:
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
            Text('Next', style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),Icon(Icons.arrow_forward, color: Colors.white, size: 40,)])))),
      backgroundColor: Colors_pack.color,
      appBar: AppBar(
        actions: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(horizontal:10,vertical: 5),
              height:25,
              child:ListView.builder(scrollDirection:Axis.horizontal,shrinkWrap:true, itemCount:int.parse(currentQuiz.TotalQuestion),itemBuilder: (context, item) {
            return Container(
              width:25,
              height: 20,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color:(item==index)?Colors_pack.color:Colors.grey[300],
                borderRadius: BorderRadius.circular(10)
              ),
              child:Center(child:Text(item.toString(), style: TextStyle(fontWeight:FontWeight.w700,fontSize: 16, color:(item==index)?Colors.white:Colors_pack.color),)
            ));
          })),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.all(10),
            child:Text('..', style:TextStyle(fontWeight: FontWeight.w900, fontSize: 34, color:Colors.white))
          )
        ],
        elevation: 0.0,
        backgroundColor: Colors_pack.color,
        leading: RaisedButton(onPressed:() {Navigator.pop(context);},color:Colors_pack.color,disabledColor:Colors_pack.color,child: Icon(Icons.cancel, color: Colors.white,size: 40,),)),
       body: slider_basic,

    );
  }

}