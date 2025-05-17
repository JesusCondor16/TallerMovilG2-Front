import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/login_page.dart';
import 'views/create_account_screen.dart';
import 'views/register_page.dart';
import 'views/home_page.dart';
import 'views/perfil_page.dart';
import 'views/editar_perfil_page.dart';
import 'views/report_account_screen.dart';
import 'views/ai_assistant_screen.dart';
import 'views/solicitar_retiro_screen.dart';
import 'views/join_account_screen.dart';
import 'views/forgot_password_page.dart';
import 'views/account_detail_page.dart';

import 'viewmodels/login_viewmodel.dart';
import 'viewmodels/join_account_view_model.dart';
import 'viewmodels/create_account_view_model.dart';
import 'viewmodels/register_viewmodel.dart';
import 'viewmodels/report_viewmodel.dart';
import 'viewmodels/ai_assistant_view_model.dart';

import 'viewmodels/login_viewmodel.dart';
import 'viewmodels/register_viewmodel.dart';  // Importa también el RegisterViewModel

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => JoinAccountViewModel()),
        ChangeNotifierProvider(create: (_) => CreateAccountViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => ReportViewModel()),
        ChangeNotifierProvider(create: (_) => AiAssistantViewModel()),
        // Agrega aquí otros viewmodels si los usas en otras vistas
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
        //'/editarPerfil': (context) => EditarPerfilPage(),
        '/reportAccount': (context) => ReportAccountScreen(),
        '/aiAssistant': (context) => AiAssistantScreen(),
        '/solicitarRetiro': (context) => SolicitarRetiroScreen(),
        '/joinAccount': (context) => JoinAccountScreen(),
        '/crearCuenta': (context) => CreateAccountScreen(),
        '/forgotPassword': (context) => ForgotPasswordPage(),
        '/accountDetail': (context) => AccountDetailPage(),
      },
    );
  }
}
