import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/constants.dart';

class NotificationService {
  final String _baseUrl = AppConstants.backendBaseUrl;

  String? _getUidFromToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length == 3) {
        final payload = base64Url.decode(base64Url.normalize(parts[1]));
        final payloadMap = jsonDecode(utf8.decode(payload));
        return payloadMap['sub'];
      }
    } catch (e) {
      print('Error al decodificar token: $e');
    }
    return null;
  }

  /// Enviar solicitud de acceso a una cuenta
  Future<bool> requestAccess(String code) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print('Token no encontrado.');
      return false;
    }

    final uid = _getUidFromToken(token);
    if (uid == null) {
      print('UID no encontrado en el token.');
      return false;
    }
    final url = Uri.parse(
      '${_baseUrl}v1/notifications/request-access?code=$code&requesterUid=$uid',
    );

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('Solicitud enviada correctamente');
      return true;
    } else {
      print('Error al solicitar acceso: ${response.statusCode}');
      print(response.body);
      return false;
    }
  }
}
