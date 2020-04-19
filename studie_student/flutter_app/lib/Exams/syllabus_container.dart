import 'package:flutter/material.dart';
import 'package:flutterapp/model/Syllabus_Chapter.dart';

class syllabus_container extends StatefulWidget {

  Sy_Ch c;
  syllabus_container(this.c);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _stateI(c);
  }

}


class _stateI extends State<syllabus_container> {

  Sy_Ch _cu;
  _stateI(this._cu);
  bool tapped = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
        onTap: () {
          setState(() {
            tapped = !tapped;
          });
        },
        child:Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
      Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
      child: Text(_cu.name, style: TextStyle(fontSize: 24),),

    ),tapped?Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Text(
              _cu.desc, style: TextStyle(fontSize: 18),
            ),
          ):Container()

        ],
      ),
    ));
  }

}