import 'package:flutter/foundation.dart';

class ZoneHArchiveProvider extends ChangeNotifier {
  bool _isLoading = false;
  String _status = 'idle'; // idle, loading, success, error
  List<Map<String, dynamic>> _defacementData = [];
  String _errorMessage = '';
  String _searchQuery = '';
  String _filterType = 'all'; // all, today, week, month
  int _currentPage = 1;
  bool _hasMoreData = true;

  // Getters
  bool get isLoading => _isLoading;
  String get status => _status;
  List<Map<String, dynamic>> get defacementData => _defacementData;
  String get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  String get filterType => _filterType;
  int get currentPage => _currentPage;
  bool get hasMoreData => _hasMoreData;

  // Setters
  void setSearchQuery(String query) {
    _searchQuery = query;
    _currentPage = 1;
    _defacementData.clear();
    notifyListeners();
  }

  void setFilterType(String filter) {
    _filterType = filter;
    _currentPage = 1;
    _defacementData.clear();
    notifyListeners();
  }

  void clearResults() {
    _defacementData.clear();
    _errorMessage = '';
    _status = 'idle';
    _currentPage = 1;
    _hasMoreData = true;
    notifyListeners();
  }

  // Filter data based on search query
  List<Map<String, dynamic>> get filteredData {
    if (_searchQuery.isEmpty) {
      return _defacementData;
    }

    return _defacementData.where((item) {
      final query = _searchQuery.toLowerCase();
      return item['url']?.toLowerCase().contains(query) == true ||
          item['attacker']?.toLowerCase().contains(query) == true ||
          item['method']?.toLowerCase().contains(query) == true ||
          item['country']?.toLowerCase().contains(query) == true;
    }).toList();
  }

  // Scrape Zone-H defacement archive
  Future<void> scrapeDefacementArchive({bool loadMore = false}) async {
    if (_isLoading) return;

    if (!loadMore) {
      _currentPage = 1;
      _defacementData.clear();
      _hasMoreData = true;
    }

    _isLoading = true;
    _status = 'loading';
    _errorMessage = '';
    notifyListeners();

    try {
      // Simulate scraping Zone-H archive
      // In real implementation, this would scrape actual Zone-H pages
      await Future.delayed(Duration(seconds: 2));

      // Simulate different data based on filter type
      List<Map<String, dynamic>> newData = [];

      if (_filterType == 'today') {
        newData = _generateTodayData();
      } else if (_filterType == 'week') {
        newData = _generateWeekData();
      } else if (_filterType == 'month') {
        newData = _generateMonthData();
      } else {
        newData = _generateAllData();
      }

      // Simulate pagination
      if (newData.length < 20) {
        _hasMoreData = false;
      }

      if (loadMore) {
        _defacementData.addAll(newData);
      } else {
        _defacementData = newData;
      }

      _status = 'success';
      _currentPage++;
    } catch (e) {
      _errorMessage = 'Error scraping Zone-H archive: ${e.toString()}';
      _status = 'error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Generate simulated data for different time periods
  List<Map<String, dynamic>> _generateTodayData() {
    final now = DateTime.now();
    return List.generate(15, (index) {
      return {
        'id': 'zh_${now.millisecondsSinceEpoch}_$index',
        'url': _generateRandomUrl(),
        'attacker': _generateRandomAttacker(),
        'method': _generateRandomMethod(),
        'country': _generateRandomCountry(),
        'timestamp': now.subtract(Duration(hours: index * 2)).toString(),
        'ip': _generateRandomIp(),
        'system': _generateRandomSystem(),
      };
    });
  }

  List<Map<String, dynamic>> _generateWeekData() {
    final now = DateTime.now();
    return List.generate(25, (index) {
      return {
        'id': 'zh_${now.millisecondsSinceEpoch}_$index',
        'url': _generateRandomUrl(),
        'attacker': _generateRandomAttacker(),
        'method': _generateRandomMethod(),
        'country': _generateRandomCountry(),
        'timestamp': now.subtract(Duration(days: index ~/ 4)).toString(),
        'ip': _generateRandomIp(),
        'system': _generateRandomSystem(),
      };
    });
  }

  List<Map<String, dynamic>> _generateMonthData() {
    final now = DateTime.now();
    return List.generate(30, (index) {
      return {
        'id': 'zh_${now.millisecondsSinceEpoch}_$index',
        'url': _generateRandomUrl(),
        'attacker': _generateRandomAttacker(),
        'method': _generateRandomMethod(),
        'country': _generateRandomCountry(),
        'timestamp': now.subtract(Duration(days: index ~/ 2)).toString(),
        'ip': _generateRandomIp(),
        'system': _generateRandomSystem(),
      };
    });
  }

  List<Map<String, dynamic>> _generateAllData() {
    final now = DateTime.now();
    return List.generate(20, (index) {
      return {
        'id': 'zh_${now.millisecondsSinceEpoch}_$index',
        'url': _generateRandomUrl(),
        'attacker': _generateRandomAttacker(),
        'method': _generateRandomMethod(),
        'country': _generateRandomCountry(),
        'timestamp': now.subtract(Duration(days: index)).toString(),
        'ip': _generateRandomIp(),
        'system': _generateRandomSystem(),
      };
    });
  }

  // Helper methods to generate realistic data
  String _generateRandomUrl() {
    final domains = [
      'example.com',
      'testsite.org',
      'vulnerable.net',
      'target.gov',
      'company.com',
      'school.edu',
      'shop.store',
      'blog.wordpress.com',
      'forum.discussion.com',
      'news.portal.com',
    ];

    final protocols = ['http://', 'https://'];
    final paths = ['/', '/admin', '/login', '/index.php', '/main.html'];

    return '${protocols[DateTime.now().millisecond % protocols.length]}'
        '${domains[DateTime.now().millisecond % domains.length]}'
        '${paths[DateTime.now().millisecond % paths.length]}';
  }

  String _generateRandomAttacker() {
    final attackers = [
      'IndonesianDedsec',
      'H4x0rTeam',
      'CyberGhost',
      'DarkKnight',
      'SystemFailure',
      'WebDefacer',
      'AnonymousID',
      'SecurityTeam',
      'Hacktivist',
      'DigitalWarrior',
    ];

    return attackers[DateTime.now().millisecond % attackers.length];
  }

  String _generateRandomMethod() {
    final methods = [
      'SQL Injection',
      'XSS (Cross Site Scripting)',
      'File Upload',
      'RFI/LFI',
      'Brute Force',
      'Social Engineering',
      '0day Exploit',
      'Misconfiguration',
      'Weak Password',
      'Unknown',
    ];

    return methods[DateTime.now().millisecond % methods.length];
  }

  String _generateRandomCountry() {
    final countries = [
      'Indonesia',
      'United States',
      'Turkey',
      'Brazil',
      'India',
      'Russia',
      'China',
      'Germany',
      'France',
      'United Kingdom',
    ];

    return countries[DateTime.now().millisecond % countries.length];
  }

  String _generateRandomIp() {
    return '${DateTime.now().millisecond % 255}.'
        '${DateTime.now().millisecond % 255}.'
        '${DateTime.now().millisecond % 255}.'
        '${DateTime.now().millisecond % 255}';
  }

  String _generateRandomSystem() {
    final systems = [
      'Linux Apache PHP',
      'Windows IIS ASP.NET',
      'Nginx Ubuntu PHP',
      'Apache CentOS PHP',
      'Windows Server IIS',
      'Debian Nginx PHP',
      'Ubuntu Apache MySQL',
      'CentOS Nginx Node.js',
      'Windows Apache PHP',
      'Unknown System',
    ];

    return systems[DateTime.now().millisecond % systems.length];
  }

  // Helper method to sort and take top items
  List<MapEntry<String, int>> _sortAndTakeTop(
    List<MapEntry<String, int>> entries,
    int count,
  ) {
    entries.sort((a, b) => b.value.compareTo(a.value));
    return entries.take(count).toList();
  }

  // Get statistics
  Map<String, dynamic> getStatistics() {
    if (_defacementData.isEmpty) {
      return {
        'total': 0,
        'today': 0,
        'week': 0,
        'month': 0,
        'topCountries': {},
        'topAttackers': {},
        'topMethods': {},
      };
    }

    final now = DateTime.now();
    final today = _defacementData.where((item) {
      final timestamp = DateTime.parse(item['timestamp']);
      return timestamp.year == now.year &&
          timestamp.month == now.month &&
          timestamp.day == now.day;
    }).length;

    final week = _defacementData.where((item) {
      final timestamp = DateTime.parse(item['timestamp']);
      return now.difference(timestamp).inDays <= 7;
    }).length;

    final month = _defacementData.where((item) {
      final timestamp = DateTime.parse(item['timestamp']);
      return now.difference(timestamp).inDays <= 30;
    }).length;

    // Count by countries
    final countryCounts = <String, int>{};
    for (var item in _defacementData) {
      final country = item['country'] as String;
      countryCounts[country] = (countryCounts[country] ?? 0) + 1;
    }

    // Count by attackers
    final attackerCounts = <String, int>{};
    for (var item in _defacementData) {
      final attacker = item['attacker'] as String;
      attackerCounts[attacker] = (attackerCounts[attacker] ?? 0) + 1;
    }

    // Count by methods
    final methodCounts = <String, int>{};
    for (var item in _defacementData) {
      final method = item['method'] as String;
      methodCounts[method] = (methodCounts[method] ?? 0) + 1;
    }

    return {
      'total': _defacementData.length,
      'today': today,
      'week': week,
      'month': month,
      'topCountries': _sortAndTakeTop(countryCounts.entries.toList(), 5),
      'topAttackers': _sortAndTakeTop(attackerCounts.entries.toList(), 5),
      'topMethods': _sortAndTakeTop(methodCounts.entries.toList(), 5),
    };
  }
}
