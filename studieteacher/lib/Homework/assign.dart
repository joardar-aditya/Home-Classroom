import 'package:calendarro/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:calendarro/calendarro.dart';

class assign extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _assignState();
}

class _assignState extends State<assign> {
  static SharedPreferences prefs;
  static var date = new DateTime.now();

  final List<String> _classes =
      List<String>.generate(11, (index) => (index + 1).toString()).toList();
  final List<String> _period =
      List<String>.generate(7, (index) => (index + 1).toString()).toList();
  final List<String> _sections = ["A", "B", "C", "D", "E", "F"];
  static String _currentClass = "5";
  static String _currentperiod = "1";
  static String _section = "A";
  final List<String> _subjects = <String>[
    "Mathematics",
    "Physics",
    "Chemistry",
    "Biology"
  ];
  final List<String> _teachers = <String>["Trigonometry", "Calculus"];
  static String _currentteacher = "Trigonometry";
  static String _currentSubject = "Mathematics";
  static String _submitMonth;

  static String _submityear;

  static String _submitday;

  static List<String> day_list;

  final List<String> _months = [
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
  final List<String> _year =
      List<String>.generate(50, (i) => (2000 + i).toString())
          .toList(growable: false);

  void _changeSections(String v) {
    setState(() {
      _section = v;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _submitMonth = _months[DateTime.now().month - 1];
    _submityear = DateTime.now().year.toString();
    _submitday = DateTime.now().day.toString();
    if (["JAN", "MAR", "MAY", "JUL", "AUG", "OCT", "DEC"]
        .contains(_submitMonth)) {
      day_list = List<String>.generate(31, (i) => (1 + i).toString())
          .toList(growable: false);
    } else if (["APR", "JUN", "SEP", "NOV"].contains(_submitMonth)) {
      day_list = List<String>.generate(30, (i) => (1 + i).toString())
          .toList(growable: false);
    } else {
      if (int.parse(_submityear) % 4 == 0) {
        day_list = List<String>.generate(29, (i) => (1 + i).toString())
            .toList(growable: false);
      } else {
        day_list = List<String>.generate(28, (i) => (1 + i).toString())
            .toList(growable: false);
      }
    }
  }

  void _changeDate(String value) {
    setState(() {
      _submitday = value;
    });
  }

  void _changeMonth(String value) {
    setState(() {
      _submitMonth = value;
      _submitday = "1";
      if (["JAN", "MAR", "MAY", "JUL", "AUG", "OCT", "DEC"]
          .contains(_submitMonth)) {
        day_list = List<String>.generate(31, (i) => (1 + i).toString())
            .toList(growable: false);
      } else if (["APR", "JUN", "SEP", "NOV"].contains(_submitMonth)) {
        day_list = List<String>.generate(30, (i) => (1 + i).toString())
            .toList(growable: false);
      } else {
        if (int.parse(_submityear) % 4 == 0) {
          day_list = List<String>.generate(29, (i) => (1 + i).toString())
              .toList(growable: false);
        } else {
          day_list = List<String>.generate(28, (i) => (1 + i).toString())
              .toList(growable: false);
        }
      }
    });
  }

  void _changeYear(String value) {
    setState(() {
      _submitday = "1";
      _submityear = value;
    });
  }

  void _changePeriod(String value) {
    setState(() {
      _currentperiod = value;
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

  void _changeClass(String valu) async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentClass = valu;
      prefs.setString("c_class", valu);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Container(
        margin: EdgeInsets.all(10),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
            Widget>[
          Column(
            children: [
              Container(
                child: Text(
                  'Class',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: DropdownButton<String>(
                  value: _currentClass,
                  onChanged: (String string) => _changeClass(string),
                  underline: Container(),
                  iconSize: 0,
                  selectedItemBuilder: (BuildContext context) {
                    return _classes.map<Widget>((String item) {
                      return Container(
                          width: 80,
                          decoration: BoxDecoration(
                              color: Color(0xff261FFF),
                              borderRadius: BorderRadius.circular(5)),
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
                  items: _classes.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item'),
                      value: item,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                child: Text(
                  'Section',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: DropdownButton<String>(
                  value: _section,
                  onChanged: (String string) => _changeSections(string),
                  underline: Container(),
                  iconSize: 0,
                  selectedItemBuilder: (BuildContext context) {
                    return _sections.map<Widget>((String item) {
                      return Container(
                          width: 80,
                          decoration: BoxDecoration(
                              color: Color(0xff261FFF),
                              borderRadius: BorderRadius.circular(5)),
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
                  items: _sections.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item'),
                      value: item,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                child: Text(
                  'Period',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: DropdownButton<String>(
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
                              borderRadius: BorderRadius.circular(5)),
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
                  items: _period.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item'),
                      value: item,
                    );
                  }).toList(),
                ),
              ),
            ],
          )
        ]),
      ),
      Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  'Choose a Subject',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xff261FFF),
                    borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.only(left: 10),
                child: DropdownButton<String>(
                  value: _currentSubject,
                  onChanged: (String string) => _changeSubject(string),
                  underline: Container(),
                  iconSize: 0,
                  selectedItemBuilder: (BuildContext context) {
                    return _subjects.map<Widget>((String item) {
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
                  items: _subjects.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item'),
                      value: item,
                    );
                  }).toList(),
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Text(
                            'Choose a Chapter',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff261FFF),
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.only(left: 10),
                          child: DropdownButton<String>(
                            value: _currentteacher,
                            onChanged: (String string) =>
                                _changeTeacher(string),
                            underline: Container(),
                            iconSize: 0,
                            selectedItemBuilder: (BuildContext context) {
                              return _teachers.map<Widget>((String item) {
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
                            items: _teachers.map((String item) {
                              return DropdownMenuItem<String>(
                                child: Text('$item'),
                                value: item,
                              );
                            }).toList(),
                          ),
                        ),
                      ]))
            ],
          )),
      Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text(
          'Assign a homework',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Align(
              alignment: Alignment.centerLeft,
              child: TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusColor: Colors.grey,
                    fillColor: Colors.grey,
                    labelText: 'Add a title',
                    labelStyle: TextStyle(color: Colors.pinkAccent)),
                autocorrect: true,
                maxLines: 1,
              ))),
      Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: FittedBox(
              fit: BoxFit.contain,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                      flex: 3,
                      fit: FlexFit.loose,
                      child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusColor: Colors.grey,
                                    fillColor: Colors.grey,
                                    labelText: 'Add description',
                                    labelStyle:
                                        TextStyle(color: Colors.pinkAccent)),
                                autocorrect: true,
                                maxLines: 3,
                              )))),
                  Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: Container(
                          child: RaisedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors_pack.color,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: BorderSide.none),
                                  child: Stack(
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Flexible(
                                              child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: RaisedButton(
                                                    child: Text(
                                                      'Camera',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    onPressed: () {},
                                                    disabledColor:
                                                        Colors_pack.color,
                                                    color: Colors_pack.color,
                                                  ))),
                                          Flexible(
                                              child: Container(
                                                  child: RaisedButton(
                                            child: Text(
                                              'Documents',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {},
                                            disabledColor: Colors_pack.color,
                                            color: Colors_pack.color,
                                          ))),
                                          Flexible(
                                              child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: RaisedButton(
                                                    child: Text(
                                                      'Files',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    onPressed: () {},
                                                    disabledColor:
                                                        Colors_pack.color,
                                                    color: Colors_pack.color,
                                                  ))),
                                        ],
                                      ),
                                      Positioned(
                                          left: 0.0,
                                          bottom: -50.0,
                                          child: RaisedButton(
                                              shape: CircleBorder(
                                                  side: BorderSide.none),
                                              disabledColor: Colors_pack.color,
                                              color: Colors_pack.color,
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              )))
                                    ],
                                  ),
                                );
                              });
                        },
                        disabledColor: Colors_pack.color,
                        color: Colors_pack.color,
                        child: Container(
                          child: Center(
                              child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 50,
                          )),
                        ),
                        shape: CircleBorder(side: BorderSide.none),
                      )))
                ],
              ))),
      Container(
        margin: EdgeInsets.all(10),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
            Widget>[
          Column(
            children: [
              Container(
                child: Text(
                  'Day',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: DropdownButton<String>(
                  value: _submitday,
                  onChanged: (String string) => _changeDate(string),
                  underline: Container(),
                  iconSize: 0,
                  selectedItemBuilder: (BuildContext context) {
                    return day_list.map<Widget>((String item) {
                      return Container(
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              item.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                          ));
                    }).toList();
                  },
                  items: day_list.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item'),
                      value: item,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                child: Text(
                  'Month',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: DropdownButton<String>(
                  value: _submitMonth,
                  onChanged: (String string) => _changeMonth(string),
                  underline: Container(),
                  iconSize: 0,
                  selectedItemBuilder: (BuildContext context) {
                    return _months.map<Widget>((String item) {
                      return Container(
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              item.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                          ));
                    }).toList();
                  },
                  items: _months.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item'),
                      value: item,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                child: Text(
                  'Year',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: DropdownButton<String>(
                  value: _submityear,
                  onChanged: (String string) => _changeYear(string),
                  underline: Container(),
                  iconSize: 0,
                  selectedItemBuilder: (BuildContext context) {
                    return _year.map<Widget>((String item) {
                      return Container(
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              item.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                          ));
                    }).toList();
                  },
                  items: _year.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item'),
                      value: item,
                    );
                  }).toList(),
                ),
              ),
            ],
          )
        ]),
      ),
      Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
            margin: EdgeInsets.all(10),
            width: 200,
            child: RaisedButton(
                onPressed: () {},
                color: Color(0xff261FFF),
                disabledColor: Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('Done',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)))))
      ])
    ]);
  }
}
