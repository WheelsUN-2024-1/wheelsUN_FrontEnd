import 'package:flutter/material.dart';
import 'package:wheels_un/components/my_button_role.dart';
import 'package:wheels_un/pages/landing_page_role.dart';
import 'package:wheels_un/pages/login_page.dart'; // Import your LandingPage

class RolePage extends StatelessWidget {
  const RolePage({super.key});

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
          const LandingPageRole(), // This is the full-screen background page
          Positioned(
            bottom: 125, // Adjust the position according to your needs
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               MyButtonRole(
                    text: 'Passenger', onTap: () => navigateToLogin('passenger')),
                const SizedBox(width: 25),
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
