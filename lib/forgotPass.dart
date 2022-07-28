import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'loginScreen.dart';

class forgotPass extends StatefulWidget {
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<forgotPass> {

  String newPassword = '';
  String e = '';

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF424242),
                  Color(0xFF424242),
                  Color(0xFF424242),
                  Color(0xFF424242),
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 120.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Request Password Reset',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Color(0xFF212121),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      height: 60.0,
                      child: TextField(
                        onChanged: (text) {
                          e = text;
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14.0),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          hintText: 'Email Address',
                          hintStyle: TextStyle(
                            color: Colors.white54,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0,),
                    /*Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Color(0xFF212121),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      height: 60.0,
                      child: TextField(
                        onChanged: (text) {
                          newPassword = text;
                        },
                        obscureText: true,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14.0),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          hintText: 'New Password',
                          hintStyle: TextStyle(
                            color: Colors.white54,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                    ),*/
                    SizedBox(height: 30.0),
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () async {
                          var jsonObject;
                          String ret = '';

                          try{
                            String url = "https://marky-mark-clone.herokuapp.com/api/users/requestreset/?email=$e&type=password";

                            http.Response response = await http.get(Uri.parse(url));
                            ret = response.body;
                            jsonObject = json.decode(ret);
                            print(ret);
                          }
                          catch(e)
                          {
                            print(e.toString());
                            return;
                          }


                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => loginScreen())
                          );
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF6CA8F1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}