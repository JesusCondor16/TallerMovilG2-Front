import 'package:flutter/material.dart';

class EditarPerfilPage extends StatefulWidget {
  const EditarPerfilPage({super.key});

  @override
  State<EditarPerfilPage> createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends State<EditarPerfilPage> {
  // Datos simulados (en la práctica vendrían del ViewModel)
  final nombreCompleto = 'Juan Pérez';
  final documento = '12345678';
  final fechaNacimiento = '01/01/1990';

  final TextEditingController emailController =
  TextEditingController(text: 'juan@example.com');
  final TextEditingController telefonoController =
  TextEditingController(text: '987654321');

  void _confirmarGuardado() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Guardar datos cambiados?'),
        content: const Text('Se actualizará la información de contacto.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Cancelar
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar diálogo
              Navigator.of(context).pop(); // Volver a PerfilPage
              // Aquí podrías llamar a tu ViewModel para guardar los cambios
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Datos guardados')),
              );
            },
            child: const Text(
              'Confirmar',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Editar Perfil',
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
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            const Text('Número de teléfono'),
            TextFormField(
              controller: telefonoController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                onPressed: _confirmarGuardado,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text(
                  'Guardar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}