import 'package:flutter/material.dart';
import '../models/create_account_model.dart';
import '../services/account_service.dart';

class CreateAccountViewModel extends ChangeNotifier {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController tipoController = TextEditingController();
  final TextEditingController monedaController = TextEditingController();
  final TextEditingController saldoController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();

  final AccountService _accountService = AccountService();

  Future<void> createAccount(BuildContext context) async {
    final CreateAccountModel model = CreateAccountModel(
      nombre: nombreController.text,
      tipo: tipoController.text,
      moneda: monedaController.text,
      saldo: double.tryParse(saldoController.text) ?? 0.0,
      descripcion: descripcionController.text,
      creadorUid: '',  // Este campo será reemplazado en el servicio
    );

    final result = await _accountService.createAccount(model);

    if (result != null) {
      // Lógica después de crear la cuenta (puedes mostrar un mensaje o redirigir a otra pantalla)
      print('Cuenta creada exitosamente');
    } else {
      // Lógica en caso de error
      print('Error al crear la cuenta');
    }
  }
}
