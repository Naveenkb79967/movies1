import 'package:flutter/material.dart';
import 'package:moives1/Login.dart';
// hi
void main() => runApp(MyApp());


class MyApp extends StatelessWidget
{
  @override

  Widget build(BuildContext context)
  {
    return MaterialApp(title: 'signup',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}

