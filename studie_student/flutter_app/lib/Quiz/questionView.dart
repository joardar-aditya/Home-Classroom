import 'package:flutter/material.dart';
import 'package:flutterapp/model/Question.dart';
import 'package:flutterapp/model/current_q.dart';
import 'package:provider/provider.dart';

//QuestionView
class questionView extends StatelessWidget {

  Question _current;
  questionView(this._current);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    print(_current.Options.toString());
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
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              height:200,
                              width: 200,

                            ),
                            Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child:Text(_current.Title, style: TextStyle(color:Colors.white, fontSize: 22),)
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
                                child:Text('00:00', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),)
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
                                child:Text('Best of Luck', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),)
                            ),
                          )

                      )),

                  Consumer<current_q>(builder:(context, model, child) { return Center(
                      child:Container(
                          child:ListView.builder(
                            shrinkWrap: true,
                            itemCount: _current.Options.length,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context,i) {return
                              InkWell(
                                  onTap: () {model.Change_selected(_current.Options[i]);},
                                  child:Container(
                                  margin:EdgeInsets.all(10),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color:Colors.grey[300]
                                  ),
                                  child:Text(_current.Options[i],style: TextStyle(fontWeight:FontWeight.bold,color:Colors.pinkAccent, fontSize: 22),)
                              ));},
                          )
                      ));})


                ],
              ),
              color:Colors.white,
            ),


          ],
        )
    );
  }

}