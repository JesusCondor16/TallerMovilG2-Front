import 'package:flutter/material.dart';
import '../models/account_model.dart';

class CuentaDuenoPage extends StatelessWidget {
  final AccountModel account;

  const CuentaDuenoPage({super.key, required this.account});

  static const _menuAnadir = 'añadir';
  static const _menuCodigo = 'codigo';
  static const _menuHistorial = 'historial';

  void _handleMenuSelection(BuildContext context, String value) {
    switch (value) {
      case _menuAnadir:
        _showMessage(context, 'Añadir miembros');
        break;
      case _menuCodigo:
        _showMessage(context, 'Código generado');
        break;
      case _menuHistorial:
        _showMessage(context, 'Descargando historial');
        break;
    }
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          account.nombreCuenta,  // Cambiado aquí
          style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) => _handleMenuSelection(context, value),
            itemBuilder: (context) => const [
              PopupMenuItem(value: _menuAnadir, child: Text('Añadir miembros')),
              PopupMenuItem(value: _menuCodigo, child: Text('Generar código')),
              PopupMenuItem(value: _menuHistorial, child: Text('Descargar historial')),
            ],
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[100],
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tarjeta de saldo
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Saldo disponible',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${account.moneda} ${account.saldo.toStringAsFixed(2)}',  // Cambiado aquí
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Mostrar más info del modelo si quieres:
              Text('Estado: ${account.estado}',
                  style: theme.textTheme.bodyMedium),
              Text('Tipo: ${account.tipo}', style: theme.textTheme.bodyMedium),
              Text('Descripción: ${account.descripcion}',
                  style: theme.textTheme.bodyMedium),
              Text('Creado por: ${account.creadorNombre}',
                  style: theme.textTheme.bodyMedium),
              Text(
                'Fecha de creación: ${account.fechaCreacion.toLocal().toString().split(' ')[0]}',
                style: theme.textTheme.bodyMedium,
              ),

              const SizedBox(height: 30),

              // Título movimientos
              Text(
                'Últimos movimientos',
                style:
                theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),

              // Lista simulada de movimientos
              _buildMovimientoItem('Depósito', 100.00, Colors.green),
              const SizedBox(height: 10),
              _buildMovimientoItem('Retiro', 50.00, Colors.red),
              const SizedBox(height: 10),
              _buildMovimientoItem('Depósito', 200.00, Colors.green),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovimientoItem(String tipo, double monto, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: ListTile(
        leading: Icon(
          tipo == 'Depósito' ? Icons.arrow_downward : Icons.arrow_upward,
          color: color,
        ),
        title: Text(tipo),
        trailing: Text(
          '${account.moneda} ${monto.toStringAsFixed(2)}',  // También aquí para moneda
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
