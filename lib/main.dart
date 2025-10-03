import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:syborgcate_workshop/constants/assets.dart';
import 'package:syborgcate_workshop/drawer_content.dart';
import 'package:syborgcate_workshop/components/matrix_animation.dart';
import 'package:syborgcate_workshop/providers/auth_provider.dart' as app_auth;
import 'package:syborgcate_workshop/providers/sql_injection_provider.dart';
import 'package:syborgcate_workshop/providers/xss_provider.dart';
import 'package:syborgcate_workshop/providers/smb_provider.dart';
import 'package:syborgcate_workshop/providers/selidiki_provider.dart';
import 'package:syborgcate_workshop/providers/mass_mirror_provider.dart';
import 'package:syborgcate_workshop/providers/haxor_mirror_provider.dart';
import 'login_page.dart';
import 'package:flutter/services.dart';
import 'dart:io';

void main() async {
  if (kDebugMode) {
    HttpOverrides.global = MyHttpOverrides();
  }
  WidgetsFlutterBinding.ensureInitialized();

  print('🚀 Starting Firebase initialization...');
  print('Platform: ${Platform.operatingSystem}');

  try {
    // Cek apakah file GoogleService-Info.plist ada
    if (Platform.isIOS) {
      try {
        await rootBundle.load('GoogleService-Info.plist');
        print('✅ GoogleService-Info.plist found');
      } catch (e) {
        print('❌ GoogleService-Info.plist NOT found: $e');
      }
    }

    // Inisialisasi Firebase
    firebase_core.FirebaseApp app =
        await firebase_core.Firebase.initializeApp();
    print('✅ Firebase initialized successfully');
    print('App name: ${app.name}');
    print('Options: ${app.options}');
  } catch (e) {
    print('❌ Firebase initialization failed');
    print('Error: $e');
    print('Error type: ${e.runtimeType}');

    if (e is firebase_auth.FirebaseException) {
      print('Firebase code: ${e.code}');
      print('Firebase message: ${e.message}');
    }
  }

  runApp(MainApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => app_auth.AuthProvider()),
        ChangeNotifierProvider(create: (_) => SqlInjectionProvider()),
        ChangeNotifierProvider(create: (_) => XssProvider()),
        ChangeNotifierProvider(create: (_) => SmbProvider()),
        ChangeNotifierProvider(create: (_) => SelidikiProvider()),
        ChangeNotifierProvider(create: (_) => MassMirrorProvider()),
        ChangeNotifierProvider(create: (_) => HaxorMirrorProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.black,
          colorScheme: ColorScheme.dark(
            primary: Colors.greenAccent,
            secondary: Colors.greenAccent,
            surface: Colors.grey[900]!,
            background: Colors.black,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[900],
            foregroundColor: Colors.greenAccent,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.greenAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'pixels',
            ),
          ),
          textTheme: TextTheme(
            displayLarge: TextStyle(color: Colors.white, fontFamily: 'pixels'),
            displayMedium: TextStyle(color: Colors.white, fontFamily: 'pixels'),
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white),
          ),
        ),
        home: Consumer<app_auth.AuthProvider>(
          builder: (context, authProvider, child) {
            if (authProvider.isLoading) {
              return const Scaffold(
                backgroundColor: Colors.black,
                body: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.greenAccent,
                    ),
                  ),
                ),
              );
            }
            if (authProvider.isAuthenticated) {
              return const HomePages();
            }
            return const LoginPage();
          },
        ),
        title: 'CodeCrafters Hacker & DevTools',
      ),
    );
  }
}

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(width: 350, child: DrawerContent()),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.greenAccent),
            onPressed: () async {
              await firebase_auth.FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                // ignore: use_build_context_synchronously
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const LoginPage(),
                  transitionsBuilder: (_, animation, __, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                ),
              );
            },
          ),
        ],
        centerTitle: true,
        title: Text(
          'CodeCrafters',
          style: TextStyle(
            color: Colors.greenAccent,
            fontFamily: 'pixels',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        backgroundColor: Colors.grey[900],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.greenAccent),
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
                  Colors.black.withOpacity(0.7),
                  Colors.grey[900]!.withOpacity(0.5),
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          ),
          // Main content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Terminal-style header
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.greenAccent, width: 1),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[900],
                    ),
                    child: Text(
                      'SYSTEM READY',
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontFamily: 'pixels',
                        fontSize: 14,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),

                  // Hacker animation with glow effect
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
                    child: GestureDetector(
                      onDoubleTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.grey[900],
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.greenAccent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              title: Row(
                                children: [
                                  Image(
                                    image: AssetImage(Assets.assetsLauncher),
                                    width: 50,
                                    height: 50,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Support me :D',
                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'pixels',
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              content: Text(
                                'https://github.com/IndonesianDedsec\nhttps://github.com/HadiOnZero\n\nThanks to :\nSyborg Syndicate\nIMPHNEN\nMy Self ( Hadi Ramdhani )',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'pixels',
                                  fontSize: 12,
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
                      child: Lottie.asset(
                        Assets.assetsHacker,
                        width: 250,
                        height: 250,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // Main title with glitch effect
                  Text(
                    'WELCOME TO CODECRAFTERS',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'pixels',
                      color: Colors.white,
                      letterSpacing: 3,
                      shadows: [
                        Shadow(
                          color: Colors.greenAccent,
                          blurRadius: 10,
                          offset: Offset(0, 0),
                        ),
                        Shadow(
                          color: Colors.greenAccent.withOpacity(0.5),
                          blurRadius: 20,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),

                  // Subtitle
                  Text(
                    'Multi Tools for Hackers and Developers',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.greenAccent.withOpacity(0.8),
                      fontFamily: 'pixels',
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 40),

                  // Status indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'SYSTEM ONLINE',
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontFamily: 'pixels',
                          fontSize: 12,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
