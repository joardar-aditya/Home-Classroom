import 'package:calendarro/calendarro.dart';
import 'package:calendarro/date_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/model/calendar_model.dart';
import 'package:flutterapp/models/docu_model.dart';
import 'package:provider/provider.dart';
import 'customTileday.dart';


class calendar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateCalendar();

}

class _stateCalendar extends State<calendar> {

  static List<String> _months = <String>["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
  var _currentMonth = _months[DateTime.now().month-1] ;
  final _years = List<String>.generate(50, (i) => (2000+i).toString()).toList(growable: false);
  var _currentYear = DateTime.now().year.toString();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

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


  GlobalKey<CalendarroState> key = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Calendar', style: TextStyle(color: Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body: Center(child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
      Container(child:
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
          )),),
        Container(height:460,padding:EdgeInsets.only(top:30),child:
        Calendarro(
          key: key,
          displayMode: DisplayMode.MONTHS,
          dayTileBuilder: customTileday(),
          selectedSingleDate: DateTime.now(),
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
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          child: Text('Announcements', style: TextStyle(
            color:Colors_pack.color,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),),
        ),
        Consumer<docu_model>(builder: (context, model, child) { return Container(
          child: ListView.builder(shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: model.AnnounceSize,
            itemBuilder: (context, ind) {
            return Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Container(
                     margin: EdgeInsets.all(10),
                     child: Text(model.genAnnouncements[ind].Date.toString(), style: TextStyle(color: Colors_pack.color, fontSize: 18),),
                   ),
                   Container(
                     margin: EdgeInsets.all(10),
                     child: Text(model.genAnnouncements[ind].title, style: TextStyle(fontSize: 20),)
                   )
                 ],
              ),
            );
            },
          ),
        );}),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(color:Colors_pack.color, borderRadius: BorderRadius.circular(10)),
          child: Text('TimeTable', style: TextStyle(
            color:Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),),
        ),
        Consumer<calendar_model>(builder: (context, model, child){ return Container(
          margin: EdgeInsets.symmetric(vertical: 50),
          child:(model.GetTodaySchedule().isEmpty)?Center(
            child:Text("TimeTable is not uploaded ")
          ):ListView.builder(
              shrinkWrap: true,
              itemCount: model.GetTodaySchedule().length,
              itemBuilder: (context,ind) {
            return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding:EdgeInsets.all(10),
                    child:Text(
                      model.GetTodaySchedule()[ind].startTime,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  Container(
                    padding:EdgeInsets.all(10),
                    child:Text(
                        model.GetTodaySchedule()[ind].name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  Container(
                    padding:EdgeInsets.all(10),
                    child:Text(
                        model.GetTodaySchedule()[ind].tcode,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  )
                ],
              ),
            );
          })
        );})
        ]))

    );
  }

}