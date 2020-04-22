import 'package:calendarro/date_utils.dart';
import 'package:calendarro/default_day_tile_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:calendarro/calendarro.dart';
import 'package:provider/provider.dart';
import 'package:studieteacher/attendance_g.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/customTileday.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/models/main_model.dart';


class attendance extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _attendanceState();

}

class _attendanceState extends State<attendance> {

  //TODO: Attendance input for the given class, section, subject, teacher

  static SharedPreferences prefs;
  final List<String> _months = <String>["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
  var _currentMonth ;
  final _years = List<String>.generate(50, (i) => (2000+i).toString()).toList(growable: false);
  var _currentYear = "2020";
  final List<String> _classes = List<String>.generate(12, (index) => (index + 1).toString()).toList();
  final List<String> _period = List<String>.generate(7, (index) => (index + 1).toString()).toList();
  final List<String> _sections = ["A", "B", "C", "D", "E", "F"];
  static String _currentClass = "5";
  static String _currentperiod = "1";
  static String _section = "A";
  final List<String> _subjects = <String>["Mathematics", "Physics", "Chemistry", "Biology"];
  final List<String> _teachers = <String>["Aditya Jordan", "Sujoy Dutta"];
  static String _currentteacher = "Sujoy Dutta";
  static String _currentSubject = "Mathematics";
  static DateTime current = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    var current = DateTime.now();
    _currentMonth = _months.elementAt(current.month - 1);
    _currentYear = current.year.toString();

  }


  void _changeSections(String v){
    setState(() {
      _section = v;
    });
  }

  void _changePeriod(String value){
    setState(() {
      _currentperiod = value;
    });
  }

  void _changeMonth(String value) {
    setState(() {
      _currentMonth = value;
    });

  }

  void _changeTeacher(String value) {
    setState(() {
      _currentteacher = value;
    });

  }

  void _changeSubject(String value) {
    setState(() {
      _currentSubject = value;
    });

  }

  void _changeYear(String val) {
    setState(() {
      _currentYear = val;
    });

  }

  void _changeClass(String valu) async{
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentClass = valu;
      prefs.setString("c_class", valu);
    });
  }

  final calendarroStateKey = GlobalKey<CalendarroState>();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Attendance', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body:Center(child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          FittedBox(
              fit:BoxFit.contain,
              child:Container(child:
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
                      width: 100,
                      decoration: BoxDecoration(
                        color: Color(0xff261FFF),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child:Center(child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        width: 100,
                        decoration: BoxDecoration(
                            color: Color(0xff261FFF),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child:Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:[ Text(item, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
                              Container(margin:EdgeInsets.all(10),height:15,width: 15,decoration: BoxDecoration(color:Colors.blue[200], shape: BoxShape.circle),)]),
                        ));
                  }).toList();
                },
                items: _years.map((String item) {
                  return DropdownMenuItem<String>(
                    child: Text('$item'),
                    value: item,
                  );
                }).toList(),
              ),) ,


            ],
          ))),
          Container(height:460,padding:EdgeInsets.only(top:30),child:
          Calendarro(
                key: calendarroStateKey,
                displayMode: DisplayMode.MONTHS,
                dayTileBuilder: customTileday(),
                selectedDate: current,
                weekdayLabelsRow: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize:MainAxisSize.max ,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[Text('M', style: TextStyle(fontSize:22,color: Colors.blue[900], fontWeight: FontWeight.bold), ),
                    Text('T', style: TextStyle(fontSize:24,color: Colors.blue[900], fontWeight: FontWeight.bold), ),
                    Text('W', style: TextStyle(fontSize:24,color: Colors.blue[900], fontWeight: FontWeight.bold), ),
                    Text('Th', style: TextStyle(fontSize:24,color: Colors.blue[900], fontWeight: FontWeight.bold), ),
                    Text('F', style: TextStyle(fontSize:24,color: Colors.blue[900], fontWeight: FontWeight.bold), ),
                    Text('S', style: TextStyle(fontSize:24,color: Colors.blue[900], fontWeight: FontWeight.bold), ),
                    Text('Su', style: TextStyle(fontSize:24,color: Colors.blue[900], fontWeight: FontWeight.bold), )],

                ),
                startDate: DateUtils.getFirstDayOfMonth(new DateTime(int.parse(_currentYear),_months.indexOf(_currentMonth)+1,1)),
                endDate: DateUtils.getLastDayOfMonth(new DateTime(int.parse(_currentYear),_months.indexOf(_currentMonth)+1,1)),
            )),
           Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[Column(
                children:[Container(child:
                  Text('Class', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),),
                Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:
                Consumer<main_model>(builder: (context, model, child) { return DropdownButton<String>(
                  value: model.Classes,
                  onChanged: (String string) {
                    model.ChangeClasses(string);
                    model.getDetails();
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
                );})) ,

              ],

            ),
                Consumer<main_model>(builder: (context, model, child) { return Column(
                  children:[Container(child:
                  Text('Section', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:
                    DropdownButton<String>(
                      value: model.section,
                      onChanged: (String string) {
                        model.ChangeSec(string);
                        model.getDetails();
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
                    ),) ,

                  ],

                );}),
                Column(
                  children:[Container(child:
                  Text('Period', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:
                    DropdownButton<String>(
                      value: _currentperiod,
                      onChanged: (String string) => _changePeriod(string),
                      underline: Container(),
                      iconSize: 0,
                      selectedItemBuilder: (BuildContext context) {
                        return _period.map<Widget>((String item) {
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
                      items: _period.map((String item) {
                        return DropdownMenuItem<String>(
                          child: Text('$item'),
                          value: item,
                        );
                      }).toList(),
                    ),) ,

                  ],

                )]
          ),)
        ,
        Consumer<main_model>(builder:(context, model, child){ return
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children:[Container(margin:EdgeInsets.all(10),child:
              Text('Choose a Subject', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),),
                Container(decoration: BoxDecoration(
                    color: Color(0xff261FFF),
                    borderRadius: BorderRadius.circular(5)
                ),padding:EdgeInsets.only(left: 10),child:Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children:[
                Expanded(flex:4,child:DropdownButton<String>(
                  value: model.Current_Subject,
                  onChanged: (String string) {
                    model.ChangeSubject(string);
                  },
                  underline: Container(),
                  iconSize: 0,
                  selectedItemBuilder: (BuildContext context) {
                    return model.subjects.map<Widget>((String item) {
                      return Container(
                          child:Center(child: Text(item.toString(), style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
                          ));
                    }).toList();
                  },
                  items: model.subjects.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item'),
                      value: item,
                    );
                  }).toList(),
                )),Expanded(flex:1,child:Container(alignment:Alignment.centerRight,padding:EdgeInsets.symmetric(horizontal: 10),height:15,width:15,decoration: BoxDecoration(color:Colors.blue[200], shape: BoxShape.circle),))]), ),


              ],

            ),
          );}),
        Consumer<main_model>(builder: (context, model, child) { return Column(crossAxisAlignment:CrossAxisAlignment.center,children:[
        Container(
        margin: EdgeInsets.all(10),
        width: 200,
    child:RaisedButton(onPressed: () {
      DateTime selectedDate = calendarroStateKey.currentState.selectedDate;
      print(selectedDate.toIso8601String());
      String day = selectedDate.day.toString();
      if(selectedDate.day<10){
        day = "0"+day;
      }
      String month = selectedDate.month.toString();
      if(selectedDate.month<10){
        month = "0" + month;
      }

      Navigator.push(context, MaterialPageRoute(builder: (context) => attendance_g(model, month, selectedDate.year.toString(),day)
    ));
    },
    color: Color(0xff261FFF),
     disabledColor: Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child:Padding(padding:EdgeInsets.all(10),child:Text('Attendance', textAlign: TextAlign.center, style: TextStyle(fontSize:22,fontWeight:FontWeight.bold, color:Colors.white
    )))))]);}),
     ]
    )));
  }

}