import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/models/performance_model.dart';
import 'package:studieteacher/performance/performance_detail.dart';

class performance_Search extends StatefulWidget {
  performance_model model;
  String se;
  performance_Search(this.model, this.se);
  @override
  State<StatefulWidget> createState() => _statePerformance(model, se);
}

class _statePerformance extends State<performance_Search> {
  performance_model m;
  String se;
  _statePerformance(this.m, this.se);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    m.getStudents(se);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:  AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Search', style: TextStyle(color:Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body:Consumer<performance_model>(builder: (context, model, child) { return ListView.builder(itemCount:m.current.length,itemBuilder: (context, ind) {
        return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => performance_detail(m.current[ind])));
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
                  Text(m.current[ind].Name, style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 24),),
                  Text('Class ' + m.classe.toString() + ' Section ' + m.section.toLowerCase(), style:TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 18),)
                ],
              )


            ],
          ),
        ));
      });})
    );
  }

}