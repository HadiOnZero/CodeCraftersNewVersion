import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:syborgcate_workshop/components/button_custom.dart';
import 'package:syborgcate_workshop/constants/assets.dart';
import 'package:syborgcate_workshop/mass_mirror_zone-h.dart';
import 'package:syborgcate_workshop/mass_mirror_haxorid.dart';
import 'package:syborgcate_workshop/selidiki_id.dart';
import 'package:syborgcate_workshop/smb_enum_nmap.dart';
import 'package:syborgcate_workshop/vuln_sql_injection_check.dart';
import 'package:syborgcate_workshop/xss_check.dart';
import 'package:syborgcate_workshop/components/matrix_horizontal.dart';
import 'package:syborgcate_workshop/about_app_page.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.grey[900]!, Colors.black, Colors.grey[900]!],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 40,
        ), // Reduced from 60 to 40
        child: Column(
          children: [
            // Anonymous hacker animation
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
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'CODECRAFTERS',
              style: TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
                fontSize: 24,
                fontFamily: 'pixels',
                letterSpacing: 3,
                shadows: [
                  Shadow(
                    color: Colors.greenAccent.withOpacity(0.5),
                    blurRadius: 10,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15), // Reduced from 20 to 15
            // Matrix horizontal animation with attacker names - Enhanced version
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.greenAccent.withOpacity(0.5),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7),
                      ),
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.greenAccent.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent.withOpacity(0.1),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.greenAccent,
                          size: 14,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'ZONE-H.ORG - HAXOR.ID ATTACKERS',
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontFamily: 'monospace',
                            fontSize: 10,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.greenAccent,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40, // Fixed height to prevent overflow
                    child: MatrixHorizontal(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // Reduced from 25 to 20
            // Terminal-style menu header
            InkWell(
              onTap: () => _showToolsInfoDialog(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.greenAccent.withOpacity(0.5),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[850],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'AVAILABLE TOOLS',
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: 'pixels',
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.info_outline,
                      color: Colors.greenAccent.withOpacity(0.7),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15), // Reduced from 20 to 15
            // Menu items with hacker style - Updated names with better icons
            _buildMenuItem(
              context,
              'SQL INJECTION CHECKER',
              VulnSqlInjectionCheck(),
              Icons.storage,
            ),
            SizedBox(height: 6), // Reduced from 8 to 6
            _buildMenuItem(
              context,
              'SMB NETWORK SCANNER',
              SmbEnumNmap(),
              Icons.network_check,
            ),
            SizedBox(height: 6), // Reduced from 8 to 6
            _buildMenuItem(
              context,
              'OSINT INVESTIGATOR',
              SelidikiId(),
              Icons.person_search,
            ),
            SizedBox(height: 6), // Reduced from 8 to 6
            _buildMenuItem(
              context,
              'XSS SECURITY CHECKER',
              XssCheck(),
              Icons.code,
            ),
            SizedBox(height: 6), // Reduced from 8 to 6
            _buildMenuItem(
              context,
              'MASS MIRROR ZONE-H.ORG',
              MassMirrorZone(),
              Icons.track_changes,
            ),
            SizedBox(height: 6), // Reduced from 8 to 6
            _buildMenuItem(
              context,
              'MASS MIRROR HAXOR.ID',
              MassMirrorHaxorID(),
              Icons.track_changes,
            ),
            SizedBox(height: 6),
            _buildMenuItem(
              context,
              'ABOUT APP',
              AboutAppPage(),
              Icons.info_outline,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    Widget page,
    IconData icon,
  ) {
    return Container(
      width: 260, // Reduced from 280 to 260
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.grey[850]),
          foregroundColor: WidgetStatePropertyAll(Colors.greenAccent),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: Colors.greenAccent.withOpacity(0.3),
                width: 1,
              ),
            ),
          ),
          overlayColor: WidgetStatePropertyAll(
            Colors.greenAccent.withOpacity(0.2),
          ),
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(vertical: 12),
          ), // Reduced from 15 to 12
        ),
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => page,
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 8), // Reduced from 10 to 8
            Icon(
              icon,
              size: 18,
              color: Colors.greenAccent,
            ), // Reduced from 20 to 18
            SizedBox(width: 8), // Reduced from 10 to 8
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'pixels',
                  fontSize: 11, // Reduced from 12 to 11
                  letterSpacing: 1,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14, // Reduced from 16 to 14
              color: Colors.greenAccent.withOpacity(0.5),
            ),
            SizedBox(width: 8), // Reduced from 10 to 8
          ],
        ),
      ),
    );
  }

  void _showToolsInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.greenAccent, size: 24),
              SizedBox(width: 10),
              Text(
                'TOOLS INFORMATION',
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontFamily: 'pixels',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildToolInfoItem(
                  'SQL INJECTION CHECKER',
                  'Memeriksa kerentanan SQL Injection pada website target.',
                  Icons.storage,
                ),
                SizedBox(height: 12),
                _buildToolInfoItem(
                  'SMB NETWORK SCANNER',
                  'Melakukan scanning port SMB (445) untuk identifikasi celah keamanan.',
                  Icons.network_check,
                ),
                SizedBox(height: 12),
                _buildToolInfoItem(
                  'OSINT INVESTIGATOR',
                  'Melakukan investigasi OSINT (Open Source Intelligence) untuk mengumpulkan informasi.',
                  Icons.person_search,
                ),
                SizedBox(height: 12),
                _buildToolInfoItem(
                  'XSS SECURITY CHECKER',
                  'Memeriksa kerentanan Cross-Site Scripting (XSS) pada website.',
                  Icons.code,
                ),
                SizedBox(height: 12),
                _buildToolInfoItem(
                  'MASS MIRROR ZONE-H.ORG',
                  'Melakukan mass mirror pada website zone-h.org untuk dokumentasi deface.',
                  Icons.track_changes,
                ),
                SizedBox(height: 12),
                _buildToolInfoItem(
                  'MASS MIRROR HAXOR.ID',
                  'Melakukan mass mirror pada website haxor.id untuk dokumentasi deface.',
                  Icons.track_changes,
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orange.withOpacity(0.8),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.orange.withOpacity(0.1),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.orange,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'PERINGATAN: Tools ini hanya untuk keperluan edukasi dan testing keamanan.',
                          style: TextStyle(
                            color: Colors.orange.withOpacity(0.9),
                            fontSize: 11,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'CLOSE',
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontFamily: 'pixels',
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Colors.greenAccent.withOpacity(0.5),
              width: 1,
            ),
          ),
        );
      },
    );
  }

  Widget _buildToolInfoItem(String title, String description, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.greenAccent.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
        color: Colors.black,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.greenAccent, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 12,
                    fontFamily: 'pixels',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 10,
                    fontFamily: 'monospace',
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
