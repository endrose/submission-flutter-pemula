import 'package:flutter/material.dart';
import 'package:submission_flutter_pemula/presentation/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Login')),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(
                    'assets/images/dicoding-camp2025.png',
                  ),
                  fit: BoxFit.fill,
                ),
                gradient: LinearGradient(
                  colors: [
                    //
                    Colors.blueAccent.shade200,
                    Colors.blueAccent.shade400,
                    Colors.blueAccent.shade700,
                  ],
                  begin: AlignmentGeometry.bottomRight,
                  end: AlignmentGeometry.bottomLeft,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //
                    Icon(Icons.login, size: 30),
                    const SizedBox(width: 16),
                    RichText(
                      text: const TextSpan(
                        children: [
                          //
                          TextSpan(
                            text: 'Dicoding',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                          TextSpan(
                            text: ' IDCamp',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(48),
                child: Row(
                  children: [
                    //
                    Container(
                      width: 400,
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Form(
                        child: Column(
                          children: [
                            //
                            Text(
                              'Submission',

                              style: TextStyle(
                                color: Colors.green[500],
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 32),
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                fillColor: Colors.white,
                                hoverColor: Colors.white,

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                labelText: 'Email',
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: passwordController,

                              obscureText: true,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                hoverColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                labelText: 'Password',
                              ),
                            ),
                            SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[600],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  // KE HOME
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return Home(
                                          email: emailController.text,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Or sign in with",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/images/google.png",
                                  width: 30,
                                  height: 30,
                                ),
                                const SizedBox(width: 16),
                                Image.asset(
                                  "assets/images/google.png",
                                  width: 30,
                                  height: 30,
                                ),
                                const SizedBox(width: 16),

                                Image.asset(
                                  "assets/images/google.png",
                                  width: 30,
                                  height: 30,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
