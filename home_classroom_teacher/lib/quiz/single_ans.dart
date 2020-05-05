import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/Quiz_model.dart';
import 'package:studieteacher/models/current_q.dart';

import 'Question.dart';


class single_ans_add extends StatefulWidget {

  GlobalKey<ScaffoldState> _key;
  single_ans_add(this._key);
  @override
  State<StatefulWidget> createState() => _stateS(_key);

}

class _stateS extends State<single_ans_add> {
  GlobalKey<ScaffoldState> _key;
  _stateS(this._key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer2<Quiz_model, current_q_model>(builder: (context, model1, model2, child){return ListView(shrinkWrap: true, physics: NeverScrollableScrollPhysics(),
    children: <Widget>[ Container(
      margin: EdgeInsets.all(20),
      child: Text('Enter the Number', style: TextStyle(color:Colors.pinkAccent, fontSize: 24, fontWeight: FontWeight.bold),),
    ),
      Container(
          margin: EdgeInsets.all(10),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Flexible(
                  flex:3, fit: FlexFit.loose,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child:TextField(
                      maxLines: 1,
                      onChanged: (v) {
                        model2.AddCorrect(v);
                      },
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color:Colors.pinkAccent, fontSize: 22),
                          hintText: "Enter a number",
                          filled: true,
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none)
                      ),),
                  ),
                ),Flexible(flex: 3, fit: FlexFit.loose, child: Container(),)])),
      Container(
          margin: EdgeInsets.all(20),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: <Widget>[
              SizedBox(
                child:RaisedButton(
                  onPressed: () {
                    if(model2.Title==""&&model2.GetFile==null){
                      _key.currentState.showSnackBar(SnackBar(content: Text("Please Add File and title")));
                    }else{
                    model2.MakeSingle();
                    Question current = model2.give_me_question();
                    model1.AddQuestion(current);
                    model2.ClearQuestion();

                    Navigator.pop(context);}
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: Colors_pack.color,
                  padding: EdgeInsets.all(10),
                  child: Text('Done', style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize: 24),),
                ),
                width: 100,
                height: 50,
              )
            ],
          )
      )

    ],);});
  }

}