import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/create_account_view_model.dart';

class CreateAccountScreen extends StatelessWidget {
  // Se elimina el const, ya que el constructor no es constante
  CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateAccountViewModel(),
      child: Consumer<CreateAccountViewModel>(
        builder: (context, viewModel, _) => Scaffold(
          appBar: AppBar(title: const Text('Crear Cuenta')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                // Campo para el nombre de la cuenta
                TextField(
                  controller: viewModel.nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                // Campo para el tipo de la cuenta
                TextField(
                  controller: viewModel.tipoController,
                  decoration: const InputDecoration(labelText: 'Tipo'),
                ),
                // Campo para la moneda de la cuenta
                TextField(
                  controller: viewModel.monedaController,
                  decoration: const InputDecoration(labelText: 'Moneda'),
                ),
                // Campo para el saldo de la cuenta
                TextField(
                  controller: viewModel.saldoController,
                  decoration: const InputDecoration(labelText: 'Saldo'),
                  keyboardType: TextInputType.number,
                ),
                // Campo para la descripción de la cuenta
                TextField(
                  controller: viewModel.descripcionController,
                  decoration: const InputDecoration(labelText: 'Descripción'),
                ),
                const SizedBox(height: 20),
                // Botón para crear la cuenta
                ElevatedButton(
                  onPressed: () => viewModel.createAccount(context),
                  child: const Text('Crear Cuenta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
