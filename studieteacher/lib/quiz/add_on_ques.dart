import 'package:flutter/material.dart';
import 'package:studieteacher/basic/basics.dart';
import 'package:studieteacher/colors/colors.dart';

class add_on_ques extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateAdd_on();

}

class _stateAdd_on extends State<add_on_ques> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(
        title: basics("Add Q 00"),
        elevation: 0.0,
      ) ,
      body:ListView(children: <Widget>[
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
                    child:TextField(decoration: InputDecoration(
                        hintStyle: TextStyle(color:Colors.pinkAccent, fontSize: 22),
                        hintText: "Add a title",
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none)
                    ),),
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.grey[300],
                  padding: EdgeInsets.only(left:30, right:30, top:10, bottom:10),
                  child:Text('MCQ', style: TextStyle(color: Colors_pack.color, fontSize: 24),)
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    disabledColor: Colors.grey[300],
                    padding: EdgeInsets.only(left:30, right:30, top:10, bottom:10),
                    child:Text('T/F', style: TextStyle(color: Colors_pack.color, fontSize: 24),)
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    disabledColor: Colors_pack.color,
                    padding: EdgeInsets.only(left:30, right:30, top:13, bottom:13),
                    child:Text('Number',maxLines: 1, style: TextStyle(color: Colors.white, fontSize: 18),)
                ),
              )

            ],
          ),

        ),
        Container(
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors_pack.color,
                  padding: EdgeInsets.all(10),
                  child: Text('Done', style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize: 24),),
                ),
                width: 100,
                height: 50,
              )
            ],
          )
        )
      ],) ,
    );
  }

}