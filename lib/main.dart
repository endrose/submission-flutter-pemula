import 'package:flutter/material.dart';
import 'package:submission_flutter_pemula/presentation/login.dart';
import 'package:submission_flutter_pemula/presentation/home.dart';
import 'package:submission_flutter_pemula/presentation/widgets/detail.dart'; // pastikan nama file benar

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Submission Flutter Pemula',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      home: const Login(),

      routes: {
        '/home': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
          return Home(email: args['email']);
        },

        '/detail': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
          return DetailPage(
            title: args['title'],
            time: args['time'],
            email: args['email'],
          );
        },
      },
    );
  }
}
