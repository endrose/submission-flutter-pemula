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

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800; // MOBILE CHECK

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: isMobile ? _buildMobileLayout() : _buildWebLayout(),
      ),
    );
  }

  // ======================= MOBILE (FORM ONLY) ===========================
  Widget _buildMobileLayout() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: _formSection(),
      ),
    );
  }

  // ======================= DESKTOP / WEB (IMAGE LEFT + FORM) =======================
  Widget _buildWebLayout() {
    return Row(
      children: [
        Expanded(flex: 3, child: _headerImage()),
        Expanded(flex: 2, child: _formSection()),
      ],
    );
  }

  // ======================= LEFT IMAGE AREA ===========================
  Widget _headerImage() {
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
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

  // ======================= RIGHT FORM ===============================
  Widget _formSection() {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
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
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 32),

          // EMAIL
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // PASSWORD
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                final email = emailController.text.trim();
                final password = passwordController.text.trim();

                // ========== VALIDASI EMAIL KOSONG ==========
                if (email.isEmpty) {
                  _showSnackbar(context, "Email tidak boleh kosong");
                  return;
                }

                // ========== VALIDASI FORMAT EMAIL ==========
                final emailRegex = RegExp(r"^[\w\.\-]+@([\w\-]+\.)+[\w]{2,4}$");
                if (!emailRegex.hasMatch(email)) {
                  _showSnackbar(context, "Format email tidak valid");
                  return;
                }

                // ========== VALIDASI PASSWORD KOSONG ==========
                if (password.isEmpty) {
                  _showSnackbar(context, "Password tidak boleh kosong");
                  return;
                }

                // ========== VALIDASI PASSWORD MINIMAL ==========
                if (password.length < 6) {
                  _showSnackbar(context, "Password minimal 6 karakter");
                  return;
                }

                // ========== JIKA VALID → LANJUT LOGIN ==========
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => Home(email: email)),
                );
              },

              child: const Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),
          const Text("Or sign in with"),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialIconGoogle(),
              const SizedBox(width: 16),
              _socialIconTwitter(),
              const SizedBox(width: 16),
              _socialIconInstagram(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _socialIconGoogle() {
    return Image.asset("assets/images/google.png", width: 32, height: 32);
  }

  Widget _socialIconTwitter() {
    return Image.asset("assets/images/twitter.jpg", width: 32, height: 32);
  }

  Widget _socialIconInstagram() {
    return Image.asset("assets/images/instagram.jpg", width: 32, height: 32);
  }
}
