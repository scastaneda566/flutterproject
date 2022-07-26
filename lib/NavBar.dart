import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'noteData.dart';
import 'noteView.dart';
import 'loginScreen.dart';

class navBar extends StatefulWidget {
  @override
  navBarState createState() => navBarState();
}

class navBarState extends State<navBar> {
  List<Note> _notes = <Note>[];

  Future<List<Note>> fetchNotes() async {
    String id = GlobalData.userId;
    String jwt = GlobalData.token;
    var url =
        "https://marky-mark.herokuapp.com/api/users/$id/notes?searchText=&tags[]=&jwtToken=$jwt";
    var response = await http.get(Uri.parse(url));
    var notes = <Note>[];

    if (response.statusCode == 200) {
      var notesJson = jsonDecode(response.body);
      print(notesJson["results"]);
      for (var noteJson in notesJson["results"]) {
        notes.add(Note.fromJson(noteJson));
      }
    }
    return notes;
  }

  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromARGB(255, 17, 29, 45),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              height: 50.0,
              child: Card(
                color: Color(0xFF212121),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _notes[index].name,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: _notes.length,
        ),
      ),
    );
  }
}
