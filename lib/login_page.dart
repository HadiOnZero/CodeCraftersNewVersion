import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:provider/provider.dart';
import 'package:syborgcate_workshop/constants/assets.dart';
import 'package:syborgcate_workshop/main.dart';
import 'package:syborgcate_workshop/register_page.dart';
import 'package:syborgcate_workshop/providers/auth_provider.dart' as app_auth;
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    // Clear any previous errors when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<app_auth.AuthProvider>(
        context,
        listen: false,
      );
      authProvider.clearError();
    });
  }

  Future<void> signIn() async {
    final authProvider = Provider.of<app_auth.AuthProvider>(
      context,
      listen: false,
    );

    try {
      await authProvider.signInWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      // Navigation will be handled by the auth state change listener
    } catch (e) {
      // Error is already handled in the provider
      // Show error dialog if needed
      if (authProvider.error != null) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.redAccent, width: 1),
            ),
            title: Text(
              'LOGIN FAILED',
              style: TextStyle(
                color: Colors.redAccent,
                fontFamily: 'pixels',
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              authProvider.error!,
              style: TextStyle(color: Colors.white, fontFamily: 'pixels'),
            ),
            actions: [
              TextButton(
                style: ButtonStyle(
                  overlayColor: WidgetStatePropertyAll(
                    Colors.redAccent.withOpacity(0.2),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  authProvider.clearError();
                },
                child: Text(
                  'CLOSE',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontFamily: 'pixels',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<app_auth.AuthProvider>(
      builder: (context, authProvider, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: const Text(
              'CodeCrafters',
              style: TextStyle(
                fontFamily: 'pixels',
                color: Colors.greenAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            backgroundColor: Colors.grey[900],
            elevation: 0,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  // Terminal header
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.greenAccent, width: 1),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[900],
                    ),
                    child: Text(
                      'AUTHENTICATION REQUIRED',
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontFamily: 'pixels',
                        fontSize: 12,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Lottie.asset(Assets.assetsLogin, width: 200, height: 200),
                  Text(
                    'SYSTEM LOGIN',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'pixels',
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),
                  SizedBox(height: 40),
                  TextField(
                    controller: emailController,
                    cursorColor: Colors.greenAccent,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.greenAccent),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.greenAccent.withOpacity(0.5),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.greenAccent,
                          width: 2.0,
                        ),
                      ),
                      labelText: 'EMAIL',
                      labelStyle: TextStyle(
                        color: Colors.greenAccent.withOpacity(0.8),
                        fontFamily: 'pixels',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[900],
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    cursorColor: Colors.greenAccent,
                    controller: passwordController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.greenAccent),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                          color: Colors.greenAccent,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.greenAccent.withOpacity(0.5),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.greenAccent,
                          width: 2.0,
                        ),
                      ),
                      labelText: 'PASSWORD',
                      labelStyle: TextStyle(
                        color: Colors.greenAccent.withOpacity(0.8),
                        fontFamily: 'pixels',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[900],
                    ),
                    obscureText: obscureText,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 55,
                    width: 250,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.greenAccent,
                              width: 2,
                            ),
                          ),
                        ),
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.transparent,
                        ),
                        overlayColor: WidgetStatePropertyAll(
                          Colors.greenAccent.withOpacity(0.2),
                        ),
                      ),
                      onPressed: authProvider.isLoading ? null : () => signIn(),
                      child: authProvider.isLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: const CircularProgressIndicator(
                                color: Colors.greenAccent,
                              ),
                            )
                          : const Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'pixels',
                                letterSpacing: 2,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: WidgetStatePropertyAll(
                        Colors.greenAccent.withOpacity(0.1),
                      ),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const RegisterPage(),
                        transitionsBuilder: (_, animation, __, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    ),
                    child: Text(
                      'CREATE ACCOUNT',
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontFamily: 'pixels',
                        fontSize: 14,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
