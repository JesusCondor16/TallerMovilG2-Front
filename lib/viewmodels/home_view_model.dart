import 'package:flutter/material.dart';
import '../models/account_model.dart';

class HomeViewModel extends ChangeNotifier {
  List<AccountModel> allAccounts = [];

  HomeViewModel() {
    loadAccounts(); // Simula la carga (puedes integrarlo con Firebase)
  }

  void loadAccounts() {
    allAccounts = [
      AccountModel(id: '1', name: 'Cuenta Principal', balance: 1250.0, isOwner: true),
      AccountModel(id: '2', name: 'Cuenta Familiar', balance: 500.0, isOwner: false),
    ];
    notifyListeners();
  }

  List<AccountModel> get ownerAccounts =>
      allAccounts.where((acc) => acc.isOwner).toList();

  List<AccountModel> get memberAccounts =>
      allAccounts.where((acc) => !acc.isOwner).toList();
}
