import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/model/Performance_model.dart';
import 'package:provider/provider.dart';

class performance extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _stateP();
  }

}




class _stateP extends State<performance> {

  var _current1 = 0;
  var _current2 = 0;
  var _topics1 = ["Overall", "Homework", "Exam", "Quiz"];
  var _images1 = ["assets/Group26.png","assets/Group46.png","assets/Group106.png","assets/Group93.png"];
  var _topics2 = ["Summary", "Mathematics","Physics","Chemistry"];
  var _images2 = ["assets/Group81.png","assets/Group84.png","assets/Group49.png","assets/Group63.png"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CheckState();

  }

  GlobalKey<ScaffoldState> globalKey = new GlobalKey();

  void CheckState() async{
    performance_model model = new performance_model();
    bool f = await model.GetPerformance(_topics1[_current1],_topics2[_current2]);
    if (!f){
      globalKey.currentState.showSnackBar(SnackBar(content: Text("Your Performance is not Available!")));
    }

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: globalKey,
      appBar:AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('Performance', style: TextStyle(color: Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      bottomNavigationBar: Row(children: <Widget>[
        Expanded(child: Container(child: Image(image: AssetImage('assets/Group16.png'),height:70,),))
      ],),

      body:Padding(padding: EdgeInsets.only(top:10.0, bottom: 10.0),child:
        Column(crossAxisAlignment:CrossAxisAlignment.stretch,children: <Widget>[
          Flexible(flex:2,child:Container(height:120.0,child:Consumer<performance_model>(builder:
            (context, model, child){return ListView.builder(
            itemCount: _topics1.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context,ind){ return
              InkWell(
                  onTap: () {
                    setState(() {
                      _current1 = ind;
                      model.Change1(_topics1[ind]);
                      CheckState();
                    });

                  },
                  child:Container(height:120, width:100,margin:EdgeInsets.symmetric(horizontal:10.0) ,child:Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
                Container(height:80, width:90, padding:EdgeInsets.all(5),
                    decoration:BoxDecoration(borderRadius: BorderRadius.circular(8),color:(_current1==ind)?Colors_pack.color: Colors.grey[200],
                        boxShadow: [BoxShadow(color:Colors.grey[400], offset: Offset(2, 2))]),
                    child:Image(image: AssetImage(_images1[ind]),height:70, width: 70,)),
                Container(child:Center(
                  child:Text(_topics1[ind],style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
                )),]))));
  },);})
          ),
          ),
          Flexible(flex: 1,fit: FlexFit.loose,child: Container(margin:EdgeInsets.only(left:20.0, top: 10.0, bottom:10.0),height: 40.0,child:
          Text('Subject', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),),),
          Flexible(flex:2,child:Container(height:120.0,child:ListView.builder(
    itemCount: _topics1.length,
    scrollDirection: Axis.horizontal,
    itemBuilder: (context,ind){ return
    InkWell(
    onTap: () {
      setState(() {
        _current2 = ind;
        CheckState();
      });

    },
    child:Container(height:120, width:100,margin:EdgeInsets.symmetric(horizontal:10.0) ,child:Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
    Container(height:80, width:90, padding:EdgeInsets.all(5),
    decoration:BoxDecoration(borderRadius: BorderRadius.circular(8),color:(_current2==ind)?Colors_pack.color: Colors.grey[200],
    boxShadow: [BoxShadow(color:Colors.grey[400], offset: Offset(2, 2))]),
    child:Image(image: AssetImage(_images2[ind]),height:70, width: 70,)),
    Container(child:Center(
    child:Text(_topics2[ind],style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
    ))]))));}
          ),
          )),
          Flexible(flex:2, fit: FlexFit.loose,child: Container(margin:EdgeInsets.all(10.0),height:160.0,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), boxShadow: [BoxShadow(offset: Offset(5, 5),color: Colors.grey[200])],color: Colors.grey[300]),
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
            Expanded(flex:3,child: Container(child:Center(child:Text('Overall Performance',textAlign: TextAlign.center,style: TextStyle(color: Colors_pack.color, fontSize: 35.0),))))
          ,Expanded(flex:2,child:Consumer<performance_model>(builder:(context, model, child){return Container(child:Center(child:Text(model.Qi_pe.toString() + "%",textAlign:TextAlign.center,style: TextStyle(color: Colors_pack.color,fontWeight: FontWeight.w900, fontSize: 50.0),)));})
            )],)),),

          Flexible(flex:3, fit: FlexFit.loose,child: Container(margin:EdgeInsets.all(10.0),height:160.0,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), boxShadow: [BoxShadow(offset: Offset(5, 5),color: Colors.grey[200])],color: Colors.grey[300]),
              child:
              Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                Flexible(flex:1,fit:FlexFit.loose,child: Row(children:[
                  Expanded(flex:2,child:Text('Homework Submission',textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),)),
                 Consumer<performance_model>(builder:(context, model, child){ return Expanded(child:Text(model.Hw_sub.toString()+"%",textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 20.0,fontWeight: FontWeight.bold),));})
                ]))
                ,
                  Flexible(flex:1,fit:FlexFit.loose,child: Row(children:[
                    Expanded(flex:2,child:Text('Exam Performance',textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 20.0,fontWeight: FontWeight.bold),)),
                    Consumer<performance_model>(builder:(context, model, child){ return Expanded(child:Text(model.Hw_sub.toString()+"%",textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 20.0,fontWeight: FontWeight.bold),));})]))
                  ,
                  Flexible(flex:1,fit:FlexFit.loose,child: Row(children:[
                    Expanded(flex:2,child:Text('Quiz Participation',textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 20.0,fontWeight: FontWeight.bold),)),
                    Consumer<performance_model>(builder:(context, model, child){ return Expanded(child:Text(model.Hw_sub.toString()+"%",textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 20.0,fontWeight: FontWeight.bold),));})]))
                  ,
                  Flexible(flex:1,fit:FlexFit.loose,child: Row(children:[
                    Expanded(flex:2,child:Text('Class Performance',textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 20.0,fontWeight: FontWeight.bold),)),
                    Consumer<performance_model>(builder:(context, model, child){ return Expanded(child:Text(model.Hw_sub.toString()+"%",textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 20.0,fontWeight: FontWeight.bold),));})]))
                  ,
              ],)),),
        ],),)
    );
  }

}