import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'NavBar.dart';
import 'loginScreen.dart';
import 'accountSettings.dart';
import 'search.dart';

class noteView extends StatefulWidget {
  @override
  _NoteViewState createState() => _NoteViewState();
}

class _NoteViewState extends State<noteView> {
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();
  String tempFirst = GlobalData.firstName;
  String tempLast = GlobalData.lastName;

  @override
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
        });
  }

  Icon customIcon = const Icon(Icons.search);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Color(0xFF6CA8F1), opacity: 1, size: 40),
        title: Text('$tempLast, $tempFirst',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF212121),
        leading: IconButton(
          icon: Icon(Icons.toc_rounded),
          onPressed: () {
            if (_drawerscaffoldkey.currentState!.isDrawerOpen) {
              Navigator.pop(context);
            } else {
              _drawerscaffoldkey.currentState!.openDrawer();
            }
          },
        ),
        actions: [
          IconButton(
            icon: customIcon,
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  customIcon = const Icon(Icons.cancel);
                } else {
                  customIcon = const Icon(Icons.search);
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => accountSettings()));
            },
          ),
        ],
      ),
      body: Scaffold(
        backgroundColor: Color(0xFF424242),
        key: _drawerscaffoldkey,
        drawer: navBar(),
      ),
    );
  }
}

class Note {
  String name = "";

  Note(this.name);

  Note.fromJson(Map<String, dynamic> json) {
    name = json['noteName'];
  }
}
