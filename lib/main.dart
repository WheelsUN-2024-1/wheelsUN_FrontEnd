import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheels_un/services/auth_gate.dart';
import 'package:wheels_un/services/auth_provier.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WheelsUN',
      home: AuthGate(),  
    );
  }
}
