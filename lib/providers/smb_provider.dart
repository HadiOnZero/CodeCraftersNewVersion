import 'package:flutter/material.dart';

class SmbProvider with ChangeNotifier {
  String _target = '';
  String _consoleOutput = '';
  bool _isScanning = false;
  bool _showAnimation = false;
  String _scanPhase = 'idle'; // idle, scanning, enumerating, completed

  String get target => _target;
  String get consoleOutput => _consoleOutput;
  bool get isScanning => _isScanning;
  bool get showAnimation => _showAnimation;
  String get scanPhase => _scanPhase;

  void setTarget(String target) {
    _target = target;
    notifyListeners();
  }

  void setScanning(bool scanning) {
    _isScanning = scanning;
    notifyListeners();
  }

  void setShowAnimation(bool showAnimation) {
    _showAnimation = showAnimation;
    notifyListeners();
  }

  void setScanPhase(String phase) {
    _scanPhase = phase;
    notifyListeners();
  }

  void setConsoleOutput(String output) {
    _consoleOutput = output;
    notifyListeners();
  }

  void clearConsole() {
    _consoleOutput = '';
    notifyListeners();
  }

  Future<void> performScan() async {
    if (_target.isEmpty) {
      throw Exception('Please enter a target IP or URL');
    }

    setScanning(true);
    setShowAnimation(true);
    setScanPhase('scanning');
    clearConsole();

    try {
      // Simulate scanning phases with animations
      await Future.delayed(Duration(seconds: 1));

      setScanPhase('enumerating');
      setConsoleOutput('''
🔄 INITIALIZING SMB ENUMERATION
═══════════════════════════════════════

📡 Connecting to target: $_target
🔍 Scanning for SMB services...
📊 Detecting SMB protocol version...

═══════════════════════════════════════
      ''');

      await Future.delayed(Duration(seconds: 2));

      setScanPhase('completed');
      setConsoleOutput('''
✅ SMB ENUMERATION COMPLETED
═══════════════════════════════════════

📋 Target Information:
   • Host: $_target
   • SMB Version: 2.1
   • Status: Active
   • Port: 445 (Open)

🔍 Enumeration Results:
   • Server: Windows Server 2019
   • Workgroup: WORKGROUP
   • Shares Found: 4
     • ADMIN\$ (Admin share)
     • C\$ (Default share)
     • IPC\$ (IPC Share)
     • Users (Public share)

⚠️  Security Findings:
   • Guest access: Disabled
   • Anonymous access: Restricted
   • SMB Signing: Not required

🔒 Recommendations:
   • Enable SMB signing for better security
   • Review share permissions
   • Consider disabling unnecessary shares

═══════════════════════════════════════
   Scan completed at ${DateTime.now().toString().substring(11, 16)}
      ''');

      await Future.delayed(Duration(seconds: 1));

      setScanning(false);
      setShowAnimation(false);
    } catch (e) {
      setConsoleOutput('Error: ${e.toString()}');
      setScanning(false);
      setShowAnimation(false);
      setScanPhase('idle');
    }
  }
}
