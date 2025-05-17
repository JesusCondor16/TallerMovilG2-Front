import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/login_page.dart';
import 'views/create_account_screen.dart';
import 'views/register_page.dart';
import 'views/home_page.dart';
import 'views/perfil_page.dart';

import 'viewmodels/login_viewmodel.dart';
import 'viewmodels/register_viewmodel.dart';  // Importa también el RegisterViewModel

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),  // Registrar aquí
      ],
      child: CooperApp(),
    ),
  );
}

class CooperApp extends StatelessWidget {
  CooperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CooperApp',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
        '/createAccount': (context) => CreateAccountScreen(),
        '/perfil': (context) => PerfilPage(),
      },
    );
  }
}
