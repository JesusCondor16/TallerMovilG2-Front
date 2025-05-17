import 'package:flutter/material.dart';

class ReportViewModel extends ChangeNotifier {
  String selectedAccount = '';
  String reason = '';
  final List<String> evidences = [];

  void updateAccount(String? account) {
    selectedAccount = account ?? '';
    notifyListeners();
  }

  void updateReason(String text) {
    reason = text;
    notifyListeners();
  }

  void addEvidence(String fileName) {
    if (evidences.length < 3) {
      evidences.add(fileName);
      notifyListeners();
    }
  }

  Future<void> submitReport() async {
    if (selectedAccount.isEmpty || reason.isEmpty) {
      // Aquí podrías lanzar una excepción, mostrar error, o similar
      return;
    }

    // Aquí iría la lógica real para enviar el reporte (API, DB, etc)
    // Por ejemplo:
    await Future.delayed(const Duration(seconds: 1)); // Simula llamada remota

    // Luego limpiar datos para nuevo reporte
    selectedAccount = '';
    reason = '';
    evidences.clear();
    notifyListeners();
  }

  // Método para preparar el formulario si quieres limpiar cuando abres pantalla
  void prepareReport() {
    selectedAccount = '';
    reason = '';
    evidences.clear();
    notifyListeners();
  }
}