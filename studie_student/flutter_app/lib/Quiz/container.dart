import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/model/Quiz.dart';

class quiz_container extends StatelessWidget {
  Quiz _current;
  quiz_container(this._current);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors_pack.color,
      borderRadius: BorderRadius.circular(10)),
      child: Container(padding:EdgeInsets.all(5),child:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(fit:FlexFit.loose,child:
          Row(
            children: <Widget>[
              Expanded(
                child: Container(child:Text(_current.Subject,textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),),

              )),
              Expanded(
                child:Container(alignment:Alignment.centerRight,child:Text(_current.Author, textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),)
              ))
            ],
          )),
          Flexible(fit:FlexFit.loose,child:
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(margin:EdgeInsets.symmetric(vertical: 3),child:Text(_current.Syllabus.substring(1,_current.Syllabus.length-1),textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 21),),

                  )),
              Expanded(
                  child:Container(margin:EdgeInsets.symmetric(vertical: 3),alignment:Alignment.centerRight,child:Text("Class 1 Sec a", textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold),)
                  ))
            ],
          )),

          Flexible(fit:FlexFit.loose,child:
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(margin:EdgeInsets.symmetric(vertical: 10),child:Text(_current.Title,textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 36),),

                  )),
            ],
          )),
          Flexible(fit:FlexFit.loose,child:
          Row(
            children: <Widget>[

              Expanded(
                  child:Container(alignment:Alignment.centerRight,child:Text(_current.String_time, textAlign: TextAlign.right, style: TextStyle(color: Colors.yellow, fontSize: 18, fontWeight: FontWeight.bold),)
                  ))
            ],
          )),

        ],
      ),
    ));
  }

}

class container_inner_quiz extends StatelessWidget {

  Quiz _cu;
  container_inner_quiz(this._cu);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10)),
        child: Container(padding:EdgeInsets.all(5),child:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(fit:FlexFit.loose,child:
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(child:Text(_cu.Subject,textAlign: TextAlign.left, style: TextStyle(color: Colors_pack.color, fontWeight: FontWeight.bold, fontSize: 24),),

                    )),
                Expanded(
                    child:Container(alignment:Alignment.centerRight,child:Text(_cu.Author, textAlign: TextAlign.right, style: TextStyle(color: Colors_pack.color, fontSize: 24, fontWeight: FontWeight.bold),)
                    ))
              ],
            )),
            Flexible(fit:FlexFit.loose,child:
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(margin:EdgeInsets.symmetric(vertical: 3),child:Text(_cu.Syllabus.substring(1,_cu.Syllabus.length-1),textAlign: TextAlign.left, style: TextStyle(decoration:TextDecoration.underline,color: Colors_pack.color, fontWeight: FontWeight.bold, fontSize: 21),),

                    )),
                Expanded(
                    child:Container(margin:EdgeInsets.symmetric(vertical: 3),alignment:Alignment.centerRight,child:Text("Class 1 Sec a", textAlign: TextAlign.right, style: TextStyle(color: Colors_pack.color, fontSize: 21, fontWeight: FontWeight.bold),)
                    ))
              ],
            )),

            Flexible(fit:FlexFit.loose,child:
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(margin:EdgeInsets.symmetric(vertical: 10),child:Text(_cu.Title,textAlign: TextAlign.left, style: TextStyle(color: Colors_pack.color,fontSize: 36),),

                    )),
              ],
            )),
            Flexible(fit:FlexFit.loose,child:
            Row(
              children: <Widget>[

                Expanded(
                    child:Container(alignment:Alignment.centerRight,child:Text(_cu.String_time, textAlign: TextAlign.right, style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),)
                    ))
              ],
            )),

          ],
        ),
        ));
  }

}