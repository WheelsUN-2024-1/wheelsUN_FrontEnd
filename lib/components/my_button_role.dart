import 'package:flutter/material.dart';
import 'package:wheels_un/components/round_images.dart';
import 'package:wheels_un/components/square_texfield.dart';

class MyButtonRole extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const MyButtonRole({required this.text, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 175,
        padding: const EdgeInsets.all(
            10), // Added some padding for aesthetic spacing
        decoration: BoxDecoration(
          color: Color(0xFF68BB92), // Background color for the container
          borderRadius: BorderRadius.circular(16), // Rounded corners
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (text == 'Passenger')
              const RoundImages(imagePath: 'lib/images/passenger.png'),
            if (text == 'Driver')
              const RoundImages(imagePath: 'lib/images/driver.png'),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
