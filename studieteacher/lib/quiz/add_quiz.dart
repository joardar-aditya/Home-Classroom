import 'package:flutter/material.dart';
import 'package:studieteacher/basic/basics.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/quiz/Add_question.dart';


class Add_quiz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateAdd();

}

class _stateAdd extends State<Add_quiz>{

  final List<String> _classes = List<String>.generate(12, (index) => (index + 1).toString()).toList();
  final List<String> _sections = ["A", "B", "C", "D", "E", "F", "ALL"];
  static String _currentClass = "5";
  static String _section = "A";
  static String _currentSubject = "Mathematics";

  final List<String> _subjects = <String>[
    "Mathematics",
    "Physics",
    "Chemistry",
    "Biology"
  ];

  void _changeSubject(String value) {
    setState(() {
      _currentSubject = value;
    });
  }

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
      appBar:AppBar(
        title: basics("Add a Quiz"),
        elevation: 0.0,
      ),
      body:ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Text('Select Class and Section', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
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
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text('Quiz title', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(decoration: InputDecoration(
              hintStyle: TextStyle(color:Colors.pinkAccent, fontSize: 22),
              hintText: "Add a title",
              filled: true,
              fillColor: Colors.grey[300],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none)
            ),),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text('Choose a Subject', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
          ),
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color(0xff261FFF),
                borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.only(left: 10),
            child: DropdownButton<String>(
              value: _currentSubject,
              onChanged: (String string) => _changeSubject(string),
              underline: Container(),
              iconSize: 0,
              selectedItemBuilder: (BuildContext context) {
                return _subjects.map<Widget>((String item) {
                  return Container(
                      child: Center(
                        child: Text(
                          item.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ));
                }).toList();
              },
              items: _subjects.map((String item) {
                return DropdownMenuItem<String>(
                  child: Text('$item'),
                  value: item,
                );
              }).toList(),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text('Add Syllabus', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
          ),
          Container(margin:EdgeInsets.all(10),child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
          SizedBox(
              width:220,
              height: 70,
              child:RaisedButton(
                disabledColor: Colors_pack.color,
                color: Colors_pack.color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  showDialog(context: context, builder: (context) {
                    return Dialog(
                      backgroundColor: Colors_pack.color,
                      child: Container(child:Text('What would be it\'s pop up?', style: TextStyle(fontSize:24,color:Colors.white),),
                    ));
                  });
                },
                child:Center(
                  child:Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(child: Icon(Icons.add, size: 30, color: Colors.white,),),
                      Container(margin: EdgeInsets.only(left:3),child: Text('Add Chapters', style: TextStyle(fontSize:20,color:Colors.white),),)

                    ],
                  )
                )
              )
            ),])),
          Container(
            margin: EdgeInsets.all(10),
            child: ListView.builder(shrinkWrap:true, physics:NeverScrollableScrollPhysics(),itemCount:5,itemBuilder: (context, ind) {
              return Container(margin:EdgeInsets.all(10),child:Text('Trigonometry', style: TextStyle(color:Colors.pinkAccent, fontSize: 22, fontWeight: FontWeight.bold),));
            }),
          ),

          Container(
            margin: EdgeInsets.all(10),
            child:Column(crossAxisAlignment:CrossAxisAlignment.center,
              mainAxisSize:MainAxisSize.min,children:[FittedBox(
                  fit: BoxFit.contain,
                  child:Center(child:RaisedButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => add_question()));
                  },
                      color: Colors_pack.color,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child:Container(padding:EdgeInsets.all(10),child:Center(
                          child:Text('Add Questions', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold
                          ),)
                      ))
                  ),
                  ))],
          ))




        ],
      )
    );
  }

}