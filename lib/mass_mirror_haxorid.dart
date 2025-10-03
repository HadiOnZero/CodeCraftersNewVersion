import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:syborgcate_workshop/providers/haxor_mirror_provider.dart';
import 'package:syborgcate_workshop/constants/assets.dart';
import 'package:syborgcate_workshop/components/matrix_animation.dart';

class MassMirrorHaxorID extends StatelessWidget {
  const MassMirrorHaxorID({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HaxorMirrorProvider>(
      builder: (context, provider, child) {
        return _HaxorMirrorContent(provider: provider);
      },
    );
  }
}

class _HaxorMirrorContent extends StatefulWidget {
  final HaxorMirrorProvider provider;

  const _HaxorMirrorContent({required this.provider});

  @override
  State<_HaxorMirrorContent> createState() => _HaxorMirrorContentState();
}

class _HaxorMirrorContentState extends State<_HaxorMirrorContent> {
  final TextEditingController _targetController = TextEditingController();
  final TextEditingController _attackerController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _attackerController.text = 'IndonesianDedsec';
    _reasonController.text = 'Security Research & Education';
  }

  @override
  void dispose() {
    _targetController.dispose();
    _attackerController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _performHaxorMirror() async {
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

    widget.provider.setTargetUrl(_targetController.text);
    await widget.provider.performHaxorMirror();
  }

  @override
  Widget build(BuildContext context) {
    void aboutHaxorMirror() {
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
              'MASS MIRROR HAXOR.ID',
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
                    'Alat untuk melakukan mass mirror defacement ke HaxorID. Tool ini mensimulasikan proses pembuatan mirror defacement pada multiple server HaxorID untuk keperluan security research dan edukasi.\n\n',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: 'pixels',
                    ),
                  ),
                  Text(
                    'Fitur:\n• Mass mirror ke multiple HaxorID server\n• Auto-generate mirror URLs\n• Real-time status monitoring\n• Export results\n• Attacker attribution',
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

    return Consumer<HaxorMirrorProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.grey[900],
            elevation: 0,
            centerTitle: true,
            title: Text(
              'MASS MIRROR HAXOR.ID',
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
                  aboutHaxorMirror();
                },
                icon: Icon(Icons.info_outline, color: Colors.greenAccent),
              ),
            ],
          ),
          body: Stack(
            children: [
              // Matrix Animation Background - Similar to homepage
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
              SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header Card - Hacker Theme with Animation
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
                          if (provider.isLoading)
                            Container(
                              width: 150,
                              height: 150,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Mirror icon with animation
                                  AnimatedSwitcher(
                                    duration: Duration(milliseconds: 500),
                                    child: Icon(
                                      provider.status == 'success'
                                          ? Icons.check_circle
                                          : provider.status == 'error'
                                          ? Icons.error
                                          : Icons.track_changes,
                                      size: 70,
                                      color: provider.status == 'success'
                                          ? Colors.green
                                          : provider.status == 'error'
                                          ? Colors.red
                                          : Colors.blue,
                                      key: ValueKey(provider.status),
                                    ),
                                  ),
                                  // Scanning animation
                                  if (provider.isLoading)
                                    SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
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
                            'HAXORID MASS MIRROR ATTACK',
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
                            'Create multiple defacement mirrors on HaxorID servers',
                            style: TextStyle(
                              color: Colors.greenAccent.withOpacity(0.8),
                              fontSize: 14,
                              fontFamily: 'pixels',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          if (provider.status != 'idle')
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                provider.status == 'loading'
                                    ? '🚀 LAUNCHING HAXORID MIRROR ATTACK...'
                                    : provider.status == 'success'
                                    ? '✅ HAXORID MIRROR ATTACK SUCCESS!'
                                    : '❌ HAXORID MIRROR ATTACK FAILED',
                                style: TextStyle(
                                  color: provider.status == 'success'
                                      ? Colors.greenAccent
                                      : provider.status == 'error'
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
                              hintText: 'https://target.com',
                              hintStyle: TextStyle(
                                color: Colors.greenAccent.withOpacity(0.5),
                                fontFamily: 'pixels',
                              ),
                              labelText: 'VULNERABLE TARGET URL',
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
                          SizedBox(height: 15),
                          Text(
                            'ATTACKER NAME',
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
                            controller: _attackerController,
                            cursorColor: Colors.greenAccent,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'pixels',
                            ),
                            decoration: InputDecoration(
                              hintText: 'Your hacker name',
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
                                Icons.person,
                                color: Colors.greenAccent.withOpacity(0.8),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            'DEFACEMENT REASON',
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
                            controller: _reasonController,
                            maxLines: 2,
                            cursorColor: Colors.greenAccent,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'pixels',
                            ),
                            decoration: InputDecoration(
                              hintText: 'Reason for defacement',
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
                                Icons.message,
                                color: Colors.greenAccent.withOpacity(0.8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    // Mass Mirror Button - Hacker Theme
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
                        onPressed: provider.isLoading
                            ? null
                            : _performHaxorMirror,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.greenAccent,
                          padding: EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: Colors.greenAccent,
                              width: 2,
                            ),
                          ),
                          elevation: 0,
                        ),
                        child: provider.isLoading
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
                                    'MIRRORING...',
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
                                    Icons.track_changes,
                                    size: 20,
                                    color: Colors.greenAccent,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'LAUNCH HAXORID MIRROR',
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

                    // Mirror Results Card - Hacker Theme
                    if (provider.mirrorResults.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: provider.status == 'success'
                                ? Colors.greenAccent.withOpacity(0.5)
                                : Colors.red.withOpacity(0.5),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  (provider.status == 'success'
                                          ? Colors.greenAccent
                                          : Colors.red)
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
                                  provider.status == 'success'
                                      ? Icons.check_circle
                                      : Icons.error,
                                  color: provider.status == 'success'
                                      ? Colors.greenAccent
                                      : Colors.red,
                                  size: 24,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'MIRROR RESULTS',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.greenAccent,
                                    fontFamily: 'pixels',
                                    letterSpacing: 2,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '${provider.mirrorResults.where((m) => m['status'] == 'success').length}/${provider.mirrorResults.length}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.greenAccent,
                                    fontFamily: 'pixels',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Container(
                              height: 200,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.greenAccent.withOpacity(0.3),
                                ),
                              ),
                              child: ListView.builder(
                                itemCount: provider.mirrorResults.length,
                                itemBuilder: (context, index) {
                                  var mirror = provider.mirrorResults[index];
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 8),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[850],
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: mirror['status'] == 'success'
                                            ? Colors.greenAccent.withOpacity(
                                                0.3,
                                              )
                                            : Colors.red.withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          mirror['status'] == 'success'
                                              ? Icons.check_circle
                                              : Icons.error,
                                          color: mirror['status'] == 'success'
                                              ? Colors.greenAccent
                                              : Colors.red,
                                          size: 16,
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                mirror['server'],
                                                style: TextStyle(
                                                  color: Colors.greenAccent,
                                                  fontFamily: 'pixels',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              if (mirror['url'].isNotEmpty)
                                                Text(
                                                  mirror['url'],
                                                  style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                    fontFamily: 'monospace',
                                                    fontSize: 10,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                            ],
                                          ),
                                        ),
                                        if (mirror['status'] == 'success')
                                          IconButton(
                                            icon: Icon(
                                              Icons.open_in_new,
                                              color: Colors.greenAccent,
                                              size: 16,
                                            ),
                                            onPressed: () {
                                              // Simulate opening mirror URL
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Opening HaxorID mirror: ${mirror['url']}',
                                                    style: TextStyle(
                                                      color: Colors.greenAccent,
                                                      fontFamily: 'pixels',
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      Colors.grey[900],
                                                ),
                                              );
                                            },
                                          ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                    SizedBox(height: 20),

                    // Console Output Card - Hacker Theme
                    if (provider.result.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.greenAccent.withOpacity(0.5),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.greenAccent.withOpacity(0.2),
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
                                  size: 24,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'CONSOLE OUTPUT',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.greenAccent,
                                    fontFamily: 'pixels',
                                    letterSpacing: 2,
                                  ),
                                ),
                                Spacer(),
                                if (provider.result.isNotEmpty)
                                  IconButton(
                                    icon: Icon(
                                      Icons.clear,
                                      color: Colors.greenAccent.withOpacity(
                                        0.5,
                                      ),
                                      size: 18,
                                    ),
                                    onPressed: () {
                                      provider.clearResults();
                                    },
                                  ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Container(
                              height: 200,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.greenAccent.withOpacity(0.3),
                                ),
                              ),
                              child: TextField(
                                controller: TextEditingController(
                                  text: provider.result,
                                ),
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
                                      'HaxorID mirror results will appear here...',
                                  hintStyle: TextStyle(
                                    color: Colors.greenAccent.withOpacity(0.5),
                                    fontFamily: 'monospace',
                                    fontSize: 12,
                                  ),
                                  border: InputBorder.none,
                                ),
                                readOnly: true,
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
                          Icon(
                            Icons.coffee,
                            color: Colors.greenAccent,
                            size: 20,
                          ),
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
                        '© 2024 HADI RAMDHANI - HAXORID MASS MIRROR TOOLS',
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
            ],
          ),
        );
      },
    );
  }
}
