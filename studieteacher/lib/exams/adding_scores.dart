import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studieteacher/colors/colors.dart';
import 'exam_details_container.dart';

class adding_scores extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateAddingScore();


}

class _stateAddingScore extends State<adding_scores>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Scores", style: TextStyle(color: Color(0xff261FFF), fontSize: 24, fontWeight: FontWeight.bold),),
        elevation: 0.0,
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(flex:2,child:FittedBox(fit:BoxFit.contain,child:exam_details_container())),
          Flexible(flex:1,child: Container(
            padding: EdgeInsets.only(left: 10),
              child:Text('Maximum Scores', style: TextStyle(fontSize: 20),)
          )),
          Flexible(flex:1, child:Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child:Align(alignment:Alignment.centerLeft,child:TextFormField(
                decoration: InputDecoration(border:InputBorder.none,focusColor: Colors.grey,fillColor: Colors.grey, labelText: 'Enter a number', labelStyle: TextStyle(color: Colors.pinkAccent)),
                autocorrect: true,
                maxLines: 1,
              )

              )),),
          Flexible(flex:1,child: Container(padding: EdgeInsets.only(left: 10),
              child:Text('Add Scores to Students', style: TextStyle(fontSize: 20),)
          )),
          Flexible(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  width: 200,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(10),
                  ),
                    margin: EdgeInsets.all(10),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text('Class 5 Sec B', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  width: 100,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.all(10),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Center(child:Text('Scores', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
                  ),
                ),
              )
            ],
          )),
          Flexible(flex: 6, child:
              Container(margin:EdgeInsets.all(10), child:ListView.builder(scrollDirection:Axis.vertical,itemCount:10,itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  child:Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[

                      Container(
                        child: Center(
                            child:Image.asset("assets/ellipse-2.png",width: 40,height: 40)

                        ),
                      ),
                      Container(
                        margin:EdgeInsets.only(left: 5),
                        child:Text('Aditya Joardar', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Container(
                          child: Align(alignment:Alignment.centerRight,child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:Center(child: Text('100', style: TextStyle(color: Colors.pinkAccent, fontSize: 20, fontWeight: FontWeight.bold),),
                            )),),
                        ),
                      ),
                        Container(child:
                        RaisedButton(disabledColor:Colors_pack.color,color:Colors_pack.color,child:Container(child: Center(child:Icon(Icons.add, color: Colors.white,size: 30,)),),shape: CircleBorder(side: BorderSide.none),))


                    ],
                  ) ,
                );
              })


            ))



        ],
      ),


    );
  }

}