import 'package:flutter/material.dart';
import '../models/user_model.dart';

class RegisterViewModel extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool validateInputs() {
    return usernameController.text.isNotEmpty &&
        passwordController.text.length >= 4;
  }

  void registerUser(BuildContext context) {
    if (!validateInputs()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa correctamente los campos')),
      );
      return;
    }

    final newUser = User(
      username: usernameController.text.trim(),
      password: passwordController.text,
    );

    // Aquí simularías registrar el usuario (ej. guardar en BD, API, etc.)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Usuario ${newUser.username} registrado 🎉')),
    );

    Navigator.pop(context); // Volver al login
  }

  void disposeResources() {
    usernameController.dispose();
    passwordController.dispose();
  }
}
