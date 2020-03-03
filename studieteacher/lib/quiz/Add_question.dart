import 'package:flutter/material.dart';
import 'package:studieteacher/basic/basics.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/quiz/add_on_ques.dart';

class add_question extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateAdd_ques();



}

class _stateAdd_ques extends State<add_question> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:AppBar(
        title: basics("Add Questions"),
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Text('Select the time limit', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text('00 M 00 S', style: TextStyle(color: Colors_pack.color, fontWeight: FontWeight.bold, fontSize: 27),),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[Column(
                children: <Widget>[
                  Text('Minutes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  Container(margin:EdgeInsets.symmetric(horizontal: 5),child:RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      disabledColor:Colors.grey[300],
                      child:Center(child:Text('00', style: TextStyle(color:Colors.black,fontSize: 32, fontWeight: FontWeight.bold), )))),
                  Row(mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(decoration:BoxDecoration(shape: BoxShape.circle, color: Colors_pack.color),child:Icon(Icons.add, color: Colors.white,)),
                      Container(margin:EdgeInsets.only(left: 3),decoration:BoxDecoration(shape: BoxShape.circle, color: Colors_pack.color),child:Icon(Icons.add, color: Colors.white,)),
                    ],)

                ],
              ),
                Column(
                  children: <Widget>[
                    Text('Seconds', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    Container(margin:EdgeInsets.symmetric(horizontal: 5),child:RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        disabledColor:Colors.grey[300],
                        child:Center(child:Text('00', style: TextStyle(color:Colors.black,fontSize: 32, fontWeight: FontWeight.bold), )))),
                    Row(mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                       Container(decoration:BoxDecoration(shape: BoxShape.circle, color: Colors_pack.color),child:Icon(Icons.add, color: Colors.white,)),
                        Container(margin:EdgeInsets.only(left: 3),decoration:BoxDecoration(shape: BoxShape.circle, color: Colors_pack.color),child:Icon(Icons.add, color: Colors.white,)),
                      ],)

                  ],
                ),Container(
                  child:RaisedButton(
                    disabledColor: Colors_pack.color,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child:Center(child: Text('Done', style: TextStyle(color:Colors.white, fontSize: 22),),)
                  )
                )],
            )
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 50,
                width: 200,
                margin: EdgeInsets.all(10),
                child: RaisedButton(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color:Colors_pack.color,
                    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => add_on_ques()));},
                    disabledColor: Colors_pack.color,padding: EdgeInsets.all(10),
                  child:Row(children: <Widget>[
                    Container(margin: EdgeInsets.only(right: 3),child: Icon(Icons.add, color: Colors.white, size: 20,),),
                    Text('Add a question', style: TextStyle(color:Colors.white, fontSize: 20),)
                  ],)
                )
              )
            ],
          ),
          Container(
            margin: EdgeInsets.all(10),
            child:Container(
              child:GridView.count(shrinkWrap:true,crossAxisCount:3,
              children: List.generate(1, (index) {
                return Container(
                  decoration: BoxDecoration(
                    color:Colors.grey[300],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  margin: EdgeInsets.all(10),
                  child:Center(
                    child:Text('Q 0$index', style: TextStyle(fontWeight:FontWeight.bold,color: Colors.black, fontSize: 32),),
                  )
                );
              }),)
            )
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: 50,
                  width: 150,
                  margin: EdgeInsets.all(10),
                  child: RaisedButton(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),disabledColor: Colors_pack.color,padding: EdgeInsets.all(10),
                      child:
                        Text('Add Quiz', style: TextStyle(color:Colors.white, fontSize: 20),)
                  )
              )
            ],
          ),
        ],
      ),
    );
  }

}