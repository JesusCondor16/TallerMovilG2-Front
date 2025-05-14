import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/create_account_model.dart';
import '../config/constants.dart';

class AccountService {
  final String _baseUrl = AppConstants.backendBaseUrl;

  // Función para decodificar el token JWT y obtener el UID
  String? _getUidFromToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length == 3) {
        final payload = base64Url.decode(base64Url.normalize(parts[1]));
        final payloadMap = jsonDecode(utf8.decode(payload));
        return payloadMap['sub']; // Cambia 'uid' por el nombre correcto si es necesario
      }
      return null;
    } catch (e) {
      print('Error al decodificar el token: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> createAccount(CreateAccountModel model) async {
    final url = Uri.parse('${_baseUrl}v1/accounts/create');

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print('Token no encontrado. Usuario no autenticado.');
      return null;
    }

    final uid = _getUidFromToken(token);
    if (uid == null) {
      print('No se pudo extraer el UID del token.');
      return null;
    }

    // Ahora se asigna el UID obtenido al modelo sin que el usuario lo ingrese
    final account = CreateAccountModel(
      nombre: model.nombre,
      tipo: model.tipo,
      moneda: model.moneda,
      saldo: model.saldo,
      descripcion: model.descripcion,
      creadorUid: uid, // El UID ahora proviene del token
    );

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Enviar el token
      },
      body: jsonEncode(account.toJson()),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error al crear cuenta: ${response.statusCode}');
      print(response.body);
      return null;
    }
  }
}

