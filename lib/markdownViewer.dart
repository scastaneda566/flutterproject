import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/material.dart';
import 'noteView.dart';

class markdownViewer extends StatefulWidget {
  final String text;
  final String title;
  markdownViewer({required this.text, required this.title});
  _MarkdownViewerState createState() => _MarkdownViewerState();
}

class _MarkdownViewerState extends State<markdownViewer> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          Markdown(
            data: widget.text,
            ),
        ],
      ),
    );
  }
}
