import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/create_account_model.dart';
import '../models/account_model.dart';
import '../config/constants.dart';

class AccountService {
  final String _baseUrl = AppConstants.backendBaseUrl;

  // Decodifica el JWT para extraer el UID del usuario
  String? _getUidFromToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length == 3) {
        final payload = base64Url.decode(base64Url.normalize(parts[1]));
        final payloadMap = jsonDecode(utf8.decode(payload));
        return payloadMap['sub'];
      }
    } catch (e) {
      print('Error al decodificar el token: $e');
    }
    return null;
  }

  /// Crear una nueva cuenta
  Future<Map<String, dynamic>?> createAccount(CreateAccountModel model) async {
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

    final account = CreateAccountModel(
      nombre: model.nombre,
      tipo: model.tipo,
      moneda: model.moneda,
      saldo: model.saldo,
      descripcion: model.descripcion,
      creadorUid: uid,
    );

    final url = Uri.parse('${_baseUrl}v1/accounts/create');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(account.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      print('Error al crear cuenta: ${response.statusCode}');
      print(response.body);
      return null;
    }
  }

  /// Obtener cuentas donde el usuario es dueño
  Future<List<AccountModel>> getAccountsWhereOwner() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print('Token no encontrado. Usuario no autenticado.');
      return [];
    }

    final uid = _getUidFromToken(token);
    if (uid == null) {
      print('No se pudo extraer el UID del token.');
      return [];
    }

    final url = Uri.parse('${_baseUrl}v1/accounts/get-owner/$uid');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => AccountModel.fromJson(json)).toList();
    } else {
      print('Error al obtener cuentas como dueño: ${response.statusCode}');
      print(response.body);
      return [];
    }
  }

  /// Obtener cuentas donde el usuario es miembro
  Future<List<AccountModel>> getAccountsWhereMember() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print('Token no encontrado. Usuario no autenticado.');
      return [];
    }

    final uid = _getUidFromToken(token);
    if (uid == null) {
      print('No se pudo extraer el UID del token.');
      return [];
    }

    final url = Uri.parse('${_baseUrl}v1/accounts/get-member/$uid');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => AccountModel.fromJson(json)).toList();
    } else {
      print('Error al obtener cuentas como miembro: ${response.statusCode}');
      print(response.body);
      return [];
    }
  }
  Future<String?> generateInviteCode(String cuentaId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print('Token no encontrado.');
      return null;
    }

    final url = Uri.parse('${_baseUrl}v1/accounts/generate-code?cuentaId=$cuentaId');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return response.body.replaceAll('"', ''); // en caso el backend retorne un JSON string con comillas
    } else {
      print('Error al generar código: ${response.statusCode}');
      print(response.body);
      return null;
    }
  }
  /// Invitar un miembro a la cuenta
  Future<bool> inviteMember({
    required String email,
    required String cuentaId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print('Token no encontrado. Usuario no autenticado.');
      return false;
    }

    // Extraemos el UID del dueño desde el token (inviterUid)
    final uid = _getUidFromToken(token);
    if (uid == null) {
      print('No se pudo extraer el UID del token.');
      return false;
    }

    final url = Uri.parse(
      '${_baseUrl}v1/notifications/invite-member?email=$email&cuentaId=$cuentaId&inviterUid=$uid',
    );

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('Invitación enviada correctamente');
      return true;
    } else {
      print('Error al invitar miembro: ${response.statusCode}');
      print(response.body);
      return false;
    }
  }

}
