import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studieteacher/colors/colors.dart';

class quiz_container extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors_pack.color,
      borderRadius: BorderRadius.circular(10)),
      child: Container(padding:EdgeInsets.all(5),child:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(fit:FlexFit.loose,child:
          Row(
            children: <Widget>[
              Expanded(
                child: Container(child:Text("Mathematics",textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),),

              )),
              Expanded(
                child:Container(alignment:Alignment.centerRight,child:Text("Sujoy Dutta", textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),)
              ))
            ],
          )),
          Flexible(fit:FlexFit.loose,child:
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(margin:EdgeInsets.symmetric(vertical: 3),child:Text("Trigonometry + 2",textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 21),),

                  )),
              Expanded(
                  child:Container(margin:EdgeInsets.symmetric(vertical: 3),alignment:Alignment.centerRight,child:Text("Class 5 Sec B", textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold),)
                  ))
            ],
          )),

          Flexible(fit:FlexFit.loose,child:
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(margin:EdgeInsets.symmetric(vertical: 10),child:Text("Addition Quiz",textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 36),),

                  )),
            ],
          )),
          Flexible(fit:FlexFit.loose,child:
          Row(
            children: <Widget>[

              Expanded(
                  child:Container(alignment:Alignment.centerRight,child:Text("5 Q 30 S", textAlign: TextAlign.right, style: TextStyle(color: Colors.yellow, fontSize: 18, fontWeight: FontWeight.bold),)
                  ))
            ],
          )),

        ],
      ),
    ));
  }

}

class container_inner_quiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10)),
        child: Container(padding:EdgeInsets.all(5),child:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(fit:FlexFit.loose,child:
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(child:Text("Mathematics",textAlign: TextAlign.left, style: TextStyle(color: Colors_pack.color, fontWeight: FontWeight.bold, fontSize: 24),),

                    )),
                Expanded(
                    child:Container(alignment:Alignment.centerRight,child:Text("Sujoy Dutta", textAlign: TextAlign.right, style: TextStyle(color: Colors_pack.color, fontSize: 24, fontWeight: FontWeight.bold),)
                    ))
              ],
            )),
            Flexible(fit:FlexFit.loose,child:
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(margin:EdgeInsets.symmetric(vertical: 3),child:Text("Trigonometry + 2",textAlign: TextAlign.left, style: TextStyle(decoration:TextDecoration.underline,color: Colors_pack.color, fontWeight: FontWeight.bold, fontSize: 21),),

                    )),
                Expanded(
                    child:Container(margin:EdgeInsets.symmetric(vertical: 3),alignment:Alignment.centerRight,child:Text("Class 5 Sec B", textAlign: TextAlign.right, style: TextStyle(color: Colors_pack.color, fontSize: 21, fontWeight: FontWeight.bold),)
                    ))
              ],
            )),

            Flexible(fit:FlexFit.loose,child:
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(margin:EdgeInsets.symmetric(vertical: 10),child:Text("Addition Quiz",textAlign: TextAlign.left, style: TextStyle(color: Colors_pack.color,fontSize: 36),),

                    )),
              ],
            )),
            Flexible(fit:FlexFit.loose,child:
            Row(
              children: <Widget>[

                Expanded(
                    child:Container(alignment:Alignment.centerRight,child:Text("5 Q 30 S", textAlign: TextAlign.right, style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),)
                    ))
              ],
            )),

          ],
        ),
        ));
  }

}