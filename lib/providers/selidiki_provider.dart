import 'package:flutter/material.dart';

class SelidikiProvider with ChangeNotifier {
  String _target = '';
  String _documentType = 'KTP';
  String _result = '';
  bool _isSearching = false;

  String get target => _target;
  String get documentType => _documentType;
  String get result => _result;
  bool get isSearching => _isSearching;

  final List<String> documentTypes = [
    'KTP',
    'Kartu Keluarga',
    'SIM',
    'NIK',
    'Paspor',
  ];

  void setTarget(String target) {
    _target = target;
    notifyListeners();
  }

  void setDocumentType(String type) {
    _documentType = type;
    notifyListeners();
  }

  void setSearching(bool searching) {
    _isSearching = searching;
    notifyListeners();
  }

  void setResult(String result) {
    _result = result;
    notifyListeners();
  }

  void clearResult() {
    _result = '';
    notifyListeners();
  }

  Future<void> performSearch() async {
    if (_target.isEmpty) {
      throw Exception('Please enter a target name');
    }

    setSearching(true);
    clearResult();

    try {
      // Simulate search process
      await Future.delayed(Duration(seconds: 2));

      // Mock result
      final mockResult =
          '''
🔍 SELIDIKI ID RESULT
═══════════════════════════════════════

📋 Target Information:
   • Name: $_target
   • Document Type: $_documentType
   • Search Time: ${DateTime.now().toString().substring(11, 16)}

📊 Analysis Summary:
   • Database Records: 1,247 found
   • Cross-References: 23 matches
   • Verification Status: Pending

🔐 Security Notes:
   • Data encrypted and anonymized
   • No sensitive information exposed
   • Compliant with privacy regulations

═══════════════════════════════════════
   Search completed successfully
      ''';

      setResult(mockResult);
    } catch (e) {
      setResult('Error: ${e.toString()}');
    } finally {
      setSearching(false);
    }
  }
}
