import 'package:flutter/material.dart';
import 'package:wheels_un/components/my_display_textfield.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDriver = true; // Set this to true or false based on your logic

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Center(
              child: Column(
                children: [
                  // logo
                  const Icon(
                    Icons.person,
                    size: 100,
                    color: Color(0xFF68BB92),
                  ),

                  const SizedBox(height: 20),

                  // welcome
                  Text(
                    'Hola Ana!',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            const Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyReadOnlyField(
                        text: '492',
                        hintText: 'Cedula',
                      ),
                      SizedBox(height: 20),
                      MyReadOnlyField(
                        text: '24',
                        hintText: 'Edad',
                      ),
                      SizedBox(height: 20),
                      MyReadOnlyField(
                        text: 'ana@gmail.com',
                        hintText: 'Email',
                      ),
                      SizedBox(height: 20),
                      MyReadOnlyField(
                        text: '9876543210',
                        hintText: 'Celular',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyReadOnlyField(
                        text: 'calle 23...',
                        hintText: 'Dirección',
                      ),
                      SizedBox(height: 20),
                      MyReadOnlyField(
                        text: 'Bogota',
                        hintText: 'Ciudad',
                      ),
                      SizedBox(height: 20),
                      MyReadOnlyField(
                        text: 'Colombia',
                        hintText: 'País',
                      ),
                      SizedBox(height: 20),
                      MyReadOnlyField(
                        text: 'userPostalCode',
                        hintText: 'Código Postal',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (isDriver) ...[
              const Center(
                child: MyReadOnlyField(
                  text: '2025-04-18', // Example date, replace with actual expiration date
                  hintText: 'Fecha de expiración de licencia',
                ),
              ),
            ],
            const SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 70, // Specify the desired width
                        height: 70, // Specify the desired height
                        child: IconButton(
                          iconSize: 50,
                          icon: const Icon(Icons.credit_card),
                          onPressed: () {
                            //router to the credit card page
                          },
                          color: const Color(0xFF68BB92),
                        ),
                      ),
                      Text(
                        'Mis tarjetas',
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  
                  if (isDriver) ...[
                    const SizedBox(width: 50), // Add space between buttons
                    Column(
                      children: [
                        SizedBox(
                          width: 70, // Specify the desired width
                          height: 70, // Specify the desired height
                          child: IconButton(
                            iconSize: 50,
                            icon: const Icon(Icons.car_crash),
                            onPressed: () {
                              // router to the user's vehicles page
                            },
                            color: const Color(0xFF68BB92),
                          ),
                        ),
                        Text(
                          'Mis vehiculos',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
