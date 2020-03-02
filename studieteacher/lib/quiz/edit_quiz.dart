import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studieteacher/basic/basics.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/quiz/container.dart';
import 'package:studieteacher/quiz/quizView.dart';

class edit_quiz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateEdit();


}

class _stateEdit extends State<edit_quiz> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: basics("Edit/ View Quiz"),
        elevation: 0.0,
      ),
      body:Container(
        margin: EdgeInsets.only(top:10, left:10, right:10),
        child: ListView(
          children: <Widget>[
            container_inner_quiz(),
            Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
              Container(margin:EdgeInsets.all(10),child:SizedBox(width:140,height:50, child:RaisedButton(
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ViewQuiz()));},
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
            Container(
              margin: EdgeInsets.all(10),
              child: Text('03 students out of 04 students have participated in the Quiz', style: TextStyle(color: Colors.pinkAccent, fontSize: 24),),
            ),
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
                      child: RaisedButton(elevation:0.0,disabledColor: Colors.white,child:Container(padding:EdgeInsets.all(5),decoration:BoxDecoration(color: Colors_pack.color, shape: BoxShape.circle),child: Icon(Icons.search, size: 40, color: Colors.white,),)),

                    )),
                ],
              ),
            ),
            ListView.builder(physics:ScrollPhysics(),shrinkWrap:true, scrollDirection:Axis.vertical, itemCount:10,itemBuilder: (context, ind) {
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
                      child:Text('Aditya Jordan', style: TextStyle(color:Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Flexible(
                    child:Container(
                      alignment: Alignment.centerRight,
                      child: Text('05/05', textAlign: TextAlign.right, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.pinkAccent),),
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