import 'package:flutter/material.dart';
import 'package:studieteacher/chapters/add_ans.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/Doubts.dart';


class container_chapters extends StatelessWidget {
  Doubts doubt;
  container_chapters(this.doubt);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => add_ans(doubt)));
        },
        child:Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300]),
      margin: EdgeInsets.all(5),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                border: Border(bottom:BorderSide(width: 2, color: Colors.white))
              ),
              child:Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(flex:1,child:
            Container(padding:EdgeInsets.all(10),child:SizedBox(
              height: 50,
              width: 50,
              child: Image(image: AssetImage("assets/ellipse-2.png")),
            ))),
            Expanded(flex:4,child:
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(child:
                      Container(
                        child: Text(doubt.name, style: TextStyle(color:Colors_pack.color, fontSize: 22),),
                      )),
                      Align(alignment: Alignment.centerRight,child: Text('Class '+ doubt.cl+ " Sec " + doubt.sec, style: TextStyle(color:Colors.black, fontSize: 22),),)

    ],
                  ),
                  Container(
                    child: Text('Student', style: TextStyle(color: Colors.black, fontSize: 18),),
                  )
                ],
              )),
            )
          ],)),
          Container(
            margin: EdgeInsets.all(20),
            child:Text(doubt.message)
          ),
          (doubt.reply.isEmpty)?Container():Container(
            padding: EdgeInsets.all(20),
            color: Colors.pinkAccent,
            child: Text(doubt.reply, style: TextStyle(color: Colors.white),),
          )

        ],

      ),
    ));
  }

}