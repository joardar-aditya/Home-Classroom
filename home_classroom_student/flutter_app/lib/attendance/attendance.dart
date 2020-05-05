import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/model/Attendance.dart';
import 'package:flutterapp/model/Teachers.dart';
import 'package:flutterapp/model/main_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class attendance extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _attState();

}





class _attState extends State<attendance> {
  final List<String> _teachers = <String>["Aditya Jordan", "Sujoy Dutta"];

  void _changeTeacher(String value) {


  }

  var _state = "Loading";
  final List<String> _months = <String>[
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP",
    "OCT",
    "NOV",
    "DEC"
  ];
  var _currentMonth;

  GlobalKey<ScaffoldState> globalKey = new GlobalKey();

  List<String> weekdays = ["", "MON", "TUE", "WED", "THR", "FRI", "SAT", "SUN"];

  final _years = List<String>.generate(50, (i) => (2000 + i).toString()).toList(
      growable: false);
  var _currentYear = "2020";

  void initState() {
    // TODO: implement initState
    var current = DateTime.now();
    _currentMonth = _months.elementAt(current.month - 1);
    _currentYear = current.year.toString();
    checkStatus();
  }

  void checkStatus() async {
    attendance_model model = new attendance_model();
    bool v = await model.GetAttendance();
    if(v){
      setState(() {
        _state = "done";
      });

    }else{
      setState(() {
        _state = "not done";
      });
    }
  }


  void _changeYear(String val) {
    setState(() {
      _currentYear = val;
    });
  }

    void _changeMonth(String value) {
      setState(() {
        _currentMonth = value;
      });
    }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Attendance', style: TextStyle(color: Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child:(_state=="Loading")?Container(child: Center(child:CircularProgressIndicator(),),):(_state=="done")?Consumer<attendance_model>(builder:(context,model,child){ return
    ListView(children: [


           FittedBox(
               fit: BoxFit.fitWidth,
               child:Row(

            children: <Widget>[
              Padding(padding: EdgeInsets.all(10), child:
              FittedBox(
                  fit: BoxFit.contain,
                  child:Text("Month", style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),))),

              Padding(padding: EdgeInsets.symmetric(horizontal: 5), child:
              DropdownButton<String>(
                value: _currentMonth,
                onChanged: (String string) => _changeMonth(string),
                underline: Container(),
                iconSize: 0,
                selectedItemBuilder: (BuildContext context) {
                  return _months.map<Widget>((String item) {
                    return FittedBox(
                        fit: BoxFit.contain,
                        child:Container(
                        width: 100,
                        decoration: BoxDecoration(
                            color: Color(0xff261FFF),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(item, style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),),
                              Container(margin: EdgeInsets.all(10),
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                    color: Colors.blue[200],
                                    shape: BoxShape.circle),)
                            ]))));
                  }).toList();
                },
                items: _months.map((String item) {
                  return DropdownMenuItem<String>(
                    child: Text('$item'),
                    value: item,
                  );
                }).toList(),
              ),),
              Padding(padding: EdgeInsets.all(10), child:
              FittedBox(
                  fit: BoxFit.contain,
                  child:Text("Year", style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),))),

              Padding(padding: EdgeInsets.symmetric(horizontal: 5), child:
              DropdownButton<String>(
                value: _currentYear,
                onChanged: (String string) => _changeYear(string),
                underline: Container(),
                iconSize: 0,
                selectedItemBuilder: (BuildContext context) {
                  return _years.map<Widget>((String item) {
                    return FittedBox(
                        fit: BoxFit.contain,
                        child:Container(
                        width: 100,
                        decoration: BoxDecoration(
                            color: Color(0xff261FFF),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(item, style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),),
                              Container(margin: EdgeInsets.all(10),
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                    color: Colors.blue[200],
                                    shape: BoxShape.circle),)
                            ]),
                        )));
                  }).toList();
                },
                items: _years.map((String item) {
                  return DropdownMenuItem<String>(
                    child: Text('$item'),
                    value: item,
                  );
                }).toList(),
              ),),


            ],
          )),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.h),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Text('Total Class',
                          style: TextStyle(
                              color: Colors.pink[400],
                              fontSize: 20,
                              fontWeight: FontWeight.bold))),
                  Consumer<attendance_model>(builder:(context, model, child){return Expanded(
                      child: Text(
                        model.TotalClass,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ));})
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Text('Attended Class',
                          style: TextStyle(
                              color: Colors.pink[400],
                              fontSize: 20,
                              fontWeight: FontWeight.bold))),
    Consumer<attendance_model>(builder:(context, model, child){return Expanded(
                      child: Text(
                        model.AttendedClass,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ));})
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Text('Attendance Percentage',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
    Consumer<attendance_model>(builder:(context, model, child){return Expanded(
                      child: Text(
                        model.Percentage,
                        textAlign: TextAlign.right,
                        style:
                        TextStyle(fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ));})
                ],
              ),
            ),
          ),
          Container(
            height: 80,
            margin: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
                padding: EdgeInsets.all(10),
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: Colors.pinkAccent,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(text: 'Have to attend '),
                        TextSpan(
                            text: '75 ', style: TextStyle(color: Colors
                            .blue)),
                        TextSpan(text: 'classes to qualify for exam.')
                      ]),
                )),
          ),
         /* Container(
            height: 60,
            margin: EdgeInsets.all(5),
            child: Text(
              'Ask for leave of absence',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          Consumer<attendance_model>(builder: (context, model, child){ return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: 120,
                  decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                            color: Colors_pack.color, width: 2),
                      )),
                  child: Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Flexible(
                              child: Text(
                                'From',
                                style:
                                TextStyle(color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18),
                              )),
                          Flexible(
                              child: RaisedButton(
                                onPressed: () async{
                                  DateTime startDate = await showDatePicker(
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2030),
                                      context: context,
                                      builder: (context, child){
                                        return Theme(
                                          data:ThemeData.dark(),
                                          child: child,
                                        );


                                      });
                                  if(startDate != null) {
                                    model.ChangeStartLeave(startDate);
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10)),
                                child: Text(
                                  model.StartLeave.day.toString()+" "+weekdays[model.StartLeave.weekday]+" "+
                                      _months[model.StartLeave.month-1]+" "+model.StartLeave.year.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors_pack.color,
                              ))
                        ],
                      ))),
              Container(
                height: 120,
                decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: Colors_pack.color, width: 2),
                    )),
                child: Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Flexible(
                            child: Text(
                              'To',
                              style: TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            )),
                        Flexible(
                            child: RaisedButton(
                              onPressed: () async{
                                DateTime EndDate = await showDatePicker(
                                    initialDate: model.StartLeave,
                                    context: context,firstDate: DateTime(2020),
                                    lastDate: DateTime(2030),
                                    builder: (context, child){
                                      return Theme(
                                        data:ThemeData.dark(),
                                        child: child,
                                      );


                                    });
                                if(EndDate != null){
                                  model.ChangeEndLeave(EndDate);}

                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                model.EndLeave.day.toString()+" "+weekdays[model.EndLeave.weekday]+" "+
                                    _months[model.EndLeave.month-1]+" "+model.EndLeave.year.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors_pack.color,
                            ))
                      ],
                    )),
              )
            ],
          );}),
          Container(
            height: 180.0,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                        flex: 1,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            'Reason for absence',
                            style: TextStyle(color: Colors.red,
                                fontWeight: FontWeight.w800,
                                fontSize: 20),
                          ),
                        )),
                    Flexible(
                        flex: 2,
                          child:Container(
                            height: 400,
                            width:1080,
                            child: TextFormField(
                            onChanged: (value) {
                            },
                              maxLines: 5,
                            decoration: InputDecoration(
                                fillColor: Colors.grey[250],
                                filled: true,
                                border: OutlineInputBorder(borderSide: BorderSide(width:0.0, style: BorderStyle.none),borderRadius: BorderRadius.circular(10))
                            ),
                          ),
                        ))
                  ],
                )),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              'Send To',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
          ),
        Consumer<main_model>(builder:(context, model, child){
          return
          Container(decoration: BoxDecoration(
        color: Color(0xff261FFF),
        borderRadius: BorderRadius.circular(5)
        ),padding:EdgeInsets.only(left:10),child:Row(children:[
          (model.Teachers_list.isEmpty)?Container(child: Container(child: CircularProgressIndicator(),),):Expanded(flex:4,child:DropdownButton<String>(
        value: model.current_teacher.name + ", " + model.current_teacher.code,
        onChanged: (String string) {
          List<String> t = string.split(", ");
          model.ChangeT(Teachers(t[0], t[1]));
        },
        underline: Container(),
        iconSize: 0,
        selectedItemBuilder: (BuildContext context) {
        return model.Teachers_list.map<Widget>((Teachers item) {
        return Container(
        child:Center(child: Text(item.name + ", " + item.code, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
        ));
        }).toList();
        },
        items: model.Teachers_list.map((Teachers item) {
        return DropdownMenuItem<String>(
        child: Text(item.name + ", "+item.code),
        value: item.name + ", "+item.code,
        );
        }).toList(),
        ))*/



        ]

    );}):Container(child:Center(child: Text("Your Attendance record was not found! Contact your School"),))
      ),
    );

  }


}


