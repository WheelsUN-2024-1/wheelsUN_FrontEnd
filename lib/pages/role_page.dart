import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wheels_un/components/my_button_role.dart';
import 'package:wheels_un/components/square_texfield.dart';
import 'package:wheels_un/pages/landing_page.dart';
import 'package:wheels_un/pages/login_page.dart'; // Import your LandingPage

class RolePage extends StatelessWidget {
  RolePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    
    void navigateToLogin(role) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(
                  role: role,
                )),
      );
    }

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LandingPage(), // This is the full-screen background page
          Positioned(
            bottom: 125, // Adjust the position according to your needs
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               MyButtonRole(
                    text: 'Passenger', onTap: () => navigateToLogin('passenger')),
                SizedBox(width: 25),
                 MyButtonRole(
                    text: 'Driver', onTap: () => navigateToLogin('driver')),
              
              ],
            ),
          ),
        ],
      ),
    );
  }
}
