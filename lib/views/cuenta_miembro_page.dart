import 'package:flutter/material.dart';
import '../models/account_model.dart';

class CuentaMiembroPage extends StatelessWidget {
  final AccountModel account;

  const CuentaMiembroPage({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(account.name),
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
            // Aquí también puedes mostrar datos dinámicos si los tienes
            const Text('• Depósito - S/. 100.00'),
            const Text('• Retiro - S/. 30.00'),
          ],
        ),
      ),
    );
  }
}
