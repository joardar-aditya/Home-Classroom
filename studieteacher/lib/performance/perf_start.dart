import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studieteacher/basic/basics.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/performance_model.dart';
import 'package:studieteacher/performance/performance_search.dart';
import 'package:studieteacher/performance/pref_container.dart';


class perf_start extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _statePerf();

}

class _statePerf extends State<perf_start>{

  final List<String> _classes = List<String>.generate(12, (index) => (index + 1).toString()).toList();
  final List<String> _sections = ["A", "B", "C", "D", "E", "F", ];
  static String _currentClass = "5";
  static String _section = "A";
  static List<String> options = ["Overall", "Homework", "Exam", "Quiz"];
  static List<String> icons_options = ["assets/Group26.png", "assets/Group46.png", "assets/Group4.png", "assets/Group93.png"];
  static var currentPressed = options[0];
  static var currentSubject = subjects[0];
  static List<String> subjects = ["Summary", "Mathematics", "Physics", "Chemistry"];
  static List<String> subject_code = ["all", "math", "physics", "chem" ];
  static List<String> subjects_icons = ["assets/Group81.png", "assets/Group84.png", "assets/Group49.png", "assets/Group63.png"];
  TextEditingController control = new TextEditingController();
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


    return Scaffold(
      appBar:  AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Performance', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Text('Search for students', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
          ),
          Consumer<performance_model>(builder: (context, model, child){ return Container(
            margin: EdgeInsets.all(10),
            child:TextField(
              controller: control,
    decoration: InputDecoration(
      suffixIcon: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => performance_Search(model,control.text )));
        },
        child:Container(
          height:25,
          width: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:Colors_pack.color,
          ),
          child: Center(child: Icon(Icons.search, color: Colors.white,),),
        )
      ),
    hintStyle: TextStyle(color:Colors.pinkAccent, fontSize: 16),
    hintText: "Enter the name of the student",
    filled: true,
    fillColor: Colors.grey[300],
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none)),
            )
          );}),
          Container(
              margin: EdgeInsets.all(10),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,

                children: <Widget>[
                  FittedBox(fit:BoxFit.contain,child:Padding(padding:EdgeInsets.all(10),child:
                  Text("Class", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 24),))),

                  Consumer<performance_model>(builder: (context, model, child) { return FittedBox(fit:BoxFit.contain,child:Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:
                  DropdownButton<String>(
                    value: _currentClass,
                    onChanged: (String string) { _changeClass(string);
                    model.ChangeClass(string);},
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
                            child:Center(child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:[ Text(item, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
                                  Container(margin:EdgeInsets.all(10),height:15,width: 15,decoration: BoxDecoration(color:Colors.blue[200], shape: BoxShape.circle),)])));
                      }).toList();
                    },
                    items: _classes.map((String item) {
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
                 Consumer<performance_model>(builder: (context, model,child) { return  FittedBox(fit:BoxFit.contain,child:
                  Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:
                  DropdownButton<String>(
                    value: _section,
                    onChanged: (String string) {_changeSections(string);
                    model.ChangeSection(string.toLowerCase());

                    },
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
                            child:Center(child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:[ Text(item, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
                                  Container(margin:EdgeInsets.all(10),height:15,width: 15,decoration: BoxDecoration(color:Colors.blue[200], shape: BoxShape.circle),)])));
                      }).toList();
                    },
                    items: _sections.map((String item) {
                      return DropdownMenuItem<String>(
                        child: Text('$item'),
                        value: item,
                      );
                    }).toList(),
                  ),) );}),


                ],
              )),
          Container(
              margin: EdgeInsets.all(20),
              height: 160,
              child:
          ListView.builder(itemCount:4,itemBuilder: (context, ind){
            bool pressed = false;
            if(options[ind].compareTo(currentPressed) == 0){
              pressed = true;
            }
            return InkWell(
                onTap: () {
                  setState(() {
                    currentPressed = options[ind];
                  });

            },
                child:Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child:pref_container(pressed, options[ind],icons_options[ind])));
          }, shrinkWrap: true, scrollDirection: Axis.horizontal, physics: ScrollPhysics(),)
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Subject', style: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),),
          ),
          Consumer<performance_model>(builder:(context,model, child){ return Container(
              margin: EdgeInsets.all(20),
              height: 160,
              child:
              ListView.builder(itemCount:4,itemBuilder: (context, ind){
                bool pressed_i = false;
                if(subjects[ind].compareTo(currentSubject) == 0){
                  pressed_i = true;
                }
                return InkWell(
                    onTap: () {
                  setState(() {
                    currentSubject = subjects[ind];
                    model.ChangeSubject(subject_code[ind]);
                  });

                },
                child:Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child:pref_container(pressed_i, subjects[ind],subjects_icons[ind])));
              }, shrinkWrap: true, scrollDirection: Axis.horizontal, physics: ScrollPhysics(),)
          );}),
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(20),
            child:Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child:Text(
                    'Overall\nPerformance',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color:Colors_pack.color,
                      fontSize: 28,
                    ),
                  )
                ),
               Consumer<performance_model>(builder: (context, model, child) { return  Expanded(
                  child:Text(model.Overall,
                  textAlign: TextAlign.center,
                    style: TextStyle(
                      color:Colors_pack.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 56,
                    ),
                  )
                );})
              ],
            )
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Consumer<performance_model>(builder:(context, model, child){return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(flex:3,child:Text('Homework Submission',style: TextStyle(fontSize: 18),)),
                    Expanded(child:Text(model.hw_perf+'%', textAlign: TextAlign.right,style: TextStyle(fontSize: 24),)),

                  ],
                );}),
                Consumer<performance_model>(builder:(context, model, child){return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(flex:3,child:Text('Exam Performance',style: TextStyle(fontSize: 18),)),
                    Expanded(child:Text(model.e_p+'%', textAlign: TextAlign.right,style: TextStyle(fontSize: 24),)),

                  ],
                );}),
                Consumer<performance_model>(builder:(context,model, child){ return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(flex:3,child:Text('Quiz Performance',style: TextStyle(fontSize: 18),)),
                    Expanded(child:Text(model.q_p+'%', textAlign: TextAlign.right,style: TextStyle(fontSize: 24),)),

                  ],
                );}),
                Consumer<performance_model>(builder:(context,model, child){ return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(flex:3,child:Text('Class Performance', style: TextStyle(fontSize: 18),)),
                    Expanded(child:Text(model.cl_p+"%", textAlign: TextAlign.right,style: TextStyle(fontSize: 24),)),

                  ],
                );})
              ],
            ),
          )

        ],
      ),
    );

  }

}

