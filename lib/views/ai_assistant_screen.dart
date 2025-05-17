import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../widgets/app_drawer.dart'; // Import correcto

class AiAssistantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFCF5),
      drawer: AppDrawer(), // Usa tu Drawer personalizado aquí
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey[800]),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/ardillas.png',
                  height: 40,
                ),
                const Text(
                  "CooperApp",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: [
            const SizedBox(height: 12),
            const Center(
              child: Text(
                "Asistente Inteligente InvierteYa",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.green),
              ),
            ),
            const SizedBox(height: 24),
            _buildOptionCard(
              context,
              title: "Analiza patrones de ahorro",
              subtitle: "Frecuencia, montos e incumplimiento",
              icon: LucideIcons.piggyBank,
            ),
            _buildOptionCard(
              context,
              title: "Predice el abandono de aportes",
              subtitle: "Estima si un usuario va a dejar de aportar",
              icon: LucideIcons.trendingDown,
            ),
            _buildOptionCard(
              context,
              title: "Sugerir nuevas metas o reajustes",
              subtitle: "Propone metas diferentes o ajustes automáticos",
              icon: LucideIcons.target,
            ),
            _buildOptionCard(
              context,
              title: "Recomienda turnos más justos",
              subtitle: "Evaluar turnos viables en cuentas mancomunadas",
              icon: LucideIcons.userCheck,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(BuildContext context,
      {required String title,
        required String subtitle,
        required IconData icon}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5C778),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(2, 4))
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.teal),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.teal[900]),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(icon, size: 32, color: Colors.black),
        ],
      ),
    );
  }
}
