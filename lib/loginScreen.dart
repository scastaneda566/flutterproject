import 'package:flutter/material.dart';
import 'dart:convert';
import 'RegisterScreen.dart';
import 'loginData.dart';
import 'noteView.dart';
import 'forgotPass.dart';

class loginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

String email = '';
String password = '';

class GlobalData {
  static String userId = '';
  static String firstName = '';
  static String lastName = '';
  static String email = '';
  static String password = '';
  static String token = '';
  static String rtoken = '';
  static List<Note> notes = <Note>[];
}

class _LoginScreenState extends State<loginScreen> {
  @override
  String message = '';
  String newMessageText = '';

  changeText() {
    setState(() {
      message = newMessageText;
    });
  }

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
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 120.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Email',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 15.0,
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
                              email = text;
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
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Password',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 15.0,
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
                              password = text;
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
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: Colors.white54,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: ElevatedButton(
                        onPressed: () async {
                          String payload = '{"email":"' +
                              email.trim() +
                              '","password":"' +
                              password.trim() +
                              '"}';
                          var userId = '';
                          var jsonObject;
                          String ret = '';
                          try {
                            String url =
                                "https://marky-mark.herokuapp.com/api/users/?email=$email&password=$password";
                            if (email.isEmpty || password.isEmpty) {
                              newMessageText = "Please fill out all fields";
                              changeText();
                              return;
                            }

                            ret = await loginData.getJson(url, payload);
                            jsonObject = json.decode(ret);
                            userId = jsonObject["userId"];
                          } catch (e) {
                            newMessageText = "Incorrect Login/Password";
                            changeText();
                            return;
                          }

                          if (userId.isEmpty) {
                            newMessageText = "Incorrect Login/Password";
                            changeText();
                          } else {
                            GlobalData.userId = userId;
                            GlobalData.firstName = jsonObject["firstName"];
                            GlobalData.lastName = jsonObject["lastName"];
                            GlobalData.email = email;
                            GlobalData.token = jsonObject["accessToken"];

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => noteView()));
                          }
                        },
                        child: Text(
                          'Sign In',
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
                    Container(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                        },
                        style: TextButton.styleFrom(
                          textStyle: TextStyle(
                            fontSize: 10.0,
                          ),
                        ),
                        child: Text('Don\'t have an account? Sign Up'),
                      ),
                    ),
                    Container(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => forgotPass()));
                        },
                        style: TextButton.styleFrom(
                          textStyle: TextStyle(
                            fontSize: 10.0,
                          ),
                        ),
                        child: Text('Forgot password?'),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text('$message',
                            style:
                                TextStyle(fontSize: 10.0, color: Colors.white)),
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
