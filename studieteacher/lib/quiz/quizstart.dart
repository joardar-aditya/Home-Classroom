import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studieteacher/basic/basics.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/quiz/add_quiz.dart';
import 'package:studieteacher/quiz/container.dart';
import 'package:studieteacher/quiz/edit_quiz.dart';

class quizstart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateQuiz();

}

class _stateQuiz extends State<quizstart> {

  final List<String> _classes = List<String>.generate(12, (index) => (index + 1).toString()).toList();
  final List<String> _sections = ["A", "B", "C", "D", "E", "F", "ALL"];
  static String _currentClass = "5";
  static String _section = "A";
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _classes.add("ALL");
  }

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
        title: basics("Quiz"),
        elevation: 0.0,
      ),
      body:ListView(children: [
        Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Container(margin:EdgeInsets.all(10),child:SizedBox(width: 200, height:50, child:RaisedButton(
            onPressed: () {},
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color:Colors_pack.color,
            disabledColor: Colors_pack.color,
            child: Row(
              children: <Widget>[Icon(Icons.add, color: Colors.white,size: 20,),
                InkWell(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Add_quiz()));},child:Container(margin: EdgeInsets.symmetric(horizontal:5),child:
                Text('Add a Quiz', style: TextStyle(color: Colors.white, fontSize: 20),),))],
            ),
          ),
          ))]),
        Container(
          margin: EdgeInsets.all(10),
          child: Text('Ongoing Quiz', style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(64), fontWeight: FontWeight.bold),),
        ),
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

        ListView.builder(
          shrinkWrap:true,physics:NeverScrollableScrollPhysics(),itemCount:10,itemBuilder: (context, index) {
        return InkWell(onTap:() {
           Navigator.push(context,MaterialPageRoute(builder: (context) => edit_quiz()) );
        },child:quiz_container());
      })]),
    );
  }

}