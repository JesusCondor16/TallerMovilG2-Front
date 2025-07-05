import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/constants.dart';
import '../models/notification_model.dart';

class NotificationService {
  final String _baseUrl = AppConstants.backendBaseUrl;

  Future<List<NotificationModel>> getNotificaciones(String cuentaId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) throw Exception('Token no encontrado');

    final url = Uri.parse('${_baseUrl}v1/notifications/get-all?cuentaId=$cuentaId');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(utf8.decode(response.bodyBytes));
      return jsonList.map((json) => NotificationModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener notificaciones: ${response.statusCode}');
    }
  }
}
