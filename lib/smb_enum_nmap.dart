import 'package:flutter/material.dart';
import 'package:syborgcate_workshop/components/custom_text_field.dart';

class SmbEnumNmap extends StatefulWidget {
  const SmbEnumNmap({super.key});

  @override
  State<SmbEnumNmap> createState() => _SmbEnumNmapState();
}

class _SmbEnumNmapState extends State<SmbEnumNmap> {
  final TextEditingController _targetController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('SMB ENUMERATION', style: TextStyle(fontFamily: 'pixels')),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'About SMB Enum',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'pixels',
                      ),
                    ),
                    content: Text('Description'),
                    actions: [
                      TextButton(
                        style: ButtonStyle(
                          overlayColor: WidgetStatePropertyAll(Colors.grey),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Close',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.info, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [CustomTextField(fieldController: _targetController)],
        ),
      ),
    );
  }
}
