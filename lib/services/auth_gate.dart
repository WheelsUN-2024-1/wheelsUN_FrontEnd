import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheels_un/pages/home_page.dart';
import 'package:wheels_un/pages/role_page.dart';
import 'package:wheels_un/services/auth_provier.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isAuthenticated) {
          return const HomePage(); 
        } else {
          return const RolePage(); 
        }
      },
    );
  }
}
