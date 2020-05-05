import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studieteacher/colors/colors.dart';
import 'package:studieteacher/main.dart';
import 'package:studieteacher/starting.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class sign_in extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _sign_in_state();
}

class _sign_in_state extends State<sign_in> {
  var initid;
  var studentid;
  var password;

  var loading = false;

  void _changeState(String token, String s, String sccode, String pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("user", token);
    sharedPreferences.setString("tcode", s);
    sharedPreferences.setString("icode", sccode);
    sharedPreferences.setString("password", pass);
    Uri uri = Uri.https("studie-server-dot-project-student-management.appspot.com","/teacher/profile/$sccode", {
      "code": s,
    });

    var res = await http.get(uri, headers: {
      "x-access-token":token,
      "type":"teacher"
    });
    var j = jsonDecode(res.body);
    if(res.statusCode == 200){
      print(res.body);
      if(j["status"]=="success"){
        /*final FirebaseAuth _auth = FirebaseAuth.instance;
        final FirebaseUser user = (await _auth.signInWithEmailAndPassword(email: j["data"]["data"]["email"], password: pass)).user;
        print("signed in " + user.displayName);*/
        sharedPreferences.setString("global_state", "yes");
        sharedPreferences.setString("name", j["data"]["data"]["name"]);
        sharedPreferences.setString("tid", j["data"]["id"]);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => starting()));

      }else{
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('User not Found!'),));
        setState(() {
          loading = false;
        });
      }
    }else{
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('User not Found!'),));
      setState(() {
        loading = false;
      });
    }
}

  void saveinitid(value) {
    setState(() {
      initid = value;
    });
  }

  void savestudent(value) {
    setState(() {
      studentid = value;
    });
  }

  void savepass(value) {
    setState(() {
      password = value;
    });
  }

  void login() async {
    setState(() {
      loading = true;
    });
    print("I was called");
    print(initid.toString());
    print(studentid.toString());
    print(password.toString());
    var uri = Uri.https("studie-server-dot-project-student-management.appspot.com","/login/");

    var response = await http.post(uri, headers: {
      "type": "teacher",
    }, body: {
      'icode': initid.toString(),
      'uname': studentid.toString(),
      'pass': password.toString(),
    },);



    Map<String, dynamic> json = jsonDecode(response.body);
    if(json.containsKey("x-access-token")){
      _changeState(json["x-access-token"], studentid.toString(), initid.toString(), password.toString());

    }else{
      print("yaha se");
      print(response.body);
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('User not Found!'),));
      setState(() {
        loading = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            loading?Container(child:Center(
              child: CircularProgressIndicator(),
            )):Padding(
              padding: EdgeInsets.only(bottom:25.0, top:5, left:5, right:5),
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(5),
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              saveinitid(value);
                            },
                            decoration: new InputDecoration(
                              hintText: "Enter Institution Code",
                              focusColor: Colors.white,
                              labelStyle: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w500,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              savestudent(value);
                            },
                            decoration: new InputDecoration(
                              hintText: "Enter Teacher Code",
                              labelStyle: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w500,
                              ),
                              fillColor: Colors.white,
                              focusColor: Colors.blue,
                              filled: true,
                            )),
                      ),
                   Container(
                        margin: EdgeInsets.all(5),
                        child: TextFormField(
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              savepass(value);
                            },
                            decoration: new InputDecoration(
                              hintText: "Enter Password",
                              labelStyle: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w500,
                              ),
                              fillColor: Colors.white,
                              focusColor: Colors.blue,
                              filled: true,
                            )),
                      ),

                ],
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child:ButtonTheme(
            minWidth: 200.0,
            height: 40.0,child:
            RaisedButton(
              color: Colors_pack.color,
              elevation: 1.0,
              hoverElevation: 1.5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: () {
                if (initid == null &&
                    studentid == null &&
                    password == null) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Please enter all the details')));
                } else if (initid == "" &&
                    studentid == "" &&
                    password == "") {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Please enter all the details')));
                } else {
                  login();
                }
                //Navigator.push(context, MaterialPageRoute(builder: (context) => starting()));
              },
              child: Text(
                'LOG IN',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              disabledColor: Colors.blue,
            )))
          ],
        ));
  }
}
