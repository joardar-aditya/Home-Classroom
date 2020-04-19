import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/model/Exam.dart';

class indieTest extends StatelessWidget {

  Exam current;
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


  indieTest(this.current);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 160.0,
      decoration: BoxDecoration(
          color: Colors.pinkAccent,
          boxShadow: [BoxShadow(color: Colors.grey[400], offset: Offset(5, 5))],
          borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        current.Title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        onPressed: () {},
                        color: Colors.grey[200],
                        child: Text(
                          current.Date.day.toString() +" "+ weeks[current.Date.weekday -1] +" "+ _months[current.Date.month-1]+" "+ current.Date.year.toString(),
                          style: TextStyle(color: Colors.blue, fontSize: 18.0),
                        ),
                      ),
                    )
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
                            'Sujoy Dutta',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 25.0),
                          )),
                      Expanded(
                          child: Text(
                            'Mathematics',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20.0),
                          ))
                    ],
                  ))
            ],
          )),
      margin: EdgeInsets.all(10.0),
    );
  }

}