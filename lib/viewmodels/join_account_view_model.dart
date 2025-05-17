import 'package:flutter/material.dart';

class JoinAccountViewModel extends ChangeNotifier {
  int _notificationCount = 0;
  int get notificationCount => _notificationCount;

  final String codigoCuenta = 'A1B2-C3D4!';

  final List<String> miembros = [
    'Juan Pérez',
    'María López',
    'Carlos Martínez',
    'Ana Gómez',
    'Luis Fernández',
  ];

  void mostrarNotificaciones(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lista de solicitudes para unirse a la cuenta'),
        content: const Text('No hay solicitudes pendientes.'), // Reemplazar lógica real aquí
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
    resetNotificationCount();
  }

  void resetNotificationCount() {
    _notificationCount = 0;
    notifyListeners();
  }

  void incrementarNotificaciones() {
    _notificationCount++;
    notifyListeners();
  }
}