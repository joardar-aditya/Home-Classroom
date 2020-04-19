import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutterapp/Quiz/questionView.dart';
import 'package:flutterapp/Quiz/result.dart';
import 'package:flutterapp/model/current_q.dart';
import 'package:provider/provider.dart';



class ViewQuiz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateView();



}

class _stateView extends State<ViewQuiz>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      extendBody: true,
      bottomSheet: Consumer<current_q>(builder:(context, model, ch){return Container(height:70,child:RaisedButton(color:Colors_pack.color,
          disabledColor:Colors_pack.color,
          onPressed: () {
        if(model.current==model.questions.length-1){
               if(model.Selected == model.questions[model.current].Correct){
                 model.AddCScore();
                 model.Change_selected("");
                 model.StopExam();
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> result(model) ));
               }else{
                 model.Change_selected("");
                 model.StopExam();
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> result(model) ));}
        }else{
          if(model.Selected == model.questions[model.current].Correct){
            model.AddCScore();
            model.Change_selected("");
          }else{
          model.AddIScore();
          model.Change_selected("");}
          }},
          child:Center(child:
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
            Text('Next', style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
                Icon(Icons.arrow_forward, color: Colors.white, size: 40,)]))));}),
      backgroundColor: Colors_pack.color,
      appBar: AppBar(
        actions: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              width: 300,
              height:25,
              child:Consumer<current_q>(builder:(context,model,ind){ return ListView.builder(
                  scrollDirection:Axis.horizontal,shrinkWrap:true, itemCount:model.questions.length,itemBuilder: (context, item) {

                    return Container(
              width:25,
              height: 20,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color:(model.current==item)?Colors_pack.color:Colors.grey[300],
                borderRadius: BorderRadius.circular(10)
              ),
              child:Center(child:Text(item.toString(), style: TextStyle(
                  fontWeight:FontWeight.w700,fontSize: 16,
                  color:(model.current==item)?Colors.white:Colors_pack.color),)
            ));
          });})),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.all(10),
            child:Text('..', style:TextStyle(fontWeight: FontWeight.w900, fontSize: 34, color:Colors.white))
          )
        ],
        elevation: 0.0,
        backgroundColor: Colors_pack.color,
        leading: Consumer<current_q>(builder:(context, model, child){return RaisedButton(onPressed:() {
          model.ClearCurrentQ();
          Navigator.pop(context);},color:Colors_pack.color,disabledColor:Colors_pack.color,
    child: Icon(Icons.cancel, color: Colors.white,size: 40,),);})),
       body: Consumer<current_q>(builder:(context, model, child){
         var _current = model.Current;
         if(int.parse(model.Minutes)<0){
           SchedulerBinding.instance.addPostFrameCallback((_) {

             // add your code here.
             model.StopExam();
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> result(model) ));
           });

         }
         print(_current.Options);
         return  Container(
           child:ListView(
             children: <Widget>[
               Container(
                   height: 400,
                   child:
                   Stack(
                     overflow: Overflow.visible,
                     children: <Widget>[

                       Center(
                           child:Column(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisSize: MainAxisSize.min,
                             children: <Widget>[
                               Container(
                                 decoration: BoxDecoration(
                                     color: Colors.grey[400],
                                     borderRadius: BorderRadius.circular(20)
                                 ),
                                 height:200,
                                 width: 200,

                               ),
                               Container(
                                   margin: EdgeInsets.symmetric(vertical: 10),
                                   child:Text(_current.Title, style: TextStyle(color:Colors.white, fontSize: 22),)
                               )
                             ],
                           )
                       ),

                     ],
                   ))
               ,Container(
                 height:400,
                 margin: EdgeInsets.only(bottom: 20),
                 child:Stack(
                   overflow: Overflow.visible,
                   children: <Widget>[
                     Positioned(
                         top: -20.0,
                         left:30.0,
                         child:InkWell(
                             child:Container(
                               height:50,
                               width:120,
                               padding: EdgeInsets.all(10),
                               decoration: BoxDecoration(
                                   color:Colors.pinkAccent,
                                   borderRadius: BorderRadius.circular(10)
                               ),
                               child: Center(
                                   child:Text(model.Minutes+":"+model.Seconds, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),)
                               ),
                             )

                         )),
                     Positioned(
                         top: -20.0,
                         right:30.0,
                         child:InkWell(
                             child:Container(
                               height:50,
                               width:120,
                               padding: EdgeInsets.all(10),
                               decoration: BoxDecoration(
                                   color:Colors.pinkAccent,
                                   borderRadius: BorderRadius.circular(10)
                               ),
                               child:FittedBox(
                                 fit: BoxFit.fitWidth,
                                 child: Center(
                                   child:Text('Best of Luck', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),)
                               ),
                             ))

                         )),

                     Center(
                         child:(_current.Options.isEmpty)?Container(
                           margin: EdgeInsets.all(20),
                           child: TextField(
                             onChanged: (s) {
                               model.Change_selected(s);
                             },
                             decoration: InputDecoration(
                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                               hintText: "Enter your Answer",
                               hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w300)
                             ),
                           ),
                         ):Container(
                             child:ListView.builder(
                               shrinkWrap: true,
                               itemCount: _current.Options.length,
                               physics: NeverScrollableScrollPhysics(),
                               scrollDirection: Axis.vertical,
                               itemBuilder: (context,i) {return
                                 InkWell(
                                     onTap: () {
                                       model.Change_selected(_current.Options[i]);
                                     },
                                     child:Container(
                                     margin:EdgeInsets.all(10),
                                     padding: EdgeInsets.all(10),
                                     decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(20),
                                         color:(_current.Options[i]==model.Selected)?Colors_pack.color:Colors.grey[300]
                                     ),
                                     child:Text(_current.Options[i],style: TextStyle(fontWeight:FontWeight.bold,color:Colors.pinkAccent, fontSize: 22),)
                                 ));},
                             )
                         ))


                   ],
                 ),
                 color:Colors.white,
               ),


             ],
           )
       );})

    );
  }

}