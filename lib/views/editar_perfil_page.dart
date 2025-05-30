import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class EditarPerfilPage extends StatefulWidget {
  final UserModel user;

  const EditarPerfilPage({super.key, required this.user});

  @override
  State<EditarPerfilPage> createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends State<EditarPerfilPage> {
  late TextEditingController emailController;
  late TextEditingController telefonoController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.user.email);
    telefonoController = TextEditingController(text: widget.user.telefono);
  }

  Future<void> _guardarCambios() async {
    final userService = UserService();
    final success = await userService.updateUser(
      emailController.text.trim(),
      telefonoController.text.trim(),
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos actualizados con éxito')),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al guardar los cambios')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;

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
            _buildReadOnlyField('Nombre completo', user.nombre),
            _buildReadOnlyField('Documento de identidad', user.dni),
            _buildReadOnlyField(
              'Fecha de nacimiento',
              user.fechaNacimiento != null && user.fechaNacimiento.isNotEmpty
                  ? DateFormat('dd MMMM yyyy').format(DateTime.parse(user.fechaNacimiento))
                  : '',
            ),
            _buildEditableField('Correo electrónico', emailController),
            _buildEditableField('Número de teléfono', telefonoController),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _guardarCambios,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text('Guardar', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextFormField(
          initialValue: value,
          readOnly: true,
          showCursor: false,
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Color(0xFFE0E0E0), // gris claro
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
