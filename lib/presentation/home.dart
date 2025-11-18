import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String email;
  const Home({super.key, required this.email});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final searchController = TextEditingController();

  final List<Map<String, String>> events = [
    {"title": "Menghadapi AI dimasa kini", "time": "13.00 PM"},
    {"title": "AI untuk pemula", "time": "07.00 AM"},
    {"title": "Dart pemula", "time": "08.00 AM"},
    {"title": "AI dan Dart sebagai assistant", "time": "10.00 AM"},
    {"title": "Clean architecture", "time": "14.00 AM"},
  ];

  late List<Map<String, String>> filteredEvents;

  @override
  void initState() {
    super.initState();
    filteredEvents = List.from(events);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterEvents(String query) {
    setState(() {
      filteredEvents = events
          .where((e) => e["title"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Events', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green.shade600,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TITLE
                      Text(
                        "Events",
                        style: TextStyle(
                          color: Colors.green.shade600,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Events yang akan datang.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),

                      // EMAIL + LOGOUT
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Welcome ${widget.email}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/');
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

                      const SizedBox(height: 24),
                      const Text(
                        "Segera!",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // SEARCH BAR
                      TextField(
                        controller: searchController,
                        onChanged: _filterEvents,
                        decoration: InputDecoration(
                          labelText: "Cari event...",
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // EVENT LIST
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredEvents.length,
                        itemBuilder: (context, index) {
                          final event = filteredEvents[index];
                          return Column(
                            children: [
                              _taskTile(
                                title: event["title"]!,
                                time: event["time"]!,
                                highlight:
                                    event["title"] ==
                                    "Menghadapi AI dimasa kini",
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/detail',
                                    arguments: {
                                      'title': event["title"]!,
                                      'time': event["time"]!,
                                      'email': widget.email,
                                    },
                                  );
                                },
                              ),
                              const SizedBox(height: 12),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

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
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.work, size: 20, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
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
