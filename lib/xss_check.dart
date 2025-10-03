import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syborgcate_workshop/providers/xss_provider.dart';

class XssCheck extends StatelessWidget {
  const XssCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<XssProvider>(
      builder: (context, provider, child) {
        return _XssContent(provider: provider);
      },
    );
  }
}

class _XssContent extends StatefulWidget {
  final XssProvider provider;

  const _XssContent({required this.provider});

  @override
  State<_XssContent> createState() => _XssContentState();
}

class _XssContentState extends State<_XssContent> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _payloadController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _payloadController.text = '<script>alert("XSS")</script>';
    // Sync with provider
    widget.provider.setPayload(_payloadController.text);
  }

  @override
  void dispose() {
    _urlController.dispose();
    _payloadController.dispose();
    super.dispose();
  }

  Future<void> _scanForXss() async {
    if (_urlController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter a URL',
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
    widget.provider.setUrl(_urlController.text);
    widget.provider.setPayload(_payloadController.text);

    try {
      await widget.provider.performScan();

      // Update UI based on provider state
      setState(() {
        // Result is already set in provider, UI will update automatically
      });
    } catch (e) {
      // Error handling is done in provider
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<XssProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.grey[900],
            elevation: 0,
            title: Text(
              'XSS SECURITY CHECKER',
              style: TextStyle(
                fontFamily: 'pixels',
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
                letterSpacing: 2,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.greenAccent),
            actions: [
              IconButton(
                onPressed: () {
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
                          'XSS SECURITY CHECKER',
                          style: TextStyle(
                            fontFamily: 'pixels',
                            fontWeight: FontWeight.bold,
                            color: Colors.greenAccent,
                            letterSpacing: 2,
                          ),
                        ),
                        content: Text(
                          'Cross-Site Scripting (XSS) Security Checker untuk mengidentifikasi potensi kerentanan pada aplikasi web. Alat ini membantu developer dan security tester mengevaluasi keamanan aplikasi web.',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'pixels',
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
                icon: Icon(Icons.info_outline, color: Colors.greenAccent),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Card - Hacker Theme
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
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.greenAccent,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.security,
                              color: Colors.greenAccent,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              'CROSS-SITE SCRIPTING (XSS) SECURITY CHECK',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.greenAccent,
                                fontFamily: 'pixels',
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Check for XSS vulnerabilities to improve web application security.',
                        style: TextStyle(
                          color: Colors.greenAccent.withOpacity(0.8),
                          fontSize: 14,
                          fontFamily: 'pixels',
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // URL Input Card - Hacker Theme
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
                      SizedBox(height: 10),
                      TextField(
                        controller: _urlController,
                        cursorColor: Colors.greenAccent,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'pixels',
                        ),
                        decoration: InputDecoration(
                          hintText: 'https://target.com/vulnerable.php?id=',
                          hintStyle: TextStyle(
                            color: Colors.greenAccent.withOpacity(0.5),
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

                // Payload Input Card - Hacker Theme
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
                        'TEST PAYLOAD',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent,
                          fontFamily: 'pixels',
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _payloadController,
                        maxLines: 3,
                        cursorColor: Colors.greenAccent,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'monospace',
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter test payload to check',
                          hintStyle: TextStyle(
                            color: Colors.greenAccent.withOpacity(0.5),
                            fontFamily: 'monospace',
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
                            Icons.code,
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
                    onPressed: provider.isScanning ? null : _scanForXss,
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
                                'CHECK TARGET',
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

                // Result Card - Hacker Theme
                if (provider.showResult)
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color:
                            provider.result.contains('Vulnerability Detected')
                            ? Colors.redAccent.withOpacity(0.5)
                            : Colors.greenAccent.withOpacity(0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              (provider.result.contains(
                                        'Vulnerability Detected',
                                      )
                                      ? Colors.redAccent
                                      : Colors.greenAccent)
                                  .withOpacity(0.1),
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
                              provider.result.contains('Vulnerability Detected')
                                  ? Icons.warning
                                  : Icons.check_circle,
                              color:
                                  provider.result.contains(
                                    'Vulnerability Detected',
                                  )
                                  ? Colors.redAccent
                                  : Colors.greenAccent,
                              size: 24,
                            ),
                            SizedBox(width: 10),
                            Text(
                              provider.result.contains('Vulnerability Detected')
                                  ? 'VULNERABILITY DETECTED'
                                  : 'TARGET SECURE',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.greenAccent,
                                fontFamily: 'pixels',
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Text(
                          provider.result,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            height: 1.5,
                            fontFamily: 'monospace',
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
