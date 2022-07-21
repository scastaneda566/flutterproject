import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GlobalData {
  static int userId = 0;
  static String firstName = "";
  static String lastName = "";
  static String loginName = "";
  static String password = "";
}

class Note {
  int userId = -1;
  String id = "";
  String name = "";
  String body = "";
  List<String> tags = [];

  Note({
    required this.userId,
    required this.name,
    required this.body,
    required this.tags,
    required this.id,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      userId: json['userId'],
      id: json['_id'],
      name: json['noteName'],
      body: json['noteBody'],
      tags: json['noteTags'],
    );
  }
}

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
}
