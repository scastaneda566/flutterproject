import 'package:flutter/material.dart';
import 'package:largeprojecttesting/loginScreen.dart';
import 'loginScreen.dart';

class emailVerif extends StatefulWidget {
  _EmailVerifState createState() => _EmailVerifState();
}

class _EmailVerifState extends State<emailVerif> {
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
                      'Please check your email to verify your account before logging in',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => loginScreen())
                          );
                        },
                        child: Text(
                          'Go to Login Page',
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