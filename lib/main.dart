import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:syborgcate_workshop/constants/assets.dart';
import 'package:syborgcate_workshop/drawer_content.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return const HomePages();
          }
          return const LoginPage();
        },
      ),
      title: 'CodeCrafters Hacker & DevTools',
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
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
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
          style: TextStyle(color: Colors.black, fontFamily: 'pixels'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 250),
              GestureDetector(
                onDoubleTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Row(
                          children: [
                            Image(
                              image: AssetImage(Assets.assetsLauncher),
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Follow My Github and Support :D',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        content: Text(
                          'https://github.com/IndonesianDedsec\n\nThanks to :\nSyborg Syndicate\nMusa Fawwaz\nMy Self ( Hadi Ramdhani )',
                        ),
                        actions: [
                          TextButton(
                            style: ButtonStyle(
                              overlayColor: WidgetStatePropertyAll(Colors.grey),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'CLOSE',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Lottie.asset(
                  Assets.assetsHacker,
                  width: 200,
                  height: 200,
                ),
              ),
              Text(
                'Welcome to CodeCrafters',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'Multi Tools for Hackers and Developers',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
