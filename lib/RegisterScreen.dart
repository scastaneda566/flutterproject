import 'package:flutter/material.dart';
import 'dart:convert';
import 'loginScreen.dart';
import 'registerData.dart';
import 'emailVerif.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

String email = '';
String firstName = '';
String lastName = '';
String password = '';
String passwordConfirm = '';

class _RegisterScreenState extends State<RegisterScreen> {
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
                    'Sign Up',
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
                        'Email address',
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
                            hintText: 'Enter email',
                            hintStyle: TextStyle(
                              color: Colors.white54,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'First Name',
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
                            firstName = text;
                          },
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(
                              IconData(0xee34, fontFamily: 'MaterialIcons'),
                              color: Colors.white,
                            ),
                            hintText: 'Enter First Name',
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
                        'Last Name',
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
                            lastName = text;
                          },
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(
                              IconData(0xee34, fontFamily: 'MaterialIcons'),
                              color: Colors.white,
                            ),
                            hintText: 'Enter Last Name',
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
                            hintText: 'Enter Password',
                            hintStyle: TextStyle(
                              color: Colors.white54,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Confirm Password',
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
                            passwordConfirm = text;
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
                            hintText: 'Confirm Password',
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'At least 6 characters and must contain 1 uppercase and 1 number',
                        style: TextStyle(
                          color: Colors.white54,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                  Container(
                      alignment: Alignment.bottomLeft,
                      child: ElevatedButton(
                        onPressed: () async {
                          String payload = '{"firstName":"' +
                              firstName.trim() +
                              '","lastName":"' +
                              lastName.trim() +
                              '","email":"' +
                              email.trim() +
                              '","password":"' +
                              password.trim() +
                              '"}';
                          var jsonObject;
                          String ret = '';

                          try {
                            String url =
                                "https://marky-mark.herokuapp.com/api/users";

                            RegExp regex = RegExp(
                                r'^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9]).{8,}$');

                            if (firstName.isEmpty ||
                                lastName.isEmpty ||
                                email.isEmpty ||
                                password.isEmpty ||
                                passwordConfirm.isEmpty) {
                              newMessageText = "Please fill out all fields";
                              changeText();
                              return;
                            } else if (password.compareTo(passwordConfirm) !=
                                0) {
                              newMessageText = "Passwords do not match.";
                              changeText();
                              return;
                            } else if (!regex.hasMatch(password)) {
                              newMessageText =
                                  "Password does not meet requirements";
                              changeText();
                              return;
                            }

                            ret = await registerData.getRegJson(url, payload);
                            jsonObject = json.decode(ret);
                          } catch (e) {
                            newMessageText = 'User already exists';
                            changeText();
                            print(e.toString());
                            return;
                          }

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => emailVerif()));
                        },
                        child: Text(
                          'Sign Up',
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
                      )),
                  Row(
                    children: <Widget>[
                      Text('$message',
                          style:
                              TextStyle(fontSize: 10.0, color: Colors.white)),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: CloseButton(color: Color(0xFF212121)),
          )
        ],
      ),
    );
  }
}
