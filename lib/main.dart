import 'package:flutter/material.dart';
import 'loginScreen.dart';
import 'RegisterScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MarkyMark",
      debugShowCheckedModeBanner: false,
        home:loginScreen(),
    );
  }
}
