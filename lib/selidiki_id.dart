import 'package:flutter/material.dart';

class SelidikiId extends StatefulWidget {
  SelidikiId({super.key});

  @override
  State<SelidikiId> createState() => _SelidikiIdState();
}

class _SelidikiIdState extends State<SelidikiId> {
  final TextEditingController _targetController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();

  String? value;

  final List<String> _list = ['ktp', 'kartu keluarga', 'sim', 'nik'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selidiki ID',
          style: TextStyle(color: Colors.black, fontFamily: 'pixels'),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'Selidiki ID',
                      style: TextStyle(color: Colors.black),
                    ),
                    content: Text(
                      '• Kalau maksudnya ID (identitas) → seperti KTP, NIK, atau ID unik user di aplikasi/database.\n•	Kalau maksudnya id di HTML/CSS → biasanya dipakai untuk memberi identitas unik pada elemen.\n•	Kalau maksudnya id (Indonesia) → mungkin soal investigasi tentang negara Indonesia.\n•	Kalau maksudnya id di database → bisa terkait primary key, foreign key, atau pencarian data lewat id.',
                    ),
                    actions: [
                      TextButton(
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
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _targetController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                label: Text('Target'),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
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
                SizedBox(width: 30),
                Text('Methods : '),
                DropdownButton<String>(
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: Colors.grey,
                  value: value,
                  items: _list
                      .map(
                        (value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      value = newValue;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Console'),
            Divider(),
            Expanded(
              child: TextField(
                controller: _resultController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hint: Text('Result'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(child: Text('- Copyright Hadi Ramdhani')),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
