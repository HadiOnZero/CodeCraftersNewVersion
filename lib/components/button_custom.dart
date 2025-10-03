import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final String titles;
  final VoidCallback actions;
  const ButtonCustom({super.key, required this.titles, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.greenAccent.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 1,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.grey[900]),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: Colors.greenAccent.withOpacity(0.5),
                width: 1,
              ),
            ),
          ),
          alignment: Alignment.centerLeft,
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          overlayColor: WidgetStatePropertyAll(
            Colors.greenAccent.withOpacity(0.2),
          ),
        ),
        onPressed: actions,
        child: Text(
          titles,
          style: TextStyle(
            color: Colors.greenAccent,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            fontFamily: 'pixels',
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
