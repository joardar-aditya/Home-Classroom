import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/absent_students.dart';
import 'package:studieteacher/models/hw_submit_model.dart';

import '../Student.dart';

class hw_container extends StatefulWidget {

  Student _name;
  var _index;
  hw_container(this._name, this._index);
  @override
  State<StatefulWidget> createState() => _attendanceS(_name, _index);

}



class _attendanceS extends State<hw_container>{

  Student student;
  int index;
  _attendanceS(this.student, this.index);
  var bool = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    String name = student.Name;
    return Consumer<hw_submit>(builder:(context, model, child){return InkWell(
        onTap: () {
          setState(() {
            bool = !bool;
          });

          model.AddSubmittion(student);
        },
        child:Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: bool?Colors.pinkAccent:Colors_pack.color,
                borderRadius: BorderRadius.circular(5)
            ),padding: EdgeInsets.only(left:10, top:10, bottom: 10),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(padding:EdgeInsets.only(right: 10),child: Text('$index.', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                ),Container(decoration: BoxDecoration(color:Colors.blue, shape: BoxShape.circle),height: 50, width: 50,),
                Container(padding:EdgeInsets.only(left:10), child:Text('$name', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                )
              ],
            )

        ));});
  }


}