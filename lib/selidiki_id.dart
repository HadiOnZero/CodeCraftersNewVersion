import 'package:flutter/material.dart';

class SelidikiId extends StatelessWidget {
  const SelidikiId({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selidiki ID',
          style: TextStyle(color: Colors.black, fontFamily: 'pixels'),
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: null, icon: Icon(Icons.safety_check))],
      ),
    );
  }
}
