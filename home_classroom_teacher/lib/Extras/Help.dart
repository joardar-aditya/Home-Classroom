import 'package:flutter/material.dart';
import 'package:studieteacher/colors/colors.dart';

class Help extends StatelessWidget{



  List<String> questions = ["What is studie?", "What is the cost involved?", "How to register?", "How to get the Studie app in mobile?",
  "Can we reply back to teachers?", "How is it better than Institution's Website?"];
  List<String> answers = ["a simple online Learning Management System for teachers, students & parents to organise the way they teach, learn & manage respectively.",
  "it is free for institutions and we charge a minimum amount to each students to maintain the system and the updates in real-time.",
  "the parents ID and password will be provided to their registered mail (provided to the institution) and from that they can login. If they forget their password they can get a new password through the same email on clicking \"Forgot Password\".",
  "it is available on play store and ios. So you can just download it from any platform",
  "yes. Definitely. It has a feature where parents and teachers can have a meeting for the student's growth in each and every particular places cause it is not jut best at institutional communication but also best at student's overall growth.",
  "it is a super value addition to you posting things on your website. You can never be sure of what time parents log into web & read something that you posted. You cannot be sure if they actually received what you wanted when it was needed or not. Studie is instant, real-time & right in the hands & pockets of parents. It also has a payment attribute which is a plus one situation in any condition with a reciept."];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:AppBar(
        elevation: 0.0,
        leading: RaisedButton(color:Colors.white, elevation:0.0, onPressed:() {Navigator.pop(context);},child:Image(image:AssetImage('assets/back.png'), height: 50,) ),
        title: Text('FAQ', style: TextStyle(color: Colors_pack.color, fontWeight: FontWeight.w700, fontSize: 28),),
      ),
      body: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, it){
        return Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  questions[it], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              answers[it], style: TextStyle(fontSize: 18,),
            ),

              )
            ],
          ),
        );
      }),

    );
  }

}