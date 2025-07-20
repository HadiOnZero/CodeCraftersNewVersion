import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final String titles;
  final VoidCallback actions;
  const ButtonCustom({super.key, required this.titles, required this.actions});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.black),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      onPressed: actions,
      child: Text(
        titles,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
