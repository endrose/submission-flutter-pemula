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

  // stateful properties
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    // dispose controller untuk hindari memory leak
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _showSnackbar(String message, {Color bg = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: bg,
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

    return Scaffold(
      // SafeArea agar tidak bertabrakan di notch/device UI
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: isMobile ? _buildMobileLayout() : _buildWebLayout(),
        ),
      ),
    );
  }

  // MOBILE: tampilkan form saja (no image)
  Widget _buildMobileLayout() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: _formSection(),
        ),
      ),
    );
  }

  // WEB/DESKTOP: kiri image, kanan form
  Widget _buildWebLayout() {
    return Row(
      children: [
        // kiri: image (hide on small screens handled by isMobile)
        Expanded(flex: 3, child: _headerImage()),

        // kanan: form, dibungkus SingleChildScrollView agar tidak overflow
        Expanded(
          flex: 2,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: _formSection(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _headerImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/dicoding-camp2025.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.4),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.login, color: Colors.white, size: 32),
              SizedBox(width: 12),
              Text(
                "Dicoding IDCamp",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Submission",
            style: TextStyle(
              color: Colors.green.shade600,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // EMAIL
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.email),
            ),
          ),
          const SizedBox(height: 12),

          // PASSWORD dengan toggle visibility (menggunakan setState)
          TextField(
            controller: passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword; // penggunaan setState
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 12),

          // remember me (Stateful)
          Row(
            children: [
              Checkbox(
                value: _rememberMe,
                onChanged: (v) {
                  setState(() {
                    _rememberMe = v ?? false; // penggunaan setState
                  });
                },
              ),
              const SizedBox(width: 4),
              const Text("Remember me"),
            ],
          ),

          const SizedBox(height: 12),

          // BUTTON LOGIN
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                final email = emailController.text.trim();
                final password = passwordController.text;

                if (email.isEmpty) {
                  _showSnackbar("Email tidak boleh kosong");
                  return;
                }
                final emailRegex = RegExp(r"^[\w\.\-]+@([\w\-]+\.)+[\w]{2,4}$");
                if (!emailRegex.hasMatch(email)) {
                  _showSnackbar("Format email tidak valid");
                  return;
                }
                if (password.isEmpty) {
                  _showSnackbar("Password tidak boleh kosong");
                  return;
                }
                if (password.length < 6) {
                  _showSnackbar("Password minimal 6 karakter");
                  return;
                }

                // jika valid -> lanjut ke Home
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => Home(email: email)),
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
          const Text("Or sign in with", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 12),

          // social icons: beri feedback Snackbar ketika diklik
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => _showSnackbar(
                  "Google sign-in belum tersedia",
                  bg: Colors.blue,
                ),
                child: Image.asset(
                  "assets/images/google.png",
                  width: 36,
                  height: 36,
                ),
              ),
              const SizedBox(width: 16),
              InkWell(
                onTap: () => _showSnackbar(
                  "Twitter sign-in belum tersedia",
                  bg: Colors.blueAccent,
                ),
                child: Image.asset(
                  "assets/images/twitter.jpg",
                  width: 36,
                  height: 36,
                ),
              ),
              const SizedBox(width: 16),
              InkWell(
                onTap: () => _showSnackbar(
                  "Instagram sign-in belum tersedia",
                  bg: Colors.blueAccent,
                ),
                child: Image.asset(
                  "assets/images/instagram.jpg",
                  width: 36,
                  height: 36,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
