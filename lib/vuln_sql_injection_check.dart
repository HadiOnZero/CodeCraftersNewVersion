import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'constants/assets.dart';

class VulnSqlInjectionCheck extends StatefulWidget {
  const VulnSqlInjectionCheck({super.key});

  @override
  State<VulnSqlInjectionCheck> createState() => _VulnSqlInjectionCheckState();
}

class _VulnSqlInjectionCheckState extends State<VulnSqlInjectionCheck> {
  final TextEditingController _targetController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void aboutSqliScanner() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'SQLi Vulnerability scanner',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SizedBox(
              height: 90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tools ini di buat agar mempermudah mencari celah keamanan pada suatu database di dalam sebuah website\n\n',
                  ),
                  Text(
                    '- Code By Hadi Ramdhani',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                style: ButtonStyle(
                  overlayColor: WidgetStatePropertyAll(Colors.grey),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text('CLOSE', style: TextStyle(color: Colors.black)),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Vulnerability SQL Injection Checker',
          style: TextStyle(color: Colors.black, fontFamily: 'pixels'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              aboutSqliScanner();
            },
            icon: Icon(Icons.info),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Lottie.asset(Assets.assetsHackerLogo, width: 200, height: 200),
              SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        cursorColor: Colors.black,

                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        controller: _targetController,
                        decoration: InputDecoration(
                          label: Text(
                            'TARGET URL',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    height: 50,
                    width: 130,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.black),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(10),
                          ),
                        ),
                      ),
                      child: Text(
                        'SCAN',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 10),
              SizedBox(
                height: 250,
                child: TextField(
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  controller: _resultController,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    label: Text(
                      'RESULT',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  cursorColor: Colors.black,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text('COPYRIGHT HADI RAMDHANI 2025'),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'Buy me a coffee',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: SizedBox(
                          height: 100,
                          child: Column(
                            children: [
                              Text(
                                'If you like this app, consider buying me a coffee to support my work.\n\n',
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                'Dana Account : 0857-1234-5678\nor contact me on whatsapp : 0838-4011-5112',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            style: ButtonStyle(
                              overlayColor: WidgetStatePropertyAll(Colors.grey),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'CLOSE',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  'Buy me a coffee',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
