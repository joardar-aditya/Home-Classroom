import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studieteacher/basic/basics.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/exams/chapter_container.dart';
import 'package:studieteacher/models/Quiz_model.dart';
import 'package:studieteacher/models/exam_add_model.dart';
import 'package:studieteacher/models/main_model.dart';
import 'package:studieteacher/quiz/Add_question.dart';
import 'package:studieteacher/quiz/quiz_chapters_container.dart';


class Add_quiz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateAdd();

}

class _stateAdd extends State<Add_quiz>{

  final List<String> _classes = List<String>.generate(12, (index) => (index + 1).toString()).toList();
  final List<String> _sections = ["A", "B", "C", "D", "E", "F"];
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
        elevation: 0.0,
        leading: Consumer<Quiz_model>(builder:(context, model, child){return RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {
          model.ClearQuiz();
          Navigator.pop(context);

        },child:Image(image:AssetImage('assets/back.png'), height: 50,) );}),
        title: Text('Add a Quiz', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
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

    Consumer<main_model>(builder:(context, model, child){ return FittedBox(fit:BoxFit.contain,child:Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:
                 DropdownButton<String>(
                  value: model.Classes,
                  onChanged: (String string) {
                  model.ChangeClasses(string);
                  model.getDetails();
                  model.getChapters();
                  },
                  underline: Container(),
                  iconSize: 0,
                  selectedItemBuilder: (BuildContext context) {
                    return model.Class_list.map<Widget>((String item) {
                      return Container(
                          width: 80,
                          decoration: BoxDecoration(
                              color: Color(0xff261FFF),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child:Center(child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:[ Text(item, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
                      Container(margin:EdgeInsets.all(10),height:15,width: 15,decoration: BoxDecoration(color:Colors.blue[200], shape: BoxShape.circle),)])));
                    }).toList();
                  },
                  items: model.Class_list.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item'),
                      value: item,
                    );
                  }).toList(),
                ),));}),
                FittedBox(fit: BoxFit.contain,
                    child:
                    Padding(padding:EdgeInsets.all(10),child:
                    Text("Sec", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 24),))),
                FittedBox(fit:BoxFit.contain,child:
                Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:
                Consumer<main_model>(builder: (context,model,child){return DropdownButton<String>(
                  value: model.section,
                  onChanged: (String string) {
                    model.ChangeSec(string);
                    model.getDetails();
                    model.getChapters();
                    _changeSections(string);},
                  underline: Container(),
                  iconSize: 0,
                  selectedItemBuilder: (BuildContext context) {
                    return model.Section_list.map<Widget>((String item) {
                      return Container(
                          width: 80,
                          decoration: BoxDecoration(
                              color: Color(0xff261FFF),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child:Center(child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:[ Text(item, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
                      Container(margin:EdgeInsets.all(10),height:15,width: 15,decoration: BoxDecoration(color:Colors.blue[200], shape: BoxShape.circle),)])));
                    }).toList();
                  },
                  items: model.Section_list.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item'),
                      value: item,
                    );
                  }).toList(),
                );})))


              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text('Quiz title', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Consumer<Quiz_model>(builder:(context, model, child) {
              return
              TextField(
                onChanged: (value) {
                  model.changeTitle(value);
                },
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                        color: Colors.pinkAccent, fontSize: 22),
                    hintText: "Add a title",
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none)
                ),);
            })),
          Container(
            margin: EdgeInsets.all(10),
            child: Text('Choose a Subject', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
          ),
          Consumer<main_model>(builder: (context, model, child) { return Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color(0xff261FFF),
                borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.only(left: 10),
            child:Row(children:[Expanded(flex:4,child:DropdownButton<String>(
              value: model.Current_Subject,
              onChanged: (String string) { _changeSubject(string);
                 model.ChangeSubject(string);
                 model.getChapters();
              },
              underline: Container(),
              iconSize: 0,
              selectedItemBuilder: (BuildContext context) {
                return model.subjects.map<Widget>((String item) {
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
              items: model.subjects.map((String item) {
                return DropdownMenuItem<String>(
                  child: Text('$item'),
                  value: item,
                );
              }).toList(),
            )),Expanded(child:Container(margin:EdgeInsets.all(10),height:15,width: 15,decoration: BoxDecoration(color:Colors.blue[200], shape: BoxShape.circle),))])
          );}),
          Container(
            margin: EdgeInsets.all(10),
            child: Text('Add Syllabus', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
          ),
          Container(margin:EdgeInsets.all(10),child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
          Consumer<main_model>(builder: (context, model, child){ return SizedBox(
              width:220,
              height: 70,
              child:RaisedButton(
                disabledColor: Colors_pack.color,
                color: Colors_pack.color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  showDialog(context: context,
                      builder: (context){
                        List _list_of_chapters = model.chapters;
                        return Container(

                            child:Dialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20

                                )),
                                backgroundColor: Colors.grey[400],
                                child: Consumer<Quiz_model>(builder:
                                    (context, model, child){
                                  return Container(
                                    margin:EdgeInsets.symmetric(vertical:20),
                                    child: ListView.builder(itemCount:_list_of_chapters.length,itemBuilder: (context, ind){
                                      return chapter_container_quiz(_list_of_chapters[ind]);
                                    }),
                                  );})
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
            );}),])),
          Consumer<Quiz_model>(builder:(context, model, child){
            return Container(
            margin: EdgeInsets.all(10),
            child: model.Chapters.isEmpty?Container(child:Center(child: Text("Please add Chapters"),)):ListView.builder(shrinkWrap:true, physics:NeverScrollableScrollPhysics(),itemCount:model.Chapters.length,itemBuilder: (context, ind) {
              return Container(margin:EdgeInsets.all(10),child:Text(model.Chapters[ind], style: TextStyle(color:Colors.pinkAccent, fontSize: 22, fontWeight: FontWeight.bold),));
            }),
          );}),

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