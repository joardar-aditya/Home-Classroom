import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/Quiz_model.dart';
import 'package:studieteacher/models/exam_add_model.dart';

class chapter_container_quiz extends StatefulWidget{
  var _text;
  chapter_container_quiz(this._text);
  @override
  State<StatefulWidget> createState() => _stateC(_text);

}

class _stateC extends State<chapter_container_quiz> {
  var _text;
  _stateC(this._text);
  var _tapped = false;

  @override
  void initState() {
    // TODO: implement initState
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<Quiz_model>(builder:(context, model, child){ return InkWell(
        onTap: () {
          setState(() {
            model.add_chapters(_text);
            _tapped = !_tapped;
          });
        },
        child:Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:model.Chapters.contains("\"$_text\"")?Colors.pinkAccent:Colors_pack.color,
              borderRadius: BorderRadius.circular(10),
            ),
            child:Text(
              _text, style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold,
                fontSize: 24),
            )
        ));});
  }

}