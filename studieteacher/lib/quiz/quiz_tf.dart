
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/Quiz_model.dart';
import 'package:studieteacher/models/current_q.dart';

import 'Question.dart';

class true_false extends StatefulWidget {
  GlobalKey<ScaffoldState> _key;
  true_false(this._key);
  @override
  State<StatefulWidget> createState() {


    // TODO: implement createState
    return _stateC(_key);
  }

}

class _stateC extends State<true_false> {
  var variable = true;
  GlobalKey<ScaffoldState> _key;
  _stateC(this._key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(
            margin: EdgeInsets.all(20),
            child:Text('Select true or false', style: TextStyle(fontWeight:FontWeight.bold,color:Colors.pinkAccent, fontSize: 20),)),
        Container(
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child: Consumer<current_q_model>(builder: (context,model, child){return RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    model.AddCorrect('\"True\"');
                    setState(() {
                      variable = true;
                    });
                  },
                  color: variable?Colors_pack.color:Colors.grey,
                  child: Text('True', style: TextStyle(fontWeight:FontWeight.bold,color:variable?Colors.white:Colors.black, fontSize: 24),),

                )
              ;})),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child: Consumer<current_q_model>(builder: (context,model, child){return RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    model.AddCorrect('\"False\"');
                    setState(() {
                      variable = false;
                    });
                  },
                  color: !variable?Colors_pack.color:Colors.grey,
                  child: Text('False', style: TextStyle(fontWeight:FontWeight.bold,color:!variable?Colors.white:Colors.black, fontSize: 24),),

                )
                ;})
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
                        model1.MakeTF();
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