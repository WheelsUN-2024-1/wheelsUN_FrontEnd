import 'package:flutter/material.dart';

class MyReadOnlyField extends StatelessWidget {
  final String text;
  final String hintText;

  const MyReadOnlyField({
    Key? key,
    required this.text,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: IgnorePointer(
        child: TextFormField(
          initialValue: text,
          readOnly: true,
          decoration: InputDecoration(
            labelText: hintText,
            labelStyle: TextStyle(color: Colors.grey[700]),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
          ),
        ),
      ),
    );
  }
}
