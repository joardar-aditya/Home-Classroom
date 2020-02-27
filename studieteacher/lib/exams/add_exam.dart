import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class add_exam extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _state_add_exam();

}

class _state_add_exam extends State<add_exam>{

  final List<String> _classes = List<String>.generate(12, (index) => (index + 1).toString()).toList();
  final List<String> _sections = ["A", "B", "C", "D", "E", "F"];
  static String _currentClass = "5";
  static String _section = "A";

  void _changeSections(String v){
    setState(() {
      _section = v;
    });
  }

  void _changeClass(String valu) async{
    setState(() {
      _currentClass = valu;
    });
  }







  @override
  Widget build(BuildContext context) {

    
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Exam", style: TextStyle(color: Color(0xff261FFF), fontSize: 24, fontWeight: FontWeight.bold),),
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Container(margin:EdgeInsets.all(10),child:SizedBox(width: 200, height:50, child:RaisedButton(
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => add_exam()));},
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color:Colors_pack.color,
              disabledColor: Colors_pack.color,
              child: Row(
                children: <Widget>[Icon(Icons.add, color: Colors.white,size: 20,),
                  Container(margin: EdgeInsets.symmetric(horizontal:5),child:
                  Text('Select a Date', style: TextStyle(color: Colors.white, fontSize: 20),),)],
              ),
            ),
          ))]),
            Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
            SizedBox(width:200,height:70,child:
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10)
              ),
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text('1 JAN MON 2020', style: TextStyle(color: Colors_pack.color, fontSize: 18),),
              ),
            ))]),
          Container(
              margin: EdgeInsets.all(10),
              child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,

            children: <Widget>[
              FittedBox(fit:BoxFit.contain,child:Padding(padding:EdgeInsets.all(10),child:
              Text("Class", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 24),))),

              FittedBox(fit:BoxFit.contain,child:Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:
              DropdownButton<String>(
                value: _currentClass,
                onChanged: (String string) => _changeClass(string),
                underline: Container(),
                iconSize: 0,
                selectedItemBuilder: (BuildContext context) {
                  return _classes.map<Widget>((String item) {
                    return Container(
                        width: 80,
                        decoration: BoxDecoration(
                            color: Color(0xff261FFF),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child:Center(child: Text(item, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
                        ));
                  }).toList();
                },
                items: _classes.map((String item) {
                  return DropdownMenuItem<String>(
                    child: Text('$item'),
                    value: item,
                  );
                }).toList(),
              ),)) ,
              FittedBox(fit: BoxFit.contain,
                child:
              Padding(padding:EdgeInsets.all(10),child:
              Text("Sec", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 24),))),
             FittedBox(fit:BoxFit.contain,child:
              Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:
              DropdownButton<String>(
                value: _section,
                onChanged: (String string) => _changeSections(string),
                underline: Container(),
                iconSize: 0,
                selectedItemBuilder: (BuildContext context) {
                  return _sections.map<Widget>((String item) {
                    return Container(
                        width: 80,
                        decoration: BoxDecoration(
                            color: Color(0xff261FFF),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child:Center(child: Text(item.toString(), style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
                        ));
                  }).toList();
                },
                items: _sections.map((String item) {
                  return DropdownMenuItem<String>(
                    child: Text('$item'),
                    value: item,
                  );
                }).toList(),
              ),) ),


            ],
          )),
          Container(
            margin: EdgeInsets.all(10),
            child: Text('Exam Title', style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(64), fontWeight: FontWeight.bold),),
          ),
        Container(
              height: ScreenUtil().setHeight(150),
              margin:EdgeInsets.all(10),child:TextFormField(
              decoration: InputDecoration(
                fillColor: Colors.grey[300],
                filled: true,
                hintText: "Add a title",
                hintStyle: TextStyle(color: Colors.pinkAccent, fontSize:ScreenUtil().setSp(48)),
                border: OutlineInputBorder(borderSide: BorderSide(width:0.0, style: BorderStyle.none),borderRadius: BorderRadius.circular(10))
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text('Choose a subject', style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),),
          ),
         Container(
            margin: EdgeInsets.all(10),
            child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color:Colors_pack.color, disabledColor: Colors_pack.color, child:
            Container(alignment:Alignment.centerLeft,child:Text('Not Selected', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),))),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text('Add Syllabus', style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),),
          ),
          Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
            Container(margin:EdgeInsets.all(10),child:SizedBox(width: 200, height:50, child:RaisedButton(
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => add_exam()));},
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color:Colors_pack.color,
              disabledColor: Colors_pack.color,
              child: Row(
                children: <Widget>[Icon(Icons.add, color: Colors.white,size: 20,),
                  Container(margin: EdgeInsets.symmetric(horizontal:5),child:
                  Text('Add Chapters', style: TextStyle(color: Colors.white, fontSize: 20),),)],
              ),
            ),
            ))]),
      ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 1000),
          child:
        ListView.builder(shrinkWrap:true, physics:NeverScrollableScrollPhysics(),itemCount:4,itemBuilder: (context, item) {
              return Container(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      child:Text('Trigonometry', style: TextStyle(color:Colors.pinkAccent, fontSize: 24, fontWeight: FontWeight.bold),)
                    ),
                    Container(
                      height: ScreenUtil().setHeight(150),
                      margin:EdgeInsets.all(10),child:TextFormField(
                      decoration: InputDecoration(
                          fillColor: Colors.grey[300],
                          filled: true,
                          hintText: "Add a Description",
                          hintStyle: TextStyle(color: Colors.pinkAccent, fontSize:ScreenUtil().setSp(48)),
                          border: OutlineInputBorder(borderSide: BorderSide(width:0.0, style: BorderStyle.none),borderRadius: BorderRadius.circular(10))
                      ),
                    ),
                    ),

                  ],
                )
              );
            }
          ))



        ],
      ),

    );
  }

}