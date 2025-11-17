import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final String email;
  const Home({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= TITLE =================
              const Text(
                "Events",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 4),

              const Text(
                "Events yang akan datang. ",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

              const SizedBox(height: 4),

              // ============ EMAIL + LOGOUT ============
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Welcome $email",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Tombol Logout
                  TextButton(
                    onPressed: () {
                      // Kembali ke Login
                      Navigator.pushReplacementNamed(context, '/');
                      // Kalau pakai MaterialPageRoute:
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Login()));
                    },
                    child: const Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // ================= SECTION TITLE =================
              const Text(
                "Segera!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 16),

              // ================= LIST ITEMS =================
              Expanded(
                child: ListView(
                  children: [
                    _taskTile(
                      title: "Menghadapi AI dimasa kini",
                      time: "13.00 PM",
                      highlight: true,
                      onTap: () {
                        // NAVIGATE TO DETAIL PAGE
                        Navigator.pushNamed(
                          context,
                          '/detail',
                          arguments: {
                            'title': 'Menghadapi AI dimasa kini',
                            'time': '13.00 PM',
                            'email': email,
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _taskTile(
                      title: "AI untuk pemula",
                      time: "07.00 AM",
                      onTap: () {
                        // NAVIGATE TO DETAIL PAGE
                        Navigator.pushNamed(
                          context,
                          '/detail',
                          arguments: {
                            'title': 'AI untuk pemula',
                            'time': '07.00 AM',
                            'email': email,
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _taskTile(
                      title: "Dart pemula",
                      time: "08.00 AM",
                      onTap: () {
                        // NAVIGATE TO DETAIL PAGE
                        Navigator.pushNamed(
                          context,
                          '/detail',
                          arguments: {
                            'title': 'Dart pemula',
                            'time': '08.00 AM',
                            'email': email,
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _taskTile(
                      title: "AI dan Dart sebagai asssitent",
                      time: "10.00 AM",
                      onTap: () {
                        // NAVIGATE TO DETAIL PAGE
                        Navigator.pushNamed(
                          context,
                          '/detail',
                          arguments: {
                            'title': 'AI dan Dart sebagai asssitent',
                            'time': '10.00 AM',
                            'email': email,
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _taskTile(
                      title: "Clean architecture",
                      time: "14.00 AM",
                      onTap: () {
                        // NAVIGATE TO DETAIL PAGE
                        Navigator.pushNamed(
                          context,
                          '/detail',
                          arguments: {
                            'title': 'Clean architecture',
                            'time': '14.00 AM',
                            'email': email,
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= CARD ITEM =================
  Widget _taskTile({
    required String title,
    required String time,
    bool highlight = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: highlight ? Colors.grey.shade300 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            // Icon bulat
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.work, size: 20, color: Colors.white),
            ),

            const SizedBox(width: 16),

            // Text
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Time
            Text(
              time,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
