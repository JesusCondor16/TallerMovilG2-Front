import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/predice_abandono_view_model.dart';

class PrediceAbandonoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PrediceAbandonoViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFCF5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SizedBox(
              height: kToolbarHeight,
              child: Center(
                child: Image.asset(
                  'assets/images/ardillas.png',
                  height: 48,
                ),
              ),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        children: [
          const SizedBox(height: 16),
          const Center(
            child: Text(
              "Predicción de abandono de aportes",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.green,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Gráfico simulado
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Probabilidad de Abandono",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Image.asset(
                'assets/images/abandono.jpg',
                fit: BoxFit.cover,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Alertas con datos del ViewModel
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE0B2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Alertas de Incumplimientos",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 12),
                ...viewModel.alertas.map((alert) => Column(
                  children: [
                    _alertItem(
                      alert.contains("frecuencia") ? Icons.calendar_today : Icons.attach_money,
                      alert,
                    ),
                    const SizedBox(height: 12),
                  ],
                )).toList(),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Mensaje final desde el ViewModel
          Row(
            children: [
              const Icon(Icons.warning, color: Colors.red),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  viewModel.riesgo,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _alertItem(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.green),
            ),
          )
        ],
      ),
    );
  }
}
