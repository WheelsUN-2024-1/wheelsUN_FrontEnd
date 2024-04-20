import 'package:flutter/material.dart';
import 'package:wheels_un/components/my_display_textfield.dart';
import 'package:wheels_un/globalVariables/user_data.dart';
import 'package:wheels_un/view_creditcards.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDriver = appIsDriver; // Set this to true or false based on your logic
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
                    'Hola $appName!',
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
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyReadOnlyField(
                        text: appIdNumber.toString() ,
                        hintText: 'Cedula',
                      ),
                      const SizedBox(height: 20),
                      MyReadOnlyField(
                        text: appAge.toString(),
                        hintText: 'Edad',
                      ),
                      const SizedBox(height: 20),
                      MyReadOnlyField(
                        text: appEmail,
                        hintText: 'Email',
                      ),
                      const SizedBox(height: 20),
                      MyReadOnlyField(
                        text: appPhone,
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
                        text: appAddress,
                        hintText: 'Dirección',
                      ),
                      const SizedBox(height: 20),
                      MyReadOnlyField(
                        text: appCity,
                        hintText: 'Ciudad',
                      ),
                      const SizedBox(height: 20),
                      MyReadOnlyField(
                        text: appCountry,
                        hintText: 'País',
                      ),
                      const SizedBox(height: 20),
                      MyReadOnlyField(
                        text: appPostalCode,
                        hintText: 'Código Postal',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (isDriver) ...[
              Center(
                child: MyReadOnlyField(
                  text: appLicenseExpirationDate, // Example date, replace with actual expiration date
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
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => ViewCreditCards()),
                            );
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
