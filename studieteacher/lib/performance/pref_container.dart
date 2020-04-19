import 'package:flutter/material.dart';
import 'package:studieteacher/colors/colors.dart';


class pref_container extends StatelessWidget {

  var _tapped = false;
  pref_container(this._tapped, this.name, this.icon);
  var name;
  var icon;

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:_tapped?Colors_pack.color:Colors.grey[300],
              borderRadius: BorderRadius.circular(10)
            ),

            child:Image(
              image: AssetImage(icon),
              height: 80,
              width: 80,
            ),
          ),
        Container(
          margin: EdgeInsets.all(10),
          child:Text(name, style: TextStyle(color:Colors.black, fontSize: 18),)
        )
      ],
    );
  }

}