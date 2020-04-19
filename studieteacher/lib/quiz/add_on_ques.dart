import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studieteacher/basic/basics.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/Quiz_model.dart';
import 'package:studieteacher/models/current_q.dart';
import 'package:studieteacher/quiz/question_mcq.dart';
import 'package:studieteacher/quiz/quiz_tf.dart';
import 'package:studieteacher/quiz/single_ans.dart';

class add_on_ques extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateAdd_on();

}

class _stateAdd_on extends State<add_on_ques> {

  int _current = 0;
  static GlobalKey<ScaffoldState> _key = new GlobalKey();
  List<Widget> _screen = [question_mcq(_key),true_false(_key),single_ans_add(_key)];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _key,
      appBar: AppBar(
        elevation: 0.0,
        leading: Consumer<current_q_model>(builder:(context, model, child){return RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {
          model.ClearQuestion();
          Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) );}),
        title: Consumer<Quiz_model>(builder:(context, model, child){
          var current = model.Questions_n;
          return Text('Add Q $current', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),);}))
      ,body:ListView(children: <Widget>[
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
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child:Text('Add Question Description', style: TextStyle(color:Colors.black, fontSize: 24, fontWeight: FontWeight.bold),)
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child:Container(
                  alignment: Alignment.centerRight,
                  height:50,
                  width: 50,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color:Colors.greenAccent),
                )
              )

            ],
          ),
        ),
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
                    child:Consumer<current_q_model>(builder:(context, model, child){return TextField(
                      onChanged: (v) {
                        model.ChangeTitle(v);
                      },
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color:Colors.pinkAccent, fontSize: 22),
                        hintText: "Add a title",
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none)
                    ),);}),
                ),
              ),
              //TODO: Inkwell to be added with popup
              Flexible(
                  fit: FlexFit.loose,
                  child:InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Container(

                                  child:Consumer<current_q_model>(builder: (context, model, child){
                                    return Dialog(
                                        backgroundColor: Colors_pack.color,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                            side: BorderSide.none),
                                        child: Container(child:Stack(
                                          overflow: Overflow.visible,
                                          children: <Widget>[
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Flexible(
                                                    flex:5,
                                                    child: Container(
                                                      height: 70,
                                                      width:130,
                                                      child: RaisedButton(
                                                        elevation: 0.0,
                                                        child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children:[
                                                              Image(image: AssetImage("assets/upload3.png"),height: 50,width: 50,),
                                                              Text(
                                                                'Document',
                                                                style: TextStyle(
                                                                    color: Colors.white),
                                                              )]),
                                                        onPressed: () async {
                                                          File document = await  FilePicker.getFile();
                                                          print(document.path);
                                                          model.ChangeFile(document);
                                                        },
                                                        disabledColor:
                                                        Colors_pack.color,
                                                        color: Colors_pack.color,
                                                      ),)),
                                                Flexible(
                                                    child:Container(
                                                      height:100,
                                                      child:Container(),
                                                    )
                                                ),
                                                Flexible(
                                                    flex:5,
                                                    child: Container(
                                                      height: 70,
                                                      width:130,
                                                      child: RaisedButton(
                                                        elevation: 0.0,
                                                        child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children:[
                                                              Image(image: AssetImage("assets/upload2.png"),height: 50,width: 50,),
                                                              Text(
                                                                'Camera',
                                                                style: TextStyle(
                                                                    color: Colors.white),
                                                              )]),
                                                        onPressed: () async{
                                                          File document = await  FilePicker.getFile();
                                                          print(document.path);
                                                          model.ChangeFile(document);
                                                        },
                                                        disabledColor:
                                                        Colors_pack.color,
                                                        color: Colors_pack.color,
                                                      ),)),
                                                Flexible(
                                                    child:Container(
                                                      height:100,
                                                      child:Container(),
                                                    )
                                                ),
                                                Flexible(
                                                    flex:5,
                                                    child: Container(
                                                      height: 70,
                                                      width:100,
                                                      child: RaisedButton(
                                                        elevation: 0.0,
                                                        child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children:[
                                                              Image(image: AssetImage("assets/camera_upload.png"),height: 50,width: 50,),
                                                              Text(
                                                                'Upload',
                                                                style: TextStyle(
                                                                    color: Colors.white),
                                                              )]),
                                                        onPressed: () async{
                                                          File document = await  FilePicker.getFile();
                                                          print(document.path);
                                                          model.ChangeFile(document);
                                                        },
                                                        disabledColor:
                                                        Colors_pack.color,
                                                        color: Colors_pack.color,
                                                      ),)),

                                              ],
                                            ),
                                            Positioned(
                                                left: 0.0,
                                                bottom: -50.0,
                                                child: RaisedButton(
                                                    shape: CircleBorder(
                                                        side: BorderSide.none),
                                                    disabledColor: Colors_pack.color,
                                                    color: Colors_pack.color,
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                    )))
                                          ],
                                        ),
                                        ));}));
                            });
                      },
                      child:Container(
                    alignment: Alignment.centerRight,
                    height:50,
                    width: 50,
                    decoration: BoxDecoration(shape: BoxShape.circle, color:Colors_pack.color),
                    child: Center(child:Icon(Icons.add, size: 40, color: Colors.white,)),
                  )
              ))

            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          child: Text('Select answer type', style: TextStyle(color:Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //TODO: Will be sized boxes with fixed sizes
              Flexible(
                fit: FlexFit.loose,
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      _current = 0;
                    });

                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color:(_current == 0)?Colors_pack.color:Colors.grey,
                  padding: EdgeInsets.only(left:30, right:30, top:10, bottom:10),
                  child:Text('MCQ', style: TextStyle(color: Colors.white, fontSize: 24),)
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      setState(() {
                        _current = 1;
                      });

                    },
                    color:(_current==1)?Colors_pack.color:Colors.grey,
                    padding: EdgeInsets.only(left:30, right:30, top:10, bottom:10),
                    child:Text('T/F', style: TextStyle(color: Colors.white, fontSize: 24),)
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        _current = 2;
                      });
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: (_current == 2)?Colors_pack.color:Colors.grey,
                    padding: EdgeInsets.only(left:30, right:30, top:13, bottom:13),
                    child:Text('Number',maxLines: 1, style: TextStyle(color: Colors.white, fontSize: 18),)
                ),
              )

            ],
          ),

        ),
       _screen[_current],


      ],) ,
    );
  }

}