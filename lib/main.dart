import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';


void main() => runApp(const CooperApp());

class CooperApp extends StatelessWidget {
  const CooperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CooperApp',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}
