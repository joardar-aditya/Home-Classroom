import 'dart:convert';

import 'package:dbcrypt/dbcrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:flutterapp/Color/colors.dart';
import 'package:flutterapp/starting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class sign_in extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _sign_in_state();
}

class _sign_in_state extends State<sign_in> {
  var initid;
  var studentid;
  var password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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



  void _changeState(String token, String s, String sccode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("user", token);
    sharedPreferences.setString("tcode", s);
    sharedPreferences.setString("icode", sccode);
    var uri = Uri.https("studie-server-dot-project-student-management.appspot.com", "student/performance/$sccode/", {
      "scode": s,
    });
    print(uri);
    var res = await http.get(uri, headers: {
      "x-access-token": token,
      "type":"student"
    });
    print(res.body);
    var j = jsonDecode(res.body);
    if(res.statusCode==200){
      if(j["status"]=="success"){
        sharedPreferences.setString("name", j["data"]["data"]["name"]);
        sharedPreferences.setString("class", j["data"]["data"]["class"]);
        sharedPreferences.setString("section", j["data"]["data"]["section"]);
        print(j["data"]["data"]["section"]);
        print(j["data"]["data"]["class"]);
        sharedPreferences.setString("global_state", "yes");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => starting()));
      }else{
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('User not Found!'),));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => starting()));
      }
    }
    print(token);
  }

  void login() async {
    print("I was called");
    print(initid.toString());
    print(studentid.toString());
    print(password.toString());
    var uri = Uri.https("studie-server-dot-project-student-management.appspot.com","/login/");
    var response = await http.post(uri, headers: {
      "type": "student",
    }, body: {
      'icode': initid.toString(),
      'uname': studentid.toString(),
      'pass': password.toString(),
    },);

    print(response.body);

    Map<String, dynamic> json = jsonDecode(response.body);
    if(json.containsKey("x-access-token")){
      _changeState(json["x-access-token"], studentid.toString(), initid.toString());
    }else{
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('User not Found!'),));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.grey[200],
        ),
        margin: EdgeInsets.all(10.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Padding(
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
                          border: new OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: new BorderRadius.circular(25.0),
                          ),
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
                          hintText: "Enter Student Code",
                          labelStyle: TextStyle(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w500,
                          ),
                          fillColor: Colors.white,
                          focusColor: Colors.blue,
                          filled: true,
                          border: new OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: new BorderRadius.circular(25.0),
                          ),
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
                          border: new OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: new BorderRadius.circular(25.0),
                          ),
                        )),
                  ),

                ],
              ),
            ),
            Positioned(bottom:-20.0,child:ButtonTheme(
                minWidth: 200.0,
                height: 40.0,child:
            RaisedButton(
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
                'SIGN IN',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              color: Colors_pack.color,
            )))
          ],
          overflow: Overflow.visible,
        ));
  }
}
