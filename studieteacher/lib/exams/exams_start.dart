import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/exams/add_exam.dart';
import 'package:studieteacher/exams/exams_container.dart';
import 'package:studieteacher/exams/exams_past_container.dart';

class exam_start extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateExam();

}

class _stateExam extends State<exam_start> {
  final List<String> _months = <String>["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
  var _currentMonth = "JAN" ;
  final _years = List<String>.generate(50, (i) => (2000+i).toString()).toList(growable: false);
  var _currentYear = "2020";

  void _changeMonth(String value) {
    setState(() {
      _currentMonth = value;
    });
  }

  void _changeYear(String val) {
    setState(() {
      _currentYear = val;
    });

  }

  static var list_now = [{"date":"1 JAN MON 2020", "name":"Class test 001", "class":"5", "sec":"A", "subject": "Mathematics"},
    {"date":"1 JAN MON 2020", "name":"Class test 001", "class":"5", "sec":"A", "subject": "Mathematics"},
    {"date":"1 JAN MON 2020", "name":"Class test 001", "class":"5", "sec":"A", "subject": "Mathematics"},
    {"date":"1 JAN MON 2020", "name":"Class test 001", "class":"5", "sec":"A", "subject": "Mathematics"},
    {"date":"1 JAN MON 2020", "name":"Class test 001", "class":"5", "sec":"A", "subject": "Mathematics"}];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Exam & Scores", style: TextStyle(color: Color(0xff261FFF), fontSize: 24, fontWeight: FontWeight.bold),),
        elevation: 0.0,
      ),
      body:Container(
        margin: EdgeInsets.only(left: 10),
          child: Column(
        mainAxisAlignment:MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FittedBox(fit:BoxFit.contain,child:
          Container(
            width: 200,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: RaisedButton(
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => add_exam()));},
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color:Colors_pack.color,
              disabledColor: Colors_pack.color,
              child: Row(
                children: <Widget>[Icon(Icons.add, color: Colors.white,size: 20,),
                Container(margin: EdgeInsets.symmetric(horizontal:5),child:
                  Text('Add an exam', style: TextStyle(color: Colors.white, fontSize: 20),),)],
              ),
            ),
          )),
          Flexible(flex:1,child: Container(
            child:Text('Upcoming Tests', style: TextStyle(fontSize: 20),)
          )),
          Flexible(flex:3, child:
          ListView.builder(scrollDirection:Axis.horizontal,itemCount:list_now.length,itemBuilder: (context, index){
               return exam_container(list_now[index]["date"], list_now[index]["name"], list_now[index]["class"],list_now[index]["sec"],list_now[index]["subject"], false);
          })
          ),
          Flexible(flex:1,child: Container(
              child:Text('Add scores to the exam', style: TextStyle(fontSize: 20),)
          )),
          Flexible(flex:3, child:
          ListView.builder(scrollDirection:Axis.horizontal,itemCount:list_now.length,itemBuilder: (context, index){
            return exam_container(list_now[index]["date"], list_now[index]["name"], list_now[index]["class"],list_now[index]["sec"],list_now[index]["subject"], true);
          })
          ),
          Flexible(flex:1,child: Container(
              child:Text('Past Completed Exams', style: TextStyle(fontSize: 20),)
          )),
          Flexible(flex:1,child:
          Container(child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: <Widget>[
              Padding(padding:EdgeInsets.all(10),child:
              Text("Month", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 24),)),

              Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:
              DropdownButton<String>(
                value: _currentMonth,
                onChanged: (String string) => _changeMonth(string),
                underline: Container(),
                iconSize: 0,
                selectedItemBuilder: (BuildContext context) {
                  return _months.map<Widget>((String item) {
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
                items: _months.map((String item) {
                  return DropdownMenuItem<String>(
                    child: Text('$item'),
                    value: item,
                  );
                }).toList(),
              ),) ,
              Padding(padding:EdgeInsets.all(10),child:
              Text("Year", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 24),)),

              Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:
              DropdownButton<String>(
                value: _currentYear,
                onChanged: (String string) => _changeYear(string),
                underline: Container(),
                iconSize: 0,
                selectedItemBuilder: (BuildContext context) {
                  return _years.map<Widget>((String item) {
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
                items: _years.map((String item) {
                  return DropdownMenuItem<String>(
                    child: Text('$item'),
                    value: item,
                  );
                }).toList(),
              ),)


            ],
          )),),
          Flexible(
            flex:4,
            child: ListView.builder(itemCount:10,itemBuilder: (context, index){
                  return exam_past_container();
            }),
          )



        ],


      )),
    );
  }

}