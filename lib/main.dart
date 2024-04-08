import 'package:flutter/material.dart';
import 'package:wheels_un/add_new_creditCard.dart';

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
      },
      debugShowCheckedModeBanner: false,
      home: AddNewCardScreen(),

    );
  }
}



