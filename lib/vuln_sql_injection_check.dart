import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'constants/assets.dart';
import 'package:syborgcate_workshop/providers/sql_injection_provider.dart';
import 'package:http/http.dart' as http;

class VulnSqlInjectionCheck extends StatelessWidget {
  const VulnSqlInjectionCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SqlInjectionProvider>(
      builder: (context, provider, child) {
        return _SqlInjectionContent(provider: provider);
      },
    );
  }
}

class _SqlInjectionContent extends StatefulWidget {
  final SqlInjectionProvider provider;

  const _SqlInjectionContent({required this.provider});

  @override
  State<_SqlInjectionContent> createState() => _SqlInjectionContentState();
}

class _SqlInjectionContentState extends State<_SqlInjectionContent> {
  final TextEditingController _targetController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();

  String _scanStatus = 'idle'; // idle, scanning, vulnerable, secure, error

  Future<void> _performScan() async {
    if (_targetController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter a target URL',
            style: TextStyle(color: Colors.greenAccent, fontFamily: 'pixels'),
          ),
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: Colors.red, width: 1),
          ),
        ),
      );
      return;
    }

    // Update provider state
    widget.provider.setUrl(_targetController.text);

    try {
      await widget.provider.performScan();

      // Update local state based on provider result
      final result = widget.provider.result;
      setState(() {
        if (result.contains('VULNERABILITY DETECTED')) {
          _scanStatus = 'vulnerable';
        } else if (result.contains('NO SQL INJECTION VULNERABILITY DETECTED')) {
          _scanStatus = 'secure';
        } else if (result.contains('SCAN ERROR OCCURRED')) {
          _scanStatus = 'error';
        }
        _resultController.text = result;
      });
    } catch (e) {
      setState(() {
        _scanStatus = 'error';
      });
    }
  }

  @override
  void dispose() {
    _targetController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void aboutSqliScanner() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.greenAccent, width: 2),
            ),
            title: Text(
              'SQL INJECTION EXPLOITER',
              style: TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
                fontFamily: 'pixels',
                letterSpacing: 2,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Alat eksploitasi untuk mengeksploitasi kerentanan SQL Injection pada aplikasi web. Mengidentifikasi dan mengeksploitasi celah database untuk keperluan security research.\n\n',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: 'pixels',
                    ),
                  ),
                  Text(
                    'Fitur:\n• Error-based exploitation\n• Union-based attacks\n• Blind SQL injection\n• Database enumeration',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.greenAccent.withOpacity(0.8),
                      fontFamily: 'pixels',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '- Code By Hadi Ramdhani',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                      fontFamily: 'pixels',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                style: ButtonStyle(
                  overlayColor: WidgetStatePropertyAll(
                    Colors.greenAccent.withOpacity(0.2),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'CLOSE',
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontFamily: 'pixels',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    return Consumer<SqlInjectionProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.grey[900],
            elevation: 0,
            centerTitle: true,
            title: Text(
              'SQL INJECTION SCANNER',
              style: TextStyle(
                color: Colors.greenAccent,
                fontFamily: 'pixels',
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontSize: 20,
              ),
            ),
            iconTheme: IconThemeData(color: Colors.greenAccent),
            actions: [
              IconButton(
                onPressed: () {
                  aboutSqliScanner();
                },
                icon: Icon(Icons.info_outline, color: Colors.greenAccent),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Card with Animation - Hacker Theme
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.greenAccent.withOpacity(0.3),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.greenAccent.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Animated scanning indicator
                      if (provider.isScanning)
                        Container(
                          width: 150,
                          height: 150,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Database icon with animation
                              AnimatedSwitcher(
                                duration: Duration(milliseconds: 500),
                                child: Icon(
                                  _scanStatus == 'vulnerable'
                                      ? Icons.warning
                                      : _scanStatus == 'secure'
                                      ? Icons.shield
                                      : Icons.storage,
                                  size: 70,
                                  color: _scanStatus == 'vulnerable'
                                      ? Colors.red
                                      : _scanStatus == 'secure'
                                      ? Colors.green
                                      : Colors.blue,
                                  key: ValueKey(_scanStatus),
                                ),
                              ),
                              // Scanning animation
                              if (provider.isScanning)
                                SizedBox(
                                  width: 120,
                                  height: 120,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.blue.withOpacity(0.3),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        )
                      else
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey[850],
                            borderRadius: BorderRadius.circular(75),
                            border: Border.all(
                              color: Colors.greenAccent.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Lottie.asset(
                            Assets.assetsHackerLogo,
                            width: 120,
                            height: 120,
                          ),
                        ),
                      SizedBox(height: 15),
                      Text(
                        'SQL INJECTION EXPLOITER',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent,
                          fontFamily: 'pixels',
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Exploit SQL injection vulnerabilities in database systems',
                        style: TextStyle(
                          color: Colors.greenAccent.withOpacity(0.8),
                          fontSize: 14,
                          fontFamily: 'pixels',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (_scanStatus != 'idle')
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            _scanStatus == 'scanning'
                                ? '🔍 EXPLOITING DATABASE...'
                                : _scanStatus == 'vulnerable'
                                ? '⚠️ DATABASE COMPROMISED!'
                                : _scanStatus == 'secure'
                                ? '✅ DATABASE SECURE'
                                : '❌ EXPLOIT FAILED',
                            style: TextStyle(
                              color: _scanStatus == 'vulnerable'
                                  ? Colors.red
                                  : _scanStatus == 'secure'
                                  ? Colors.greenAccent
                                  : _scanStatus == 'error'
                                  ? Colors.red
                                  : Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'pixels',
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Target Input Card - Hacker Theme
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.greenAccent.withOpacity(0.3),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.greenAccent.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TARGET HOST',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent,
                          fontFamily: 'pixels',
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: _targetController,
                        cursorColor: Colors.greenAccent,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'pixels',
                        ),
                        decoration: InputDecoration(
                          hintText: 'https://target.com/vulnerable.php?id=1',
                          hintStyle: TextStyle(
                            color: Colors.greenAccent.withOpacity(0.5),
                            fontFamily: 'pixels',
                          ),
                          labelText: 'VULNERABLE ENDPOINT',
                          labelStyle: TextStyle(
                            color: Colors.greenAccent.withOpacity(0.8),
                            fontWeight: FontWeight.w500,
                            fontFamily: 'pixels',
                          ),
                          filled: true,
                          fillColor: Colors.grey[850],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.greenAccent.withOpacity(0.3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.greenAccent,
                              width: 2,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.link,
                            color: Colors.greenAccent.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Scan Button - Hacker Theme
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.greenAccent.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 2,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: provider.isScanning ? null : _performScan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.greenAccent,
                      padding: EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Colors.greenAccent, width: 2),
                      ),
                      elevation: 0,
                    ),
                    child: provider.isScanning
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.greenAccent,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                'SCANNING...',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'pixels',
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search,
                                size: 20,
                                color: Colors.greenAccent,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'EXPLOIT DATABASE',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'pixels',
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),

                SizedBox(height: 20),

                // Result Console Card - Hacker Theme
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _scanStatus == 'vulnerable'
                        ? Colors.red[900]!.withOpacity(0.3)
                        : _scanStatus == 'secure'
                        ? Colors.green[900]!.withOpacity(0.3)
                        : _scanStatus == 'error'
                        ? Colors.orange[900]!.withOpacity(0.3)
                        : Colors.grey[900]!.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: _scanStatus == 'vulnerable'
                          ? Colors.red
                          : _scanStatus == 'secure'
                          ? Colors.greenAccent
                          : _scanStatus == 'error'
                          ? Colors.orange
                          : Colors.greenAccent.withOpacity(0.5),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:
                            (_scanStatus == 'vulnerable'
                                    ? Colors.red
                                    : _scanStatus == 'secure'
                                    ? Colors.greenAccent
                                    : _scanStatus == 'error'
                                    ? Colors.orange
                                    : Colors.greenAccent)
                                .withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _scanStatus == 'vulnerable'
                                ? Icons.warning
                                : _scanStatus == 'secure'
                                ? Icons.check_circle
                                : _scanStatus == 'error'
                                ? Icons.error
                                : Icons.info,
                            color: _scanStatus == 'vulnerable'
                                ? Colors.red
                                : _scanStatus == 'secure'
                                ? Colors.greenAccent
                                : _scanStatus == 'error'
                                ? Colors.orange
                                : Colors.greenAccent,
                            size: 24,
                          ),
                          SizedBox(width: 10),
                          Text(
                            _scanStatus == 'vulnerable'
                                ? 'DATABASE PWNED'
                                : _scanStatus == 'secure'
                                ? 'DATABASE SECURE'
                                : _scanStatus == 'error'
                                ? 'EXPLOIT ERROR'
                                : 'EXPLOIT RESULTS',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _scanStatus == 'vulnerable'
                                  ? Colors.red
                                  : _scanStatus == 'secure'
                                  ? Colors.greenAccent
                                  : _scanStatus == 'error'
                                  ? Colors.orange
                                  : Colors.greenAccent,
                              fontFamily: 'pixels',
                              letterSpacing: 1,
                            ),
                          ),
                          Spacer(),
                          if (_resultController.text.isNotEmpty)
                            IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Colors.greenAccent.withOpacity(0.5),
                                size: 18,
                              ),
                              onPressed: () {
                                setState(() {
                                  _resultController.clear();
                                  _scanStatus = 'idle';
                                });
                                provider.clearResult();
                              },
                            ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Container(
                        height: 250,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.greenAccent.withOpacity(0.3),
                          ),
                        ),
                        child: TextField(
                          controller: _resultController,
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          cursorColor: Colors.greenAccent,
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontFamily: 'monospace',
                            fontSize: 12,
                            height: 1.4,
                          ),
                          decoration: InputDecoration(
                            hintText:
                                'Exploitation results will appear here...',
                            hintStyle: TextStyle(
                              color: Colors.greenAccent.withOpacity(0.5),
                              fontFamily: 'monospace',
                              fontSize: 12,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Support Section - Hacker Theme
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.greenAccent.withOpacity(0.3),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.greenAccent.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.coffee, color: Colors.greenAccent, size: 20),
                      SizedBox(width: 8),
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: Colors.greenAccent,
                                    width: 2,
                                  ),
                                ),
                                title: Text(
                                  'SUPPORT DEVELOPER',
                                  style: TextStyle(
                                    color: Colors.greenAccent,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'pixels',
                                    letterSpacing: 2,
                                  ),
                                ),
                                content: SizedBox(
                                  height: 300,
                                  child: Column(
                                    children: [
                                      Text(
                                        'If you find this tool useful, consider supporting my work.\n\n',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'pixels',
                                        ),
                                      ),
                                      Text(
                                        'Dana: 0857-1234-5678\nWhatsApp: 0838-4011-5112',
                                        style: TextStyle(
                                          color: Colors.greenAccent,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'pixels',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    style: ButtonStyle(
                                      overlayColor: WidgetStatePropertyAll(
                                        Colors.greenAccent.withOpacity(0.2),
                                      ),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      'CLOSE',
                                      style: TextStyle(
                                        color: Colors.greenAccent,
                                        fontFamily: 'pixels',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text(
                          'SUPPORT DEVELOPER',
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontFamily: 'pixels',
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Footer - Hacker Theme
                Center(
                  child: Text(
                    '© 2024 HADI RAMDHANI - DATABASE EXPLOITATION TOOLS',
                    style: TextStyle(
                      color: Colors.greenAccent.withOpacity(0.6),
                      fontSize: 12,
                      fontFamily: 'pixels',
                      letterSpacing: 1,
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
