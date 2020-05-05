import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/Quiz_model.dart';
import 'package:studieteacher/models/current_q.dart';
import 'package:studieteacher/quiz/Question.dart';
import 'package:studieteacher/quiz/question.dart';


class question_mcq extends StatefulWidget {

  GlobalKey<ScaffoldState> _key;
  question_mcq(this._key);
  @override
  State<StatefulWidget> createState() => _statemcq(_key);

}

class _statemcq extends State<question_mcq> {
  GlobalKey<ScaffoldState> _key;
  _statemcq(this._key);
  var correct_a = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(
            margin: EdgeInsets.all(10),
            child:Text('Select the right options', style: TextStyle(fontWeight:FontWeight.bold,color:Colors.pinkAccent, fontSize: 20),)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child:Container(margin:EdgeInsets.all(10),child:Text('Answer 01', style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w900, fontSize: 32),),
            )),
          Container(
    alignment: Alignment.centerRight,
    height:50,
    width: 50,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color:Colors.greenAccent),
    )
    ,Container(
              margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:(correct_a==0)?Colors_pack.color:Colors.grey
                ),
                child:IconButton(onPressed:() {
                 setState(() {
                   correct_a = 0;

                 });
            },color:Colors.grey,icon: Icon(Icons.done, color:(correct_a==0)?Colors.white:Colors.black, size: 24,),)),
        ],),
        Container(
          margin: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                flex:4, fit: FlexFit.loose,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child:Consumer<current_q_model>(builder:(context, model, child){
                    return TextField(
                    onChanged: (value) {
                      model.AddOption(value, 0);
                    },
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color:Colors.pinkAccent, fontSize: 22),
                      hintText: "Add Answer",
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none)
                  ),);}),
                ),
              ),
              //TODO: Inkwell to be added with popup
              Flexible(
                  fit: FlexFit.loose,
                  child:Container(
                    alignment: Alignment.centerRight,
                    height:50,
                    width: 50,
                    decoration: BoxDecoration(shape: BoxShape.circle, color:Colors_pack.color),
                    child: Center(child:Icon(Icons.add, size: 40, color: Colors.white,)),
                  )
              )

            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child:Container(margin:EdgeInsets.all(10),child:Text('Answer 02', style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w900, fontSize: 32),),
                )),
            Container(
              alignment: Alignment.centerRight,
              height:50,
              width: 50,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color:Colors.greenAccent),
            )
            ,Container(
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:(correct_a==1)?Colors_pack.color:Colors.grey
                ),
                child:IconButton(onPressed:() {
                  setState(() {
                    correct_a = 1;

                  });
                },color:Colors.grey,icon: Icon(Icons.done, color:(correct_a==1)?Colors.white:Colors.black, size: 24,),)),
          ],),
        Container(
          margin: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                flex:4, fit: FlexFit.loose,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child:Consumer<current_q_model>(builder:(context, model, child){
                    return TextField(
                      onChanged: (value) {
                        model.AddOption(value, 1);
                      },
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color:Colors.pinkAccent, fontSize: 22),
                          hintText: "Add Answer",
                          filled: true,
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none)
                      ),);}),
                ),
              ),
              //TODO: Inkwell to be added with popup
              Flexible(
                  fit: FlexFit.loose,
                  child:Container(
                    alignment: Alignment.centerRight,
                    height:50,
                    width: 50,
                    decoration: BoxDecoration(shape: BoxShape.circle, color:Colors_pack.color),
                    child: Center(child:Icon(Icons.add, size: 40, color: Colors.white,)),
                  )
              )

            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child:Container(margin:EdgeInsets.all(10),child:Text('Answer 03', style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w900, fontSize: 32),),
                )),
            Container(
              alignment: Alignment.centerRight,
              height:50,
              width: 50,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color:Colors.greenAccent),
            )
            ,Container(
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:(correct_a==2)?Colors_pack.color:Colors.grey
                ),
                child:IconButton(onPressed:() {
                  setState(() {
                    correct_a = 2;

                  });
                },color:Colors.grey,icon: Icon(Icons.done, color:(correct_a==2)?Colors.white:Colors.black, size: 24,),)),
          ],),
        Container(
          margin: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                flex:4, fit: FlexFit.loose,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child:Consumer<current_q_model>(builder:(context, model, child){
                    return TextField(
                      onChanged: (value) {
                        model.AddOption(value, 2);
                      },
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color:Colors.pinkAccent, fontSize: 22),
                          hintText: "Add Answer",
                          filled: true,
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none)
                      ),);}),
                ),
              ),
              //TODO: Inkwell to be added with popup
              Flexible(
                  fit: FlexFit.loose,
                  child:Container(
                    alignment: Alignment.centerRight,
                    height:50,
                    width: 50,
                    decoration: BoxDecoration(shape: BoxShape.circle, color:Colors_pack.color),
                    child: Center(child:Icon(Icons.add, size: 40, color: Colors.white,)),
                  )
              )

            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child:Container(margin:EdgeInsets.all(10),child:Text('Answer 04', style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w900, fontSize: 32),),
                )),
            Container(
              alignment: Alignment.centerRight,
              height:50,
              width: 50,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color:Colors.greenAccent),
            )
            ,Container(
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:(correct_a==3)?Colors_pack.color:Colors.grey
                ),
                child:IconButton(onPressed:() {
                  setState(() {
                    correct_a = 3;

                  });
                },color:Colors.grey,icon: Icon(Icons.done, color:(correct_a==3)?Colors.white:Colors.black, size: 24,),)),
          ],),
        Container(
          margin: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                flex:4, fit: FlexFit.loose,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child:Consumer<current_q_model>(builder:(context, model, child){
                    return TextField(
                      onChanged: (value) {
                        model.AddOption(value, 3);
                      },
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color:Colors.pinkAccent, fontSize: 22),
                          hintText: "Add Answer",
                          filled: true,
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none)
                      ),);}),
                ),
              ),
              //TODO: Inkwell to be added with popup
              Flexible(
                  fit: FlexFit.loose,
                  child:Container(
                    alignment: Alignment.centerRight,
                    height:50,
                    width: 50,
                    decoration: BoxDecoration(shape: BoxShape.circle, color:Colors_pack.color),
                    child: Center(child:Icon(Icons.add, size: 40, color: Colors.white,)),
                  )
              )

            ],
          ),
        ),
        Container(
            margin: EdgeInsets.all(20),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.start,

              children: <Widget>[
                SizedBox(
                  child:Consumer2<current_q_model, Quiz_model>(builder:(context, model1, model2, child){return RaisedButton(

                    onPressed: () {
                      if(model1.Title==""&&model1.GetFile==null){
                        _key.currentState.showSnackBar(SnackBar(content: Text("Please Add File and title")));
                      }else{
                        model1.AddCorrect(model1.Options[correct_a]);
                        Question current = model1.give_me_question();
                        model2.AddQuestion(current);
                        model1.ClearQuestion();

                        Navigator.pop(context);}
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: Colors_pack.color,
                    padding: EdgeInsets.all(10),
                    child: Text('Done', style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize: 24),),
                  );}),
                  width: 100,
                  height: 50,
                )
              ],
            )
        )

      ],
    );
  }

}