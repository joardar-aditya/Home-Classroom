import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/Quiz_model.dart';
import 'package:studieteacher/models/exam_add_model.dart';

class chapter_container extends StatefulWidget{
  var _text;
  chapter_container(this._text);
  @override
  State<StatefulWidget> createState() => _stateC(_text);

}

class _stateC extends State<chapter_container> {
  var _text;
  _stateC(this._text);
  var _tapped;

  @override
  void initState() {
    // TODO: implement initState
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<exam_add_model>(builder:(context, model, child){ return InkWell(
      onTap: () {
        setState(() {
          model.add_chapters(_text);
        });
      },
        child:Container(
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color:model.chapters.containsKey(_text)?Colors.pinkAccent:Colors_pack.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child:Text(
          _text, style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold,
            fontSize: 24),
        )
    ));});
  }

}