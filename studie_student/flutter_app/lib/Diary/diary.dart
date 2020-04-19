import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/model/dairy_model.dart';
import 'package:provider/provider.dart';


class diary extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _statediary();

}


class _statediary extends State<diary> {



      List<String> _months = <String>[
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

      final _years = List<String>.generate(50, (i) => (2000 + i).toString()).toList(
  growable: false);
  var _currentYear = "2020";
  var _current = 0;
  List<String> topics = ["Summary", "Mathematics", "Physics", "Chemistry"];
  List<String> images = ["assets/Group81.png", "assets/Group84.png", "assets/Group49.png","assets/Group63.png"];

  void initState() {
    // TODO: implement initState
    var current = DateTime.now();
    _currentMonth = _months.elementAt(current.month - 1);
    _currentYear = current.year.toString();
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
        appBar:AppBar(
          elevation: 0.0,
          leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
          title: Text('Diary', style: TextStyle(color: Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: ListView(
                children: <Widget>[
                  Container(height:130.0,child:ListView.builder(
                      itemCount: images.length,
                      scrollDirection: Axis.horizontal,
                    itemBuilder: (context, ind){ return
                      InkWell(
                          onTap: () {
                            setState(() {
                              _current = ind;
                            });
                          },
                          child:Container(height:120, width:100,margin:EdgeInsets.symmetric(horizontal:10.0) ,child:Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
                        Container(height:80, width:90, padding:EdgeInsets.all(5),
                            decoration:BoxDecoration(borderRadius: BorderRadius.circular(8),color:(_current==ind)?Colors_pack.color:Colors.grey[200],
                                boxShadow: [BoxShadow(color:Colors.grey[400], offset: Offset(2, 2))]),
                            child:Image(image: AssetImage(images[ind]),height:70, width: 70,)),
                        Container(child:Center(
                          child:Text(topics[ind],style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
                        )),]))));}),
                    )
                  ,
            Container(
                          margin: EdgeInsets.all(10.0),
                          height: 50.0,
                          child: Row(
                            children: <Widget>[
                              Container(
                                  child: Text(
                                    'Ongoing Chapter',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 28.0, color: Colors.deepPurpleAccent),
                                  )),
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    onPressed: () {},
                                    disabledColor: Colors_pack.color,
                                    color: Colors_pack.color,
                                    child: Text(
                                      'Know Details',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ), // Color pinkAccent
                                  ))
                            ],
                          )),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child:Text(
                        'Roots of Quadratic Equation',
                        style: TextStyle(
                          color:Colors.pinkAccent,
                          fontSize: 24.0
                        ),
                      )

                    ),
            Container(
              margin: EdgeInsets.all(20),
                          child: FittedBox(
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
            Container(
                          margin: EdgeInsets.all(20.0),
                          height: 60.0,
                          child: Row(children: <Widget>[
                            Container(
                                margin: EdgeInsets.symmetric(horizontal:10),
                                child: Text(
                                  'Reports',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                          ])),
                  Consumer<dairy_model>(builder:(context, model,child){ return (model.notes.isEmpty)?Container(child:Center(
                    child:Text(model.status)
                  )):Container(
                      height:350,
                      child:ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.notes.length,
                    itemBuilder:(context, ind){
                      return Container(margin:EdgeInsets.all(10.0),height: 120.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[Expanded(flex: 1,
                              child: Text(model.notes[ind].dateTime.toIso8601String(), style: TextStyle(color: Colors.blue, fontSize: 16.0),),),
                              Expanded(flex: 3,child: Text(model.notes[ind].name,textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black, fontSize: 24.0),),)],
                          ));
                    },));})
                ])));
  }
}
