import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'noteData.dart';
import 'noteView.dart';
import 'loginScreen.dart';
import 'deleteNoteData.dart';

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
      for (var noteJson in notesJson["results"]) {
        notes.add(Note.fromJson(noteJson));
      }
    }
    return notes;
  }

  void deleteNote(String noteId, int index) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text("Delete Note"),
            content: const Text("Are you sure you want to delete this note?"),
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
                  String nid = _notes[index].id;
                  String jwt = GlobalData.token;
                  String payload = '{"noteIds":["' +
                      nid.trim() +
                      '"],"jwtToken":"' +
                      jwt.trim() +
                      '"}';
                  print(payload);

                  try {
                    String url =
                        'https://marky-mark.herokuapp.com/api/users/$id/notes';
                    ret = await deleteNoteData.getDelNoteJson(url, payload);
                    jsonObject = json.decode(ret);
                    print(jsonObject);
                  } catch (e) {
                    print(e.toString());
                    return;
                  }

                  Navigator.of(context).pop();
                  setState(() {});
                },
                child: Text('Delete'),
              ),
            ],
          );
        });
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
            return ListTile(
              leading: Text(
                _notes[index].name,
                style: TextStyle(color: Colors.white),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  deleteNote(_notes[index].id, index);
                },
              ),
            );
          },
          itemCount: _notes.length,
        ),
      ),
    );
  }
}
