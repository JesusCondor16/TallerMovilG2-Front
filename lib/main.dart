import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/login_page.dart';
import 'views/create_account_screen.dart';
import 'views/register_page.dart';
import 'views/home_page.dart';
import 'views/perfil_page.dart';
import 'views/editar_perfil_page.dart';
import 'viewmodels/login_viewmodel.dart'; // Asegúrate de importar tu ViewModel

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: CooperApp(), // Aquí se elimina 'const'
    ),
  );
}

class CooperApp extends StatelessWidget {
  CooperApp({super.key}); // Elimina 'const' aquí también

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CooperApp',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(), // Elimina 'const' aquí
        '/register': (context) => RegisterPage(), // Elimina 'const' aquí
        '/home': (context) => HomePage(), // Elimina 'const' aquí
        '/createAccount': (context) => CreateAccountScreen(), // Elimina 'const' aquí
        '/perfil': (context) => PerfilPage(),
        '/editarPerfil': (context) => EditarPerfilPage(),
      },
    );
  }
}
