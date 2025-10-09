import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:syborgcate_workshop/constants/assets.dart';
import 'package:syborgcate_workshop/components/matrix_horizontal.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          'ABOUT APP',
          style: TextStyle(
            color: Colors.greenAccent,
            fontFamily: 'pixels',
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.greenAccent),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey[900]!, Colors.black, Colors.grey[900]!],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // App logo animation
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.greenAccent.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Lottie.asset(
                  Assets.assetsHacker,
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 30),

              // App name
              Text(
                'CodeCrafters',
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 24,
                  fontFamily: 'pixels',
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.greenAccent.withOpacity(0.5),
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              // Version
              Text(
                'Version 1.9.1',
                style: TextStyle(
                  color: Colors.greenAccent.withOpacity(0.7),
                  fontSize: 14,
                  fontFamily: 'monospace',
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 30),

              // Description card
              _buildInfoCard(
                'DESCRIPTION',
                'CodeCrafters adalah aplikasi toolkit untuk keamanan siber dan penetration testing. '
                    'Aplikasi ini menyediakan berbagai tools untuk memeriksa kerentanan website, melakukan '
                    'network scanning, dan investigasi OSINT.',
              ),

              SizedBox(height: 20),

              // Features card
              _buildInfoCard(
                'FEATURES',
                '• SQL Injection Checker\n'
                    '• SMB Network Scanner\n'
                    '• OSINT Investigator\n'
                    '• XSS Security Checker\n'
                    '• Mass Mirror Zone-H.org\n'
                    '• Mass Mirror Haxor.id',
              ),

              SizedBox(height: 20),

              // Warning card
              _buildWarningCard(
                'PERINGATAN',
                'Aplikasi ini hanya untuk tujuan edukasi dan testing keamanan. '
                    'Penggunaan tools ini untuk aktivitas illegal adalah tanggung jawab pengguna. '
                    'Developer tidak bertanggung jawab atas penyalahgunaan aplikasi ini.',
              ),

              SizedBox(height: 20),

              // Developer info
              _buildClickableInfoCard(
                'DEVELOPER',
                'Developed by: Syborg Cate\n'
                    'Email: syborgcate@example.com\n'
                    'Website: hadiramdhanii.web.app\n'
                    '© 2024 Syborg Cate Workshop. All rights reserved.',
                'https://hadiramdhanii.web.app',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.greenAccent.withOpacity(0.5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[900],
        boxShadow: [
          BoxShadow(
            color: Colors.greenAccent.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.greenAccent,
              fontSize: 16,
              fontFamily: 'pixels',
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
              fontFamily: 'monospace',
              height: 1.5,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningCard(String title, String content) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange.withOpacity(0.8), width: 2),
        borderRadius: BorderRadius.circular(10),
        color: Colors.orange.withOpacity(0.1),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 20),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 16,
                  fontFamily: 'pixels',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(
              color: Colors.orange.withOpacity(0.9),
              fontSize: 12,
              fontFamily: 'monospace',
              height: 1.5,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClickableInfoCard(String title, String content, String url) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.greenAccent.withOpacity(0.5),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[900],
          boxShadow: [
            BoxShadow(
              color: Colors.greenAccent.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 16,
                fontFamily: 'pixels',
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
                fontFamily: 'monospace',
                height: 1.5,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.open_in_new,
                  color: Colors.greenAccent.withOpacity(0.7),
                  size: 16,
                ),
                SizedBox(width: 5),
                Text(
                  'Click to visit website',
                  style: TextStyle(
                    color: Colors.greenAccent.withOpacity(0.7),
                    fontSize: 10,
                    fontFamily: 'monospace',
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }
}
