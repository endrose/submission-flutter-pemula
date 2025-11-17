import 'package:flutter/material.dart';
import 'package:submission_flutter_pemula/presentation/home.dart';

// ==========================================================
// HELPER CLASS untuk controller + validasi (tetap bisa dipakai di Stateless)
// ==========================================================
class LoginController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? validate(String email, String password) {
    if (email.isEmpty) return "Email tidak boleh kosong";

    final emailRegex = RegExp(r"^[\w\.\-]+@([\w\-]+\.)+[\w]{2,4}$");
    if (!emailRegex.hasMatch(email)) return "Format email tidak valid";

    if (password.isEmpty) return "Password tidak boleh kosong (Isikan apa saja!)";

    if (password.length < 6) return "Password minimal 6 karakter";

    return null; // valid
  }
}

// ==========================================================
// LOGIN PAGE – Versi Stateless
// ==========================================================
class Login extends StatelessWidget {
  Login({super.key});

  final controller = LoginController();

  void _showSnackbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(msg),
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: isMobile
            ? _buildMobileLayout(context)
            : _buildWebLayout(context),
      ),
    );
  }

  // ======================= MOBILE (FORM ONLY) ===========================
  Widget _buildMobileLayout(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: _formSection(context),
      ),
    );
  }

  // ======================= DESKTOP/TABLET (IMAGE + FORM) =======================
  Widget _buildWebLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 3, child: _headerImage()),
        Expanded(flex: 2, child: Center(child: _formSection(context))),
      ],
    );
  }

  // ======================= HEADER IMAGE ==============================
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
        child: const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
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

  // ======================= FORM SECTION ===============================
  Widget _formSection(BuildContext context) {
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

          // EMAIL FIELD
          TextField(
            controller: controller.emailController,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // PASSWORD FIELD
          TextField(
            controller: controller.passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // SIGN IN BUTTON
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
                final email = controller.emailController.text.trim();
                final pass = controller.passwordController.text.trim();

                final msg = controller.validate(email, pass);
                if (msg != null) {
                  _showSnackbar(context, msg);
                  return;
                }

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

          // SOCIAL LOGIN
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialIcon("assets/images/google.png"),
              const SizedBox(width: 16),
              _socialIcon("assets/images/twitter.jpg"),
              const SizedBox(width: 16),
              _socialIcon("assets/images/instagram.jpg"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(String path) {
    return Image.asset(path, width: 32, height: 32);
  }
}
