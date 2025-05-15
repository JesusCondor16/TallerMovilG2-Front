import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/create_account_view_model.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateAccountViewModel(),
      child: Consumer<CreateAccountViewModel>(
        builder: (context, viewModel, _) => Scaffold(
          appBar: AppBar(
            title: const Text('Crear Cuenta'),
            backgroundColor: Colors.green,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Text(
                    'Crear Nueva Cuenta',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Campo para el nombre
                TextField(
                  controller: viewModel.nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    prefixIcon: Icon(Icons.account_circle),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 20),

                // Campo para el tipo
                TextField(
                  controller: viewModel.tipoController,
                  decoration: const InputDecoration(
                    labelText: 'Tipo',
                    prefixIcon: Icon(Icons.category),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 20),

                // Campo para la moneda
                TextField(
                  controller: viewModel.monedaController,
                  decoration: const InputDecoration(
                    labelText: 'Moneda',
                    prefixIcon: Icon(Icons.monetization_on),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 20),

                // Campo para el saldo
                TextField(
                  controller: viewModel.saldoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Saldo',
                    prefixIcon: Icon(Icons.attach_money),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 20),

                // Campo para la descripción
                TextField(
                  controller: viewModel.descripcionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Descripción',
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 30),

                // Botón para crear la cuenta
                ElevatedButton.icon(
                  onPressed: () => viewModel.createAccount(context),
                  icon: const Icon(Icons.check),
                  label: const Text('Crear Cuenta', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
