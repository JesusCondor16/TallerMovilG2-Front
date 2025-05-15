import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  Future<void> logout(BuildContext context) async {
    await _authService.logout(); // Aquí limpias sesión, token, etc.
    Navigator.pushReplacementNamed(context, '/login');
  }
}