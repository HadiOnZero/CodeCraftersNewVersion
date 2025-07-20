import 'package:flutter/material.dart';

class VulnSqlInjectionCheck extends StatelessWidget {
  const VulnSqlInjectionCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Vulnerability SQL Injection Checker',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
