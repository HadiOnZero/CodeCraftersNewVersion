import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:syborgcate_workshop/providers/zoneh_archive_provider.dart';
import 'package:syborgcate_workshop/constants/assets.dart';
import 'package:syborgcate_workshop/components/matrix_animation.dart';

class ZoneHArchiveScraper extends StatelessWidget {
  const ZoneHArchiveScraper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ZoneHArchiveProvider>(
      builder: (context, provider, child) {
        return _ZoneHArchiveContent(provider: provider);
      },
    );
  }
}

class _ZoneHArchiveContent extends StatefulWidget {
  final ZoneHArchiveProvider provider;

  const _ZoneHArchiveContent({required this.provider});

  @override
  State<_ZoneHArchiveContent> createState() => _ZoneHArchiveContentState();
}

class _ZoneHArchiveContentState extends State<_ZoneHArchiveContent> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Load initial data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.provider.scrapeDefacementArchive();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.9 &&
        widget.provider.hasMoreData &&
        !widget.provider.isLoading) {
      widget.provider.scrapeDefacementArchive(loadMore: true);
    }
  }

  void _showAboutDialog() {
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
            'ZONE-H ARCHIVE SCRAPER',
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
                  'Alat untuk mengumpulkan data defacement dari Zone-H archive. Tool ini mensimulasikan proses scraping data defacement dari Zone-H.org untuk keperluan security research dan analisis.\n\n',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontFamily: 'pixels',
                  ),
                ),
                Text(
                  'Fitur:\n• Real-time data scraping\n• Filter by time period\n• Search functionality\n• Statistics dashboard\n• Export capabilities\n• Infinite scroll loading',
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

  @override
  Widget build(BuildContext context) {
    return Consumer<ZoneHArchiveProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.grey[900],
            elevation: 0,
            centerTitle: true,
            title: Text(
              'ZONE-H ARCHIVE SCRAPER',
              style: TextStyle(
                color: Colors.greenAccent,
                fontFamily: 'pixels',
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontSize: 18,
              ),
            ),
            iconTheme: IconThemeData(color: Colors.greenAccent),
            actions: [
              IconButton(
                onPressed: () {
                  _showAboutDialog();
                },
                icon: Icon(Icons.info_outline, color: Colors.greenAccent),
              ),
            ],
          ),
          body: Stack(
            children: [
              // Matrix Animation Background
              Positioned.fill(
                child: MatrixAnimation(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
              // Overlay with gradient for better text visibility
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.grey[900]!.withOpacity(0.6),
                      Colors.black.withOpacity(0.9),
                    ],
                  ),
                ),
              ),
              // Main content
              Column(
                children: [
                  // Statistics Dashboard
                  _buildStatisticsCard(provider),

                  // Search and Filter Section
                  _buildSearchFilterSection(provider),

                  // Results List
                  Expanded(child: _buildResultsList(provider)),
                ],
              ),

              // Loading indicator
              if (provider.isLoading && provider.defacementData.isEmpty)
                Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.greenAccent, width: 1),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.greenAccent,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'SCRAPING ZONE-H ARCHIVE...',
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontFamily: 'pixels',
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatisticsCard(ZoneHArchiveProvider provider) {
    final stats = provider.getStatistics();

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
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
              Icon(Icons.analytics, color: Colors.greenAccent, size: 20),
              SizedBox(width: 8),
              Text(
                'ARCHIVE STATISTICS',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent,
                  fontFamily: 'pixels',
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('TOTAL', stats['total'].toString(), Colors.blue),
              _buildStatItem('TODAY', stats['today'].toString(), Colors.green),
              _buildStatItem('WEEK', stats['week'].toString(), Colors.orange),
              _buildStatItem('MONTH', stats['month'].toString(), Colors.purple),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
            fontFamily: 'pixels',
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.greenAccent.withOpacity(0.7),
            fontFamily: 'pixels',
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchFilterSection(ZoneHArchiveProvider provider) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.greenAccent.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Search Field
          TextField(
            controller: _searchController,
            cursorColor: Colors.greenAccent,
            style: TextStyle(color: Colors.white, fontFamily: 'pixels'),
            decoration: InputDecoration(
              hintText: 'Search by URL, attacker, method, or country...',
              hintStyle: TextStyle(
                color: Colors.greenAccent.withOpacity(0.5),
                fontFamily: 'pixels',
                fontSize: 12,
              ),
              labelText: 'SEARCH ARCHIVE',
              labelStyle: TextStyle(
                color: Colors.greenAccent.withOpacity(0.8),
                fontFamily: 'pixels',
                fontSize: 12,
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
                borderSide: BorderSide(color: Colors.greenAccent, width: 2),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.greenAccent.withOpacity(0.8),
                size: 18,
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.greenAccent,
                        size: 18,
                      ),
                      onPressed: () {
                        _searchController.clear();
                        provider.setSearchQuery('');
                      },
                    )
                  : null,
            ),
            onChanged: (value) {
              provider.setSearchQuery(value);
            },
          ),
          SizedBox(height: 12),
          // Filter Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFilterButton('ALL', 'all', provider),
              _buildFilterButton('TODAY', 'today', provider),
              _buildFilterButton('WEEK', 'week', provider),
              _buildFilterButton('MONTH', 'month', provider),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(
    String label,
    String filter,
    ZoneHArchiveProvider provider,
  ) {
    final isActive = provider.filterType == filter;

    return ElevatedButton(
      onPressed: () {
        provider.setFilterType(filter);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.greenAccent : Colors.grey[850],
        foregroundColor: isActive ? Colors.black : Colors.greenAccent,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(
            color: isActive
                ? Colors.greenAccent
                : Colors.greenAccent.withOpacity(0.3),
            width: 1,
          ),
        ),
        elevation: 0,
      ),
      child: Text(
        label,
        style: TextStyle(fontFamily: 'pixels', fontSize: 10, letterSpacing: 1),
      ),
    );
  }

  Widget _buildResultsList(ZoneHArchiveProvider provider) {
    final data = provider.filteredData;

    if (data.isEmpty && !provider.isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.greenAccent.withOpacity(0.5),
            ),
            SizedBox(height: 16),
            Text(
              'NO DATA FOUND',
              style: TextStyle(
                color: Colors.greenAccent,
                fontFamily: 'pixels',
                fontSize: 18,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Try adjusting your search or filter criteria',
              style: TextStyle(
                color: Colors.greenAccent.withOpacity(0.7),
                fontFamily: 'pixels',
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: data.length + (provider.hasMoreData ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= data.length) {
          return _buildLoadingMoreIndicator();
        }

        final item = data[index];
        return _buildDefacementItem(item);
      },
    );
  }

  Widget _buildDefacementItem(Map<String, dynamic> item) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.greenAccent.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.link, color: Colors.greenAccent, size: 16),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  item['url'] ?? 'Unknown URL',
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontFamily: 'pixels',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoChip(
                Icons.person,
                item['attacker'] ?? 'Unknown',
                Colors.blue,
              ),
              _buildInfoChip(
                Icons.flag,
                item['country'] ?? 'Unknown',
                Colors.orange,
              ),
              _buildInfoChip(
                Icons.code,
                item['method'] ?? 'Unknown',
                Colors.purple,
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatTimestamp(item['timestamp'] ?? ''),
                style: TextStyle(
                  color: Colors.greenAccent.withOpacity(0.7),
                  fontFamily: 'pixels',
                  fontSize: 10,
                ),
              ),
              Text(
                item['system'] ?? 'Unknown System',
                style: TextStyle(
                  color: Colors.greenAccent.withOpacity(0.5),
                  fontFamily: 'monospace',
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 12),
          SizedBox(width: 4),
          Text(
            text.length > 10 ? '${text.substring(0, 10)}...' : text,
            style: TextStyle(color: color, fontFamily: 'pixels', fontSize: 9),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingMoreIndicator() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'LOADING MORE DATA...',
              style: TextStyle(
                color: Colors.greenAccent.withOpacity(0.7),
                fontFamily: 'pixels',
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(String timestamp) {
    try {
      final date = DateTime.parse(timestamp);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return 'Unknown';
    }
  }
}
