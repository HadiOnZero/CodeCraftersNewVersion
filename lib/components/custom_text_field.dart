import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController fieldController;
  const CustomTextField({super.key, required this.fieldController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: fieldController,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.black, width: 2.0),
        ),
        labelText: 'Email',
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }
}
