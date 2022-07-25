import 'dart:convert';

class Note {
  int userId = -1;
  String id = "";
  String name = "";
  String body = "";
  List<String> tags = [];

  Note(
    this.userId,
    this.name,
    this.body,
    this.tags,
    this.id,
  );

  Note.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['_id'];
    name = json['noteName'];
    body = json['noteBody'];
    tags = json['noteTags'];
  }

  static List<Note> getNotesArr(String ret) {
    List<Note> notes = <Note>[];

    List<dynamic> noteList = jsonDecode(ret);

    int len = noteList.length;
    print(noteList);
    for (var i = 0; i < len; i++) {
      notes[i] = (Note.fromJson(noteList[i]));
    }

    return notes;
  }
}
