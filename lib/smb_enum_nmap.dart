import 'package:flutter/material.dart';
import 'package:syborgcate_workshop/components/button_custom.dart';
import 'package:syborgcate_workshop/components/custom_text_field.dart';
import 'package:lottie/lottie.dart';
import 'package:syborgcate_workshop/constants/assets.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Lottie.asset(Assets.hackerLaptop, width: 200, height: 200),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _targetController,
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
                      labelText: 'IP OR URL',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  child: ButtonCustom(titles: 'Run', actions: () {}),
                  height: 55,
                ),
              ],
            ),
            Divider(),
            Text('Console'),
            Expanded(
              child: TextField(
                textAlignVertical: TextAlignVertical.top,
                controller: _targetController,
                cursorColor: Colors.black,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            Column(children: [Divider(), Text('Code By Hadi Ramdhani')]),
          ],
        ),
      ),
    );
  }
}
