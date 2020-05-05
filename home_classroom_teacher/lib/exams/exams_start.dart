import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/exams/add_exam.dart';
import 'package:studieteacher/exams/exams_container.dart';
import 'package:studieteacher/exams/exams_past_container.dart';
import 'package:studieteacher/models/exam_details_model.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentYear = DateTime.now().year.toString();
    _currentMonth = _months[DateTime.now().month-1];

  }

  void _changeYear(String val) {
    setState(() {
      _currentYear = val;
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:  AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Exam Scores', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body:Container(
        margin: EdgeInsets.only(left: 10),
          child: ListView(
        children: <Widget>[
          Row(children:[FittedBox(fit:BoxFit.contain,child:
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
          ))]),
          Container(
            margin:EdgeInsets.all(10),
            child:Text('Upcoming Tests', style: TextStyle(fontSize: 20),)
          ),

          Consumer<exam_details_model>(builder:(context, model, child){return (model.upcoming.isEmpty)?Container(child:
          Center(child: CircularProgressIndicator(),)):Container(
              height:220,
              child:ListView.builder(
              shrinkWrap: true,
              scrollDirection:Axis.horizontal,itemCount:model.upcoming.length,itemBuilder: (context, index){
                //TODO:ADD SUBJECT
                print(model.upcoming.toString());
               return  exam_container(model.upcoming[index], model.upcoming[index].Date, model.upcoming[index].Title, model.upcoming[index].Class,model.upcoming[index].Section,"maths", false);
          }));})
          ,
          Container(
              margin: EdgeInsets.all(10),
              child:Text('Add Scores to Exams', style: TextStyle(fontSize: 20),)
          ),
          StickyHeader(
              header:Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                  color:Colors.white,
                  child:
          FittedBox(
              fit: BoxFit.fitWidth,
              child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: <Widget>[
              Padding(padding:EdgeInsets.all(10),child:
              Text("Month", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 24),)),

              Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:
              Consumer<exam_details_model>(builder:(context, model, child){ return  DropdownButton<String>(
                value: _currentMonth,
                onChanged: (String string) { _changeMonth(string);
                int y = int.parse(_currentYear);
                int m = _months.indexOf(string) +1;
                model.PastExams(m, y);
                },
                underline: Container(),
                iconSize: 0,
                selectedItemBuilder: (BuildContext context) {
                  return _months.map<Widget>((String item) {
                    return Container(
                        width: 100,
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
                items: _months.map((String item) {
                  return DropdownMenuItem<String>(
                    child: Text('$item'),
                    value: item,
                  );
                }).toList(),
              );})) ,
              Padding(padding:EdgeInsets.all(10),child:
              Text("Year", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 24),)),

              Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:
              Consumer<exam_details_model>(builder:(context, model, child){ return DropdownButton<String>(
                value: _currentYear,
                onChanged: (String string) {_changeYear(string);
                int y = int.parse(string);
                int m = _months.indexOf(_currentMonth) + 1;
                model.PastExams(m, y);
                },
                underline: Container(),
                iconSize: 0,
                selectedItemBuilder: (BuildContext context) {
                  return _years.map<Widget>((String item) {
                    return Container(
                        width: 100,
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
                items: _years.map((String item) {
                  return DropdownMenuItem<String>(
                    child: Text('$item'),
                    value: item,
                  );
                }).toList(),
              );}))


            ],
          ))),
          content:
          Consumer<exam_details_model>(builder:(context, model, child){return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:model.past.length,itemBuilder: (context, index){
                  return exam_past_container(model.past[index]);
            });})),




        ],


      )),
    );
  }

}