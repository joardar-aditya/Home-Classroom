import 'package:flutter/material.dart';

class title_container extends StatelessWidget {
  var _title;

  title_container(this._title);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(10),
      child:Text(
        _title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      )
    );
  }

}