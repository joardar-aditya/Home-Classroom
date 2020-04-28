import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studieteacher/basic/basics.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/chat_model.dart';
import 'package:studieteacher/models/current_q.dart';
import 'package:studieteacher/quiz/container.dart';
import 'package:studieteacher/quiz/quiz.dart';
import 'package:studieteacher/quiz/quizView.dart';
import 'package:studieteacher/quiz/results.dart';
import 'package:studieteacher/quiz/results.dart';

class edit_quiz extends StatefulWidget {

  quiz current_quiz;
  edit_quiz(this.current_quiz);
  @override
  State<StatefulWidget> createState() => _stateEdit(current_quiz);


}


class _stateEdit extends State<edit_quiz> {
  quiz current_quiz;
  int length;
  List<results> resul = [];
  _stateEdit(this.current_quiz);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    length = current_quiz.result_t.length;
    resul = current_quiz.result_t.map((e) => e).toList();
  }
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:  AppBar(
        elevation: 0.0,
        leading: Consumer<current_q_model>(builder:(context, model, child){return
          RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {
            Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) );}),
        title: Text('Add/ Edit a Quiz', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body:Container(
        margin: EdgeInsets.only(top:10, left:10, right:10),
        child: ListView(
          children: <Widget>[
            container_inner_quiz(current_quiz),
            Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
              Container(margin:EdgeInsets.all(10),child:SizedBox(width:140,height:50, child:RaisedButton(
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ViewQuiz(current_quiz)));},
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color:Colors_pack.color,
                disabledColor: Colors_pack.color,
                child: Row(
                  children: <Widget>[
                    Container(margin: EdgeInsets.symmetric(horizontal:5),child:Center(child:
                    Text('View Quiz', style: TextStyle(color: Colors.white, fontSize: 20),),))],
                ),
              ),
              ))]),
            Consumer<chat_model>(builder: (context, model, child) { return Container(
              margin: EdgeInsets.all(10),
              child: Text(current_quiz.students_part.length.toString() + ' students out of '+ model.students.length.toString()+ ' students have participated in the Quiz', style: TextStyle(color: Colors.pinkAccent, fontSize: 24),),
            );}),
            Container(
              margin: EdgeInsets.all(10),
              child: Container(
                child: Text('Results', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
              ),
            ),
            Container(
              height: 100,
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(flex:5,child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                      hintText: "Type the name of the student",
                      hintStyle: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  )),
                  Flexible(flex:2,child:
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      child: RaisedButton(
                          elevation:0.0,
                          color: Colors.white,
                          onPressed: () {
                            String cu = controller.text;
                            List<results> cur = [];
                            for(int j=0; j<current_quiz.result_t.length; j++){
                              if(current_quiz.result_t[j].name.toString().toLowerCase().startsWith(cu.toLowerCase())){
                                cur.add(current_quiz.result_t[j]);
                              }
                            }
                            setState(() {
                              resul = cur;
                            });
                          },
                          disabledColor: Colors.white,
                          child:Container(padding:EdgeInsets.all(5),
                            decoration:BoxDecoration(color: Colors_pack.color, shape: BoxShape.circle),
                            child: Icon(Icons.search, size: 40, color: Colors.white,),)),

                    )),
                ],
              ),
            ),
            (resul.isEmpty)?Container(child:Center(child:Text("No Submissions"))):ListView.builder(physics:ScrollPhysics(),shrinkWrap:true, scrollDirection:Axis.vertical, itemCount:length,itemBuilder: (context, ind) {

              results c = resul[ind];
              return Container(margin:EdgeInsets.all(10),child:Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(child:Container(
                    margin:EdgeInsets.symmetric(horizontal: 3),
                    child:Image(image:AssetImage('assets/ellipse-2.png'), width: 70, height: 70,)
                  )),
                  Flexible(
                    child: Container(
                      child:Text(c.resultname +"\n" + "${c.submit_time.day.toString()+ " " + c.submit_time.month.toString()+ " " + c.submit_time.year.toString()}", style: TextStyle(color:Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Flexible(
                    child:Container(
                      alignment: Alignment.centerRight,
                      child: Text(c.resultMarks, textAlign: TextAlign.right, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.pinkAccent),),
                    )
                  )
                ],
              ));
            })



          ],

      ),
    ));
  }

}