import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/model/Exam.dart';

class exam extends StatelessWidget {
   Exam _exam;

  exam(this._exam);
   static var list_o = [
     "Full Marks",
     "Obtained marks",
     "Class Highest",
     "Class Average",
     "Class Rank"
   ];

   static List<String> _months = <String>[
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

   List<String> weeks = ["MON", "TUE", "WED", "THR", "FRI", "SAT", "SUN"];



  @override
  Widget build(BuildContext context) {
    //Container_top
    var text_details = Container(
      height: 160.0,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          boxShadow: [BoxShadow(color: Colors.grey[400], offset: Offset(5, 5))],
          borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _exam.Title,
                        style: TextStyle(
                            color: Colors.pinkAccent,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: FittedBox(fit:BoxFit.contain,child:Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text(
                          _exam.Date.day.toString() +" "+ _months[_exam.Date.month-1] +" "+  weeks[_exam.Date.weekday -1]+" "+ _exam.Date.year.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: Text(
                            _exam.author,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.pinkAccent,
                                fontSize: 25.0),
                          )),
                      Expanded(
                          child: Text(
                            _exam.subject,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.pinkAccent,
                                fontSize: 20.0),
                          ))
                    ],
                  ))
            ],
          )),
      margin: EdgeInsets.all(10.0),
    );

    //second container
    var second_one = Container(
        height: 160.0,
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [BoxShadow(color: Colors.grey[400], offset: Offset(5, 5))],
        ),
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                      child: Text('Subject',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0))),
                                  Expanded(
                                      child: Text(_exam.subject,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue)))
                                ])),
                        Expanded(
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                      child: Text('Teacher',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                          ))),
                                  Expanded(
                                      child: Text(_exam.author,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue)))
                                ])),
                      ],
                    )),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                          child: Text('Class',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold))),
                                      Expanded(
                                          child: Text(_exam.classes,
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue)))
                                    ])),
                            Expanded(
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                          child: Text("Section",
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold))),
                                      Expanded(
                                          child: Text(_exam.section.toString().toUpperCase(),
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue)))
                                    ])),
                          ],
                        ))),
              ],
            )));
    //LIST OF OPTIONS

    //Container_top_two
    var fifth_up_container = Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(color: Colors.grey[400], offset: Offset(2, 2))
            ]),
        height: 50.0,
        margin: EdgeInsets.all(5.0),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                  child: Text(
                    list_o[4],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  )),
              Expanded(
                  child: Text(
                    "NA",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ))
            ],
          ),
        ));
    var fourth_up_container = Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(color: Colors.grey[400], offset: Offset(2, 2))
            ]),
        height: 50.0,
        margin: EdgeInsets.all(5.0),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                  child: Text(
                    list_o[3],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  )),
              Expanded(
                  child: Text(
                    _exam.AVG,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ))
            ],
          ),
        ));
    var third_up_container = Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(color: Colors.grey[400], offset: Offset(2, 2))
            ]),
        height: 50.0,
        margin: EdgeInsets.all(5.0),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                  child: Text(
                    list_o[2],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  )),
              Expanded(
                  child: Text(
                    _exam.MAX,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ))
            ],
          ),
        ));
    var first_up_container = Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(color: Colors.grey[400], offset: Offset(2, 2))
            ]),
        height: 50.0,
        margin: EdgeInsets.all(5.0),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                  child: Text(
                    list_o[0],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 18.0),
                  )),
              Expanded(
                  child: Text(
                    _exam.FullMarks,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue),
                  ))
            ],
          ),
        ));

    var second_up_container = Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(color: Colors.grey[400], offset: Offset(2, 2))
            ]),
        height: 50.0,
        margin: EdgeInsets.all(5.0),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                  child: Text(
                    list_o[1],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 18.0),
                  )),
              Expanded(
                  child: Text(
                    _exam.ObtainedMarks,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.red),
                  ))
            ],
          ),
        ));

    // TODO: implement build
    return Scaffold(
        appBar:AppBar(
          elevation: 0.0,
          leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
          title: Text('Exam', style: TextStyle(color: Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
        ),
        body: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  fit: FlexFit.loose,
                  child: text_details,
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.loose,
                  child: second_one,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: first_up_container,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: second_up_container,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: third_up_container,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: fourth_up_container,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: fifth_up_container,
                ),
                Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: Container(
                        child: Center(
                            child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        'Download the paper of the student',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    )))),
                Flexible(
                  flex: 3,
                  fit: FlexFit.loose,
                  child: Container(
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        boxShadow: [BoxShadow(color: Colors.grey[300])],
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child:FittedBox(fit:BoxFit.fitWidth,   child:Text(
                                'Teacher Remarks',
                                style: TextStyle(
                                    color: Colors.red, fontSize: 18.0),
                              ),
                            )),
                            Flexible(
                              flex: 2,
                              child: FittedBox(fit:BoxFit.fitWidth,child: Text(
                                'No Teacher Remarks Available',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ))
                          ],
                        )),
                  ),
                )
              ],
            )));
  }
}
