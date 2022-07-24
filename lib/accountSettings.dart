import 'package:flutter/material.dart';
import 'package:largeprojecttesting/deleteUserData.dart';
import 'dart:convert';
import 'loginScreen.dart';
import 'deleteUserData.dart';
import 'changeNameData.dart';

class accountSettings extends StatefulWidget {

  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<accountSettings> {

  String tempFirst = GlobalData.firstName;
  String tempLast = GlobalData.lastName;
  
  void _logout(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text("Logout"),
            content: const Text("Are you sure you want to logout?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  GlobalData.userId = '';
                  GlobalData.firstName = '';
                  GlobalData.lastName = '';
                  GlobalData.email = '';
                  GlobalData.password = '';
                  tempFirst = '';
                  tempLast = '';
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => loginScreen()));
                  print(GlobalData.firstName);
                },
                child: Text("Logout"),
              ),
            ],
          );
        }
        );
  }

  void _deleteUser(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text("Delete account"),
            content: const Text("Are you sure you want to delete this account?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {

                  var jsonObject;
                  String ret = '';
                  String id = GlobalData.userId;
                  String e = GlobalData.email;
                  String payload = '{"email":"' + e.trim() + '"}';

                  try {
                    String url = "https://marky-mark.herokuapp.com/api/users/$id";
                    print(url);
                    ret = await deleteUserData.getDelJson(url, payload);
                    jsonObject = json.decode(ret);
                    print(jsonObject);

                  }
                  catch(e) {
                    print(e.toString());
                    return;
                  }

                  GlobalData.userId = '';
                  GlobalData.firstName = '';
                  GlobalData.lastName = '';
                  GlobalData.email = '';
                  GlobalData.password = '';
                  tempFirst = '';
                  tempLast = '';

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => loginScreen()));
                },
                child: Text("Delete"),
              ),
            ],
          );
        }
    );
  }

  void _changeName(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text("Enter new first and last name"),
            content:
              Container(
                height: 200.0,
                width: 200.0,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:9.0),
                      child: TextField(
                        onChanged: (text) {
                          tempFirst = text;
                        },
                        decoration: InputDecoration(
                          hintText: 'New First Name',
                        ),
                      )
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top:9.0),
                        child: TextField(
                          onChanged: (text) {
                            tempLast = text;
                          },
                          decoration: InputDecoration(
                            hintText: 'New Last Name',
                          ),
                        )
                    ),
                  ],
                ),
              ),

            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {

                  var jsonObject;
                  String ret = '';
                  String id = GlobalData.userId;
                  String payload = '{"userId":"' + id.trim() + '","newFirstName":"' + tempFirst.trim() + '","newLastName":"' + tempLast.trim() + '"}';

                  try {
                    String url = "https://marky-mark.herokuapp.com/api/users/changename";
                    ret = await changeNameData.getChangeJson(url, payload);
                    jsonObject = json.decode(ret);
                    print(jsonObject);
                  }
                  catch(e)
                  {
                    print(e.toString());
                    return;
                  }

                  Navigator.of(context).pop();
                },
                child: Text("Change"),
              ),
            ],
          );
        }
    );
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget> [
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
                children: <Widget> [
                  Text(
                    'Account Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () => _changeName(context),
                      child: Text(
                        'Change Name',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(200, 36.0),
                          primary: Color(0xFF6CA8F1),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () => _logout(context),
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(200, 36.0),
                        primary: Color(0xFF6CA8F1),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () => _deleteUser(context),
                        child: Text(
                          'Delete Account',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(200, 36.0),
                          primary: Color(0xFF6CA8F1),
                        ),
                      )
                  ),
                  SizedBox(height:10.0),
                  Container(
                    alignment: Alignment.center,
                    width: 200.0,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Exit Settings',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(200, 36.0),
                          primary: Color(0xFF6CA8F1),
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}