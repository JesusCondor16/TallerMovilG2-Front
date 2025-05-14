import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/register_model.dart'; // Importa el modelo de registro
import '../config/constants.dart';

class RegisterViewModel extends ChangeNotifier {
  // Controllers for each input field
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneController = TextEditingController();
  final dniController = TextEditingController();
  final tipoDocumentoController = TextEditingController();

  Future<void> registerUser(BuildContext context) async {
    // Crear la instancia de RegisterModel con los datos de los controllers
    final registerModel = RegisterModel(
      email: emailController.text,
      password: passwordController.text,
      firstname: firstnameController.text,
      lastname: lastnameController.text,
      tipoDocumento: tipoDocumentoController.text,
      dni: dniController.text,
      telefono: phoneController.text,
      username: usernameController.text,
    );

    // Hacer la solicitud de registro
    final response = await _register(registerModel);

    if (response != null) {
      // Manejar éxito (por ejemplo, navegar a la página principal)
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Manejar error (por ejemplo, mostrar un mensaje de error)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al registrar, intente nuevamente')),
      );
    }
  }

  Future<Map<String, dynamic>?> _register(RegisterModel registerModel) async {
    final url = Uri.parse('${AppConstants.backendBaseUrl}v1/auth/register');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(registerModel.toJson()), // Usar el método toJson de RegisterModel
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data; // Contiene la respuesta (accessToken, etc.)
    } else {
      print('Error al hacer registro: ${response.statusCode}');
      print(response.body);
      return null;
    }
  }
}
