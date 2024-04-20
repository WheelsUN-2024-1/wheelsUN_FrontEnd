import 'package:flutter/material.dart';

class RoundImages extends StatelessWidget {
  final String imagePath;

  const RoundImages({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50, // Specify the width for consistency
      height: 50, // Specify the height for consistency
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
