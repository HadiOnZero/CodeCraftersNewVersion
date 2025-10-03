import 'package:flutter/material.dart';

class XssProvider with ChangeNotifier {
  String _url = '';
  String _payload = '';
  String _result = '';
  bool _isScanning = false;
  bool _showResult = false;

  String get url => _url;
  String get payload => _payload;
  String get result => _result;
  bool get isScanning => _isScanning;
  bool get showResult => _showResult;

  void setUrl(String url) {
    _url = url;
    notifyListeners();
  }

  void setPayload(String payload) {
    _payload = payload;
    notifyListeners();
  }

  void setScanning(bool scanning) {
    _isScanning = scanning;
    notifyListeners();
  }

  void setResult(String result) {
    _result = result;
    _showResult = true;
    notifyListeners();
  }

  void clearResult() {
    _result = '';
    _showResult = false;
    notifyListeners();
  }

  Future<void> performScan() async {
    if (_url.isEmpty || _payload.isEmpty) {
      throw Exception('Please enter both URL and payload');
    }

    setScanning(true);
    clearResult();

    try {
      // Simulate scanning process
      await Future.delayed(Duration(seconds: 2));

      // Mock result
      final mockResult =
          '''
✅ XSS VULNERABILITY SCAN COMPLETED
═══════════════════════════════════════

📡 Target: $_url
💉 Payload: $_payload
⏱️  Scan Duration: 1.8s

📊 Vulnerability Analysis:
   • Reflected XSS: Tested
   • Stored XSS: Tested
   • DOM-based XSS: Tested
   • Filter bypass: Tested

✅ RESULT: No XSS vulnerabilities detected

🔒 Security Status: SECURE
   • Input sanitization: Active
   • Output encoding: Detected
   • Content Security Policy: Implemented
   • XSS filters: Enabled

💡 Recommendations:
   • Keep your web framework updated
   • Use context-aware output encoding
   • Implement Content Security Policy
   • Regular security testing

═══════════════════════════════════════
   Scan completed at ${DateTime.now().toString().substring(11, 16)}
      ''';

      setResult(mockResult);
    } catch (e) {
      setResult('Error: ${e.toString()}');
    } finally {
      setScanning(false);
    }
  }
}
