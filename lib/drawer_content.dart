import 'package:flutter/material.dart';
import 'package:syborgcate_workshop/components/button_custom.dart';
import 'package:syborgcate_workshop/constants/assets.dart';
import 'package:syborgcate_workshop/selidiki_id.dart';
import 'package:syborgcate_workshop/smb_enum_nmap.dart';
import 'package:syborgcate_workshop/vuln_sql_injection_check.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        children: [
          Image(image: AssetImage(Assets.assetsShop), width: 100, height: 100),
          Text(
            'CodeCrafters',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
              fontFamily: 'pixels',
            ),
          ),
          SizedBox(height: 20),
          Text(
            'All Menu',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 5),
          SizedBox(
            width: 250,
            child: ButtonCustom(
              titles: 'SQLi Checker',
              actions: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => VulnSqlInjectionCheck(),
                    transitionsBuilder: (_, animation, __, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 1),
          SizedBox(
            width: 250,
            child: ButtonCustom(
              titles: 'SMB Enumeration with nmap',
              actions: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => SmbEnumNmap(),
                    transitionsBuilder: (_, animation, __, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 1),
          SizedBox(
            width: 250,
            child: ButtonCustom(
              titles: 'SELIDIKI ID',
              actions: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => SelidikiId(),
                    transitionsBuilder: (_, animation, __, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
