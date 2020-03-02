import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';



class ViewQuiz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _stateView();



}

class _stateView extends State<ViewQuiz>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var slider_basic = CarouselSlider.builder(
        height: double.maxFinite,
        viewportFraction: 1.0,
        scrollDirection: Axis.horizontal,
        itemCount: 15, itemBuilder: (context, item) =>
        Container(
            child:Column(
              children: <Widget>[
                Expanded(
                    child:Stack(
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
                                    child:Text('What is the capital of Australia?', style: TextStyle(color:Colors.white, fontSize: 22),)
                                )
                              ],
                            )
                        ),

                      ],
                    )
                ),
                Expanded(
                    child:Container(
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
                                        child:Text('00:00', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),)
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
                                    child: Center(
                                        child:Text('Edit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),)
                                    ),
                                  )

                              )),

                          Center(
                            child:Container(
                                height: 250,
                                child:ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: <Widget>[
                                Container(
                                  margin:EdgeInsets.all(10),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color:Colors.grey[300]
                                  ),
                                  child:Text('Canberra',style: TextStyle(fontWeight:FontWeight.bold,color:Colors.pinkAccent, fontSize: 22),)
                                ),
                                Container(
                                    margin:EdgeInsets.all(10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color:Colors.grey[300]
                                    ),
                                    child:Text('Canberra', style: TextStyle(fontWeight:FontWeight.bold,color:Colors.pinkAccent, fontSize: 22),)
                                ),
                                Container(
                                    margin:EdgeInsets.all(10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color:Colors.grey[300]
                                    ),
                                    child:Text('Canberra', style: TextStyle(fontWeight:FontWeight.bold,color:Colors.pinkAccent, fontSize: 22),)
                                ),
                                Container(
                                    margin:EdgeInsets.all(10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color:Colors.grey[300]
                                    ),
                                    child:Text('Canberra', style: TextStyle(fontWeight:FontWeight.bold,color:Colors.pinkAccent, fontSize: 22),)
                                ),


                              ],
                            )
                          ))


                        ],
                      ),
                      color:Colors.white,
                    ),

                ),
              ],
            )
        ));
    return Scaffold(
      extendBody: true,
      bottomSheet: Container(height:70,child:RaisedButton(color:Colors_pack.color,
          disabledColor:Colors_pack.color,
          onPressed: () {slider_basic.nextPage(duration:Duration(milliseconds: 500),curve: Curves.linear);},
          child:Center(child: Text('Next', style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),))),
      backgroundColor: Colors_pack.color,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors_pack.color,
        leading: RaisedButton(onPressed:() {Navigator.pop(context);},color:Colors_pack.color,disabledColor:Colors_pack.color,child: Icon(Icons.cancel, color: Colors.white,size: 40,),)),
       body: slider_basic,

    );
  }

}