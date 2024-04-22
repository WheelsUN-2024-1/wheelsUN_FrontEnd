import 'package:flutter/material.dart';
import 'package:wheels_un/list_trips.dart';
import 'package:wheels_un/map_page.dart';
import 'package:wheels_un/add_new_creditCard.dart';
import 'package:wheels_un/pages/home_page.dart';
import 'package:wheels_un/pages/login_page.dart';
import 'package:wheels_un/pages/role_page.dart';
import 'package:wheels_un/pages/sign_up_page.dart';
import 'package:wheels_un/pages/register_vehicle.dart';
import 'package:wheels_un/pages/profile_page.dart';
import 'package:wheels_un/select_creditCard.dart';
import 'package:wheels_un/view_creditcards.dart';
import 'package:wheels_un/pages/view_vehicles_page.dart';

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
        "creditCard": (context) => AddNewCardScreen()
      },
      debugShowCheckedModeBanner: false,

      home: RolePage(),
      //home: AddNewCardScreen(),
      //home: LoginPage(),
      //home: SignUpPage(),
      //home: ViewVehiclesPage()
      //home: RegisterVehiclePage()
      //home: SelectCreditCard()
      //home: ViewCreditCards()
      //home: ListTrips()
      //home: MapPage(tripId: "6602e638c65f8fbda668db92", startingPoint: "Sede Bogotá - Universidad Nacional de Colombia", endingPoint: "Centro Mayor Centro Comercial")
      //home: ProfilePage(),
    );
  }
}
