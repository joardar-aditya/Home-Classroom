import 'package:flutter/material.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/performance/performance_detail.dart';

class performance_Search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _statePerformance();
}

class _statePerformance extends State<performance_Search> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:  AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Search', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body:ListView.builder(itemCount:4,itemBuilder: (context, ind) {
        return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => performance_detail("Subhojit Dey", "a101002")));
            },
            child:Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                 decoration: BoxDecoration(
                   color: Colors_pack.color,
                   shape: BoxShape.circle
                 ),
                height: 75,
                width: 75,
                margin: EdgeInsets.all(20),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Subhodip Dey', style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 24),),
                  Text('Class 5 Sec C', style:TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 18),)
                ],
              )


            ],
          ),
        ));
      })
    );
  }

}