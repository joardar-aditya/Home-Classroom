import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/basic/basics.dart';
import 'package:studieteacher/chapters/chapter_start_con.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/main_model.dart';

import 'Chapter.dart';
import 'package:http/http.dart' as http;
class chapter_start extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateDetails();

}


class _stateDetails extends State<chapter_start> {

  final List<String> _classes = List<String>.generate(12, (index) => (index + 1).toString()).toList();
  final List<String> _sections = ["A", "B", "C", "D", "E", "F", ];
  static String _currentClass = "5";
  static String _section = "A";
  static String _currentSubject = "Mathematics";

  final List<String> _subjects = <String>[
    "Mathematics",
    "Physics",
    "Chemistry",
    "Biology"
  ];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  final globalKey = GlobalKey<ScaffoldState>();
  var loading = false;
  static List<Chapter> list_of_chapters = [];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key:globalKey,
        appBar:  AppBar(
          elevation: 0.0,
          leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
          title: Text('Chapters', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
        ),
        body: ListView(
      children: <Widget>[
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
                Consumer<main_model>(builder:(context, model, child){ return DropdownButton<String>(
                  value: model.Classes,
                  onChanged: (String string) {
                  model.ChangeClasses(string);
                  model.getDetails();
                  setState(() {
                    loading = true;
                  });
                  model.getChapters();
                  setState(() {
                    loading = false;
                  });},
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
                );}))) ,
                FittedBox(fit: BoxFit.contain,
                    child:
                    Padding(padding:EdgeInsets.all(10),child:
                    Text("Sec", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 24),))),
                FittedBox(fit:BoxFit.contain,child:
                Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:
                Consumer<main_model>(builder:(context, model, child){ return DropdownButton<String>(
                  value: model.section,
                  onChanged: (String string) {
                  model.ChangeSec(string);
                  model.getDetails();
                  setState(() {
                    loading = true;
                  });
                  model.getChapters();
                  setState(() {
                    loading = false;
                  });},
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
                          child:Center(child:  Row(
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
          child: Text('Choose a Subject', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
        ),
        Consumer<main_model>(builder:(context, model, child){ return (model.subjects.isEmpty)?Container(child: LinearProgressIndicator(),):Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color(0xff261FFF),
                borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.only(left: 10),
            child:Row(children:[Expanded(flex:4,child:DropdownButton<String>(
              value: model.Current_Subject,
              onChanged: (String string) {
                model.ChangeSubject(string);
                setState(() {
                  loading = true;
                });
                model.getChapters();
                setState(() {
                  loading = false;
                });
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
          child: Text('Choose a Chapter', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
        ),
        Consumer<main_model>(builder:(context, model, child){ return loading?Container(child:Center(child:CircularProgressIndicator())):ListView.builder(shrinkWrap:true, physics:NeverScrollableScrollPhysics(),itemCount:model.list_of_chapters.length,itemBuilder: (context, ind) {
          return chapter_start_con(model.list_of_chapters[ind]);
        });})




      ],
    ));
  }

  void GetChapters() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString("user");
    print(code);
    String teacher = sharedPreferences.getString("tcode");
    String school = sharedPreferences.getString("icode");
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "/teacher/chapters/$school/$_currentClass/$_section".toLowerCase(),{
      "subject":"MATHS"
    } );
    var res = await http.get(uri, headers: {
      "x-access-token": code,
      "type":"teacher"
    });

    print(res.body);
    var j = jsonDecode(res.body.toString());
    if(res.statusCode==200){
      if(j["status"]=="success"){
        List data = j["data"];
        List<Chapter> c=[];
        for(int i=0;i<data.length;i++){
          String ij = data[i]["id"];
          List ch = data[i]["data"]["chapters"];
          String cl = data[i]["data"]["class"];
          String sub = data[i]["data"]["subject_code"];
          String sec = data[i]["data"]["section"];
          for(int j=0; j<ch.length; j++){
            c.add(Chapter(ij,ch[j]["name"],ch[j]["started_on"],ch[j]["ended_on"], cl, sec, sub));
          }

        }
        /*setState(() {
          list_of_chapters = c;
          loading = false;
        })*/;
      }else{
        print("Problem!");
        globalKey.currentState.showSnackBar(SnackBar(content: Text("Chapters not loaded, select another class or log in again!"),));
      }
    }
  }


}