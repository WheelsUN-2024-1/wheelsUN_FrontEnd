import 'package:flutter/material.dart';
import 'package:wheels_un/list_trips.dart';
import 'package:wheels_un/map_page.dart';
import 'package:wheels_un/add_new_creditCard.dart';
import 'package:wheels_un/pages/home_page.dart';
import 'package:wheels_un/pages/login_page.dart';
import 'package:wheels_un/pages/sign_up_page.dart';
import 'package:wheels_un/pages/register_vehicle.dart';
import 'package:wheels_un/pages/profile_page.dart';
import 'package:wheels_un/select_creditCard.dart';
import 'package:wheels_un/view_creditcards.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "creditCard": (context) => AddNewCardScreen(),
        "map": (context) => MapPage()
      },
      debugShowCheckedModeBanner: false,

      //home: HomePage(),
      //home: MapPage(),
      //home: AddNewCardScreen(),
      //home: LoginPage(),
      //home: SignUpPage(),
      //home: RegisterVehiclePage()
      home: ProfilePage(),
      // home: ListTrips()
      //home: SelectCreditCard()
      //home: ViewCreditCards()
    );
  }
}
