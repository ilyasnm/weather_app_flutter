import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pfe/Login.dart';
import 'package:http/http.dart' as http;


void main(){
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: LoginScreen(),
    );
  }
}




