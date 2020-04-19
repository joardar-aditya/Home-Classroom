import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studieteacher/exams/chapter_container.dart';
import 'package:studieteacher/models/exam_add_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:studieteacher/models/main_model.dart';


class add_exam extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _state_add_exam();

}

class _state_add_exam extends State<add_exam>{

  final List<String> _classes = List<String>.generate(12, (index) => (index + 1).toString()).toList();
  final List<String> _sections = ["A", "B", "C", "D", "E", "F"];
  final List<String> _months = <String>["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
  final List<String> _weeks = <String>["MON", "TUE", "WED", "THR", "FRI", "SAT", "SUN"];
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


   GlobalKey<ScaffoldState> state = new GlobalKey();




  @override
  Widget build(BuildContext context) {

    
    // TODO: implement build
    return Scaffold(
      key:state,
      appBar:  AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Add Exam', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body: ListView(
        children: <Widget>[
          Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Container(margin:EdgeInsets.all(10),child:SizedBox(width: 200, height:50, child:
          Consumer<exam_add_model>(builder:
          (context, model, child){
            return RaisedButton(
              onPressed: () {
                //DatePicker
                Future<DateTime> exam_time = showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2018),
                  lastDate: DateTime(2030),
                  builder: (BuildContext context, Widget child) {
                    return Theme(
                      data: ThemeData.dark(),
                      child: child,
                    );
                  },
                );
                exam_time.then((value) {
                  print(value.toIso8601String());
                  model.change_date(value);
                  print(value);
                }

                  );

              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color:Colors_pack.color,
              disabledColor: Colors_pack.color,
              child: Row(
                children: <Widget>[Icon(Icons.add, color: Colors.white,size: 20,),
                  Container(margin: EdgeInsets.symmetric(horizontal:5),child:
                  Text('Select a Date', style: TextStyle(color: Colors.white, fontSize: 20),),)],
              ),
            );}
          )))]),
            Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
            SizedBox(width:200,height:70,child:
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10)
              ),
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: Consumer<exam_add_model>(builder:(context, model, child){
                DateTime c = model.exam_date;
                String day = c.day.toString();
                String month = _months[c.month -1];
                String year = c.year.toString();
                String weekd = _weeks[c.weekday -1];
                return Center(
                child: Text('$day $weekd $month $year', style: TextStyle(color: Colors_pack.color, fontSize: 18),),
              );}
            )))]),
          Container(
              margin: EdgeInsets.all(10),
              child:
          Row(
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
                        child:Center(child:  Row(
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
              ),));}) ,
              FittedBox(fit: BoxFit.contain,
                child:
              Padding(padding:EdgeInsets.all(10),child:
              Text("Sec", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 24),))),
             FittedBox(fit:BoxFit.contain,child:
              Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:
              Consumer<main_model>(builder: (context, model, child){ return DropdownButton<String>(
                value: model.section,
                onChanged: (String string) {
                  model.ChangeSec(string);
                  model.getDetails();
                  model.getChapters();

    },
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
              );})) ),


            ],
          )),
          Container(
            margin: EdgeInsets.all(10),
            child: Text('Exam Title', style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(64), fontWeight: FontWeight.bold),),
          ),
        Consumer<exam_add_model>(builder: (context, model, child) {return Container(
              height: ScreenUtil().setHeight(150),
              margin:EdgeInsets.all(10),child:TextFormField(
             onChanged: (value) { model.change_title(value); },
              decoration: InputDecoration(
                fillColor: Colors.grey[300],
                filled: true,
                hintText: "Add a title",
                hintStyle: TextStyle(color: Colors.pinkAccent, fontSize:ScreenUtil().setSp(48)),
                border: OutlineInputBorder(borderSide: BorderSide(width:0.0, style: BorderStyle.none),borderRadius: BorderRadius.circular(10))
              ),
            ),
          );}),
          Consumer<exam_add_model>(builder:(context, model, child){return Container(
            margin: EdgeInsets.all(10),
            child: Text('Total Score', style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(64), fontWeight: FontWeight.bold),),
          );}),
          Consumer<exam_add_model>(builder:(context, model, child){return Container(
            height: ScreenUtil().setHeight(150),
            margin:EdgeInsets.all(10),child:TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                fillColor: Colors.grey[300],
                filled: true,
                hintText: "Add total Score",
                hintStyle: TextStyle(color: Colors.pinkAccent, fontSize:ScreenUtil().setSp(48)),
                border: OutlineInputBorder(borderSide: BorderSide(width:0.0, style: BorderStyle.none),borderRadius: BorderRadius.circular(10))
            ),
          ),
          );}),
          Container(
            margin: EdgeInsets.all(10),
            child: Text('Choose a subject', style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),),
          ),
          Consumer<main_model>(builder:(context, model, child) { return Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xff261FFF),
                  borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.only(left: 10),
              child:Row(children:[Expanded(flex:4,child:DropdownButton<String>(
                value: model.Current_Subject,
                onChanged: (String string) {model.ChangeSubject(string);
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
            child: Text('Choose Exam Type', style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),),
          ),
          Consumer<exam_add_model>(builder:(context, model, child) { return Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xff261FFF),
                  borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.only(left: 10),
              child:Row(children:[Expanded(flex:4,child:DropdownButton<String>(
                value: model.current,
                onChanged: (String string) {
                  model.change_current(string);
                },
                underline: Container(),
                iconSize: 0,
                selectedItemBuilder: (BuildContext context) {
                  return model.examTypes.map<Widget>((String item) {
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
                items: model.examTypes.map((String item) {
                  return DropdownMenuItem<String>(
                    child: Text('$item'),
                    value: item,
                  );
                }).toList(),
              )),Expanded(child:Container(margin:EdgeInsets.all(10),height:15,width: 15,decoration: BoxDecoration(color:Colors.blue[200], shape: BoxShape.circle),))])
          );}),
          Container(
            margin: EdgeInsets.all(10),
            child: Text('Add Syllabus', style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),),
          ),
          Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
            Consumer<main_model>(builder: (context, model, child) { return Container(margin:EdgeInsets.all(10),child:SizedBox(width: 200, height:50, child:RaisedButton(
              onPressed: () {
                showDialog(context: context,
                builder: (context){
                  List _list_of_chapters = model.chapters;
                  return Container(
                    
                      child:Dialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20

                        )),
                        backgroundColor: Colors.grey[400],
                        child: Consumer<exam_add_model>(builder:
                            (context, model, child){
                        return Container(
                          margin:EdgeInsets.symmetric(vertical:20),
                          child: ListView.builder(itemCount:_list_of_chapters.length,itemBuilder: (context, ind){
                            return InkWell(
                                onTap: () {
                                  model.add_chapters("\""+_list_of_chapters[ind]+"\"");
                                },
                                child:chapter_container(_list_of_chapters[ind]));
                          }),
                        );})
                  ));
                });
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color:Colors_pack.color,
              disabledColor: Colors_pack.color,
              child: Row(
                children: <Widget>[Icon(Icons.add, color: Colors.white,size: 20,),
                  Container(margin: EdgeInsets.symmetric(horizontal:5),child:
                  Text('Add Chapters', style: TextStyle(color: Colors.white, fontSize: 20),),)],
              ),
            ),
            ));})]),
          Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
            Consumer2<exam_add_model, main_model>(builder:(context, model,model2, child){return Container(margin:EdgeInsets.all(10),child:SizedBox(width: 200, height:50, child:RaisedButton(
              onPressed: () {
                  AddExam(model, model2);
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color:Colors_pack.color,
              disabledColor: Colors_pack.color,
              child:Container(margin: EdgeInsets.symmetric(horizontal:5),child:
              Text('Add Exam', style: TextStyle(color: Colors.white, fontSize: 20),),)
            ),
            ));})]),
      Consumer<exam_add_model>(builder: (context, model, child){
     return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 500),
          child:model.exam_empty()?Container(child:Center(child:Text('Chapters not added, Please add Chapters'))):
       Consumer<exam_add_model>(builder:(context, model, child){ return
         ListView.builder(shrinkWrap:true, physics:NeverScrollableScrollPhysics(),itemCount:model.chapters.length,itemBuilder: (context, item) {
          List chapters = model.exam_chapters.keys.toList();
          return Container(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      child:Text(chapters[item], style: TextStyle(color:Colors.pinkAccent, fontSize: 24, fontWeight: FontWeight.bold),)
                    ),
                    Consumer<exam_add_model>(builder:(context, model, child){ return Container(
                      height: ScreenUtil().setHeight(150),
                      margin:EdgeInsets.all(10),child:TextFormField(
                      decoration: InputDecoration(
                          fillColor: Colors.grey[300],
                          filled: true,
                          hintText: "Add a Description",
                          hintStyle: TextStyle(color: Colors.pinkAccent, fontSize:ScreenUtil().setSp(48)),
                          border: OutlineInputBorder(borderSide: BorderSide(width:0.0, style: BorderStyle.none),borderRadius: BorderRadius.circular(10))
                      ),
                      onChanged: (string) {
                        model.addDescription(string, chapters[item]);
                      },
                    ),
                    );}),

                  ],
                )
              );
            }
          );}));}),



        ],
      ),

    );


  }

  void AddExam(exam_add_model model, main_model model2) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    String type = "teacher";
    String tcode = sharedPreferences.getString("tcode");
    String icode = sharedPreferences.getString("icode");
    String tname = sharedPreferences.getString("name");
    String classes = model2.Classes;
    String section = model2.section;
    print(model.chapters.toString());
    List<String> kyabataein = [];
    for(int j=0; j<model.chapters.keys.toList().length;j++){
      String k = model.chapters.keys.toList()[j];
      String desc = model.chapters[k];
      String re = "{\"name\":\"$k\",\"desc\":\"$desc\"}";
      kyabataein.add(re);
    }
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/exam");
    print(kyabataein.toString());
    var res = await http.post(uri, body: {
      "title":model.title,
      "chapters":kyabataein.toString(),
      "date":model.date.toIso8601String(),
      "sec":section.toLowerCase(),
      "class":classes,
      "sub":model2.Current_Subject,
      "author": tname,
      "icode":icode,
      "examType":model.Current_Type.toString(),
      "fullMarks":model.fullMarks,
    },
    headers: {
      "x-access-token":code,
      "type":"teacher"
    });
    print(res.body);
    var j = convert.jsonDecode(res.body);


    if(res.statusCode==200){
      if(j["status"]=="success"){
        state.currentState.showSnackBar(SnackBar(content: Text(res.body),));
      }else{
        state.currentState.showSnackBar(SnackBar(content: Text(res.body),));
      }
    }else{
      state.currentState.showSnackBar(SnackBar(content: Text("Exam not Added!"),));
    }
  }
}