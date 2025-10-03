import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syborgcate_workshop/login_page.dart';
import 'constants/assets.dart';
import 'package:lottie/lottie.dart';
import 'providers/auth_provider.dart' as app_auth;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool obscureText = true;

  Future<void> register() async {
    final authProvider = Provider.of<app_auth.AuthProvider>(
      context,
      listen: false,
    );

    if (passwordController.text != confirmPasswordController.text) {
      // Tidak perlu set error, langsung return saja
      return;
    }

    await authProvider.createUserWithEmailAndPassword(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (!mounted) return;

    if (authProvider.user != null) {
      showDialog(
        context: context,
        builder: (context) => AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: 1.0,
          child: AlertDialog(
            backgroundColor: Colors.grey[900],
            title: Text(
              'Registration Successful',
              style: TextStyle(color: Colors.greenAccent, fontFamily: 'pixels'),
            ),
            content: Text(
              'You have successfully registered.',
              style: TextStyle(color: Colors.white, fontFamily: 'pixels'),
            ),
            actions: [
              TextButton(
                style: ButtonStyle(
                  overlayColor: WidgetStatePropertyAll(
                    Colors.greenAccent.withOpacity(0.2),
                  ),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => LoginPage(),
                      transitionsBuilder: (_, animation, __, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                    ),
                  );
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontFamily: 'pixels',
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<app_auth.AuthProvider>(
      builder: (context, authProvider, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: const Text(
              'REGISTER',
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
                mainAxisAlignment: MainAxisAlignment.center,
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
                      'CREATE NEW ACCOUNT',
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontFamily: 'pixels',
                        fontSize: 12,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Lottie.asset(Assets.assetsRegister),
                  SizedBox(height: 20),
                  Text(
                    'SYSTEM REGISTRATION',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'pixels',
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
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
                  SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    obscureText: obscureText,
                    cursorColor: Colors.greenAccent,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.greenAccent),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                          color: Colors.greenAccent,
                        ),
                        onPressed: () {
                          toggleObscureText();
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
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: obscureText,
                    cursorColor: Colors.greenAccent,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.greenAccent),
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
                      labelText: 'CONFIRM PASSWORD',
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
                  SizedBox(height: 24),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: authProvider.isLoading ? null : register,
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
                        backgroundColor: authProvider.error != null
                            ? WidgetStatePropertyAll(Colors.red[900])
                            : WidgetStatePropertyAll(Colors.transparent),
                        overlayColor: WidgetStatePropertyAll(
                          Colors.greenAccent.withOpacity(0.2),
                        ),
                      ),
                      child: authProvider.isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.greenAccent,
                              ),
                            )
                          : Text(
                              'REGISTER',
                              style: TextStyle(
                                color: authProvider.error != null
                                    ? Colors.white
                                    : Colors.greenAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'pixels',
                                letterSpacing: 2,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 16),
                  if (authProvider.error != null)
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.red.withOpacity(0.1),
                      ),
                      child: Text(
                        authProvider.error!,
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'pixels',
                          fontSize: 12,
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
