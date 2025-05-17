import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Seguro que quieres cerrar sesión?'),
        content: const Text('Perderás tu sesión actual.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Cierra el diálogo
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Cierra el diálogo primero
              await Provider.of<AuthViewModel>(context, listen: false).logout(context);
            },
            child: const Text(
              'Cerrar sesión',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.green),
            child: Text('CooperApp', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
              Navigator.pop(context); // Cierra el Drawer
              Navigator.pushNamed(context, '/perfil');
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance),
            title: const Text('Crear cuenta'),
            onTap: () => Navigator.pushNamed(context, '/createAccount'),
          ),
          ListTile(
            leading: const Icon(Icons.group_add),
            title: const Text('Unirme a una cuenta'),
            onTap: () => Navigator.pushNamed(context, '/joinAccount'),
          ),
          ListTile(
            leading: const Icon(Icons.report),
            title: const Text('Denunciar cuenta'),
            onTap: () => Navigator.pushNamed(context, '/reportAccount'),
          ),
          ListTile(
            leading: const Icon(Icons.savings),
            title: const Text('AhorraYa'),
            onTap: () => Navigator.pushNamed(context, '/invierteYa'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar sesión'),
            onTap: () => _confirmLogout(context),
          ),
        ],
      ),
    );
  }
}
