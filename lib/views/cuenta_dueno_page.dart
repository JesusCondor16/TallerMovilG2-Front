import 'package:flutter/material.dart';
import '../models/account_model.dart';

class CuentaDuenoPage extends StatelessWidget {
  final AccountModel account;

  const CuentaDuenoPage({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(account.name),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'añadir':
                // Acción para añadir miembros
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Añadir miembros')));
                  break;
                case 'codigo':
                // Acción para generar código
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Código generado')));
                  break;
                case 'historial':
                // Acción para descargar historial
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Descargando historial')));
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'añadir', child: Text('Añadir miembros')),
              const PopupMenuItem(value: 'codigo', child: Text('Generar código')),
              const PopupMenuItem(value: 'historial', child: Text('Descargar historial')),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Saldo: S/.${account.balance.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const Text(
              'Movimientos (depósitos y retiros):',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Aquí puedes usar un ListView.builder si tienes movimientos reales
            const Text('• Depósito - S/. 100.00'),
            const Text('• Retiro - S/. 50.00'),
            const Text('• Depósito - S/. 200.00'),
          ],
        ),
      ),
    );
  }
}

