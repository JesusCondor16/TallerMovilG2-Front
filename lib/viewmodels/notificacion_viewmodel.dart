import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import '../services/notification_service.dart';

class NotificationViewModel extends ChangeNotifier {
  final NotificationService _service = NotificationService();
  List<NotificationModel> _notificaciones = [];

  List<NotificationModel> get notificaciones => _notificaciones;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> fetchNotificaciones(String cuentaId) async {
    _loading = true;
    notifyListeners();
    try {
      _notificaciones = await _service.getNotificaciones(cuentaId);
    } catch (e) {
      debugPrint('Error al obtener notificaciones: $e');
      _notificaciones = [];
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}