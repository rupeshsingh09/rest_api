import 'package:flutter/material.dart';
import 'package:rest_api/Models/drop_down_api.dart';
import 'package:rest_api/example_four.dart';
import 'package:rest_api/example_three.dart';
import 'package:rest_api/example_two.dart';
import 'package:rest_api/home_screen.dart';
import 'package:rest_api/last_example.dart';
import 'package:rest_api/signup.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: const DropDownApi(),
    );
  }
}

