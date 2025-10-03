import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:syborgcate_workshop/constants/assets.dart';
import 'package:syborgcate_workshop/providers/smb_provider.dart';

class SmbEnumNmap extends StatelessWidget {
  const SmbEnumNmap({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SmbProvider>(
      builder: (context, provider, child) {
        return _SmbContent(provider: provider);
      },
    );
  }
}

class _SmbContent extends StatefulWidget {
  final SmbProvider provider;

  const _SmbContent({required this.provider});

  @override
  State<_SmbContent> createState() => _SmbContentState();
}

class _SmbContentState extends State<_SmbContent> {
  final TextEditingController _targetController = TextEditingController();
  final TextEditingController _consoleController = TextEditingController();

  @override
  void dispose() {
    _targetController.dispose();
    _consoleController.dispose();
    super.dispose();
  }

  Future<void> _performScan() async {
    if (_targetController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter a target IP or URL',
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
    widget.provider.setTarget(_targetController.text);

    try {
      await widget.provider.performScan();

      // Update console controller with provider result
      setState(() {
        _consoleController.text = widget.provider.consoleOutput;
      });
    } catch (e) {
      // Error handling is done in provider
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SmbProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.grey[900],
            elevation: 0,
            centerTitle: true,
            title: Text(
              'SMB NETWORK EXPLOITER',
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
                          'ABOUT SMB EXPLOITATION',
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontFamily: 'pixels',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        content: SingleChildScrollView(
                          child: Text(
                            'SMB Exploitation adalah proses mengeksploitasi layanan SMB (Server Message Block) untuk mendapatkan akses tidak sah ke sistem target.\n\nSMB adalah protokol yang rentan di Windows yang dapat dieksploitasi untuk:\n• Remote code execution\n• Privilege escalation\n• Lateral movement\n• Data exfiltration\n\nTool ini membantu mengeksploitasi:\n• Kerentanan SMB protocol\n• Share yang terbuka\n• Kredensial yang lemah\n• Konfigurasi yang salah',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'pixels',
                            ),
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
                      if (provider.showAnimation)
                        Container(
                          width: 150,
                          height: 150,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Outer rotating circle
                              AnimatedContainer(
                                duration: Duration(seconds: 2),
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: provider.scanPhase == 'completed'
                                        ? Colors.greenAccent
                                        : Colors.greenAccent.withOpacity(0.7),
                                    width: 3,
                                  ),
                                ),
                              ),
                              // Inner animated icon
                              AnimatedSwitcher(
                                duration: Duration(milliseconds: 500),
                                child: Icon(
                                  provider.scanPhase == 'completed'
                                      ? Icons.check_circle
                                      : Icons.radar,
                                  size: 60,
                                  color: provider.scanPhase == 'completed'
                                      ? Colors.greenAccent
                                      : Colors.greenAccent.withOpacity(0.8),
                                  key: ValueKey(provider.scanPhase),
                                ),
                              ),
                              // Scanning animation
                              if (provider.scanPhase != 'completed')
                                SizedBox(
                                  width: 140,
                                  height: 140,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.greenAccent.withOpacity(0.3),
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
                            Assets.hackerLaptop,
                            width: 120,
                            height: 120,
                          ),
                        ),
                      SizedBox(height: 15),
                      Text(
                        'SMB NETWORK EXPLOITER',
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
                        'Exploit SMB vulnerabilities and enumerate network shares',
                        style: TextStyle(
                          color: Colors.greenAccent.withOpacity(0.8),
                          fontSize: 14,
                          fontFamily: 'pixels',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (provider.scanPhase != 'idle')
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            provider.scanPhase == 'scanning'
                                ? '🔍 EXPLOITING TARGET...'
                                : provider.scanPhase == 'enumerating'
                                ? '📊 COMPROMISING SERVICES...'
                                : '✅ EXPLOITATION COMPLETED!',
                            style: TextStyle(
                              color: provider.scanPhase == 'completed'
                                  ? Colors.greenAccent
                                  : Colors.greenAccent.withOpacity(0.8),
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
                          hintText: '192.168.1.100 or target.local',
                          hintStyle: TextStyle(
                            color: Colors.greenAccent.withOpacity(0.5),
                            fontFamily: 'pixels',
                          ),
                          labelText: 'VULNERABLE HOST',
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
                            Icons.computer,
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
                                Icons.radar,
                                size: 20,
                                color: Colors.greenAccent,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'START EXPLOITATION',
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

                // Console Output Card - Hacker Theme
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
                          Icon(
                            Icons.terminal,
                            color: Colors.greenAccent,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'EXPLOITATION LOG',
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'pixels',
                              letterSpacing: 1,
                            ),
                          ),
                          Spacer(),
                          if (_consoleController.text.isNotEmpty)
                            IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Colors.greenAccent.withOpacity(0.5),
                                size: 18,
                              ),
                              onPressed: () {
                                setState(() {
                                  _consoleController.clear();
                                });
                                provider.clearConsole();
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
                          controller: _consoleController,
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

                // Footer - Hacker Theme
                Center(
                  child: Text(
                    'NETWORK EXPLOITATION TOOL V1.0',
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
