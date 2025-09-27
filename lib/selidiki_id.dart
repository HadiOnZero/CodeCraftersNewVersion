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
    );
  }
}
