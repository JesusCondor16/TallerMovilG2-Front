import 'package:flutter/material.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo (idealmente provendrán del ViewModel)
    final nombreCompleto = 'Juan Pérez';
    final documento = '12345678';
    final fechaNacimiento = '01/01/1990';
    final email = 'juan@example.com';
    final telefono = '987654321';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Perfil',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ),
            const SizedBox(height: 30),

            const Text('Nombre completo'),
            TextFormField(
              initialValue: nombreCompleto,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            const Text('Documento de identidad'),
            TextFormField(
              initialValue: documento,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            const Text('Fecha de nacimiento'),
            TextFormField(
              initialValue: fechaNacimiento,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            const Text('Correo electrónico'),
            TextFormField(
              initialValue: email,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            const Text('Número de teléfono'),
            TextFormField(
              initialValue: telefono,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/editarPerfil');
                },
                child: const Text('Editar perfil', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
