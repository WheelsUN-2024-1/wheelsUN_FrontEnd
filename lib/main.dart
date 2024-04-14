import 'package:flutter/material.dart';
import 'package:wheels_un/map_page.dart';
import 'package:wheels_un/add_new_creditCard.dart';
import 'package:wheels_un/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes:{
        "creditCard":(context) => AddNewCardScreen(),
        "map": (context) => MapPage()
      },
      debugShowCheckedModeBanner: false,
     
      //home: MapPage(),
     
      home: MapPage(),

    );
  }
}



