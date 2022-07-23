import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'noteView.dart';
import 'NavBar.dart';

class noteData {
  Future<Note> getNote(String url, String outgoing) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      //server returns ok response, parse json
      return Note.fromJson(jsonDecode(response.body));
    } else {
      //throw an exception, server did not return ok response.
      throw Exception('Failed to load');
    }
  }

  Future<Note> deleteNote(String url, String id) async {
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      //server returns ok response, parse json
      return Note.fromJson(jsonDecode(response.body));
    } else {
      //throw an exception, server did not return ok response.
      throw Exception('Failed to load');
    }
  }

  static Future<List<Note>> getNotes(String url, String id) async {
    final uri = Uri.parse(url);
    List<Note> notes = <Note>[];

    try {
      http.Response response = await http.get(uri);

      var notesJson = json.decode(response.body);

      for (var noteJson in notesJson) {
        notes.add(Note.fromJson(noteJson));
      }
    } catch (e) {
      print(e.toString());
    }

    return notes;
  }
}
