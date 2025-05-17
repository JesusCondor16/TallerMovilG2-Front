import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/report_viewmodel.dart';

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
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
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

  void _navigateToReportAccount(BuildContext context) {
    final reportVM = Provider.of<ReportViewModel>(context, listen: false);
    reportVM.prepareReport();
    Navigator.pop(context);
    Navigator.pushNamed(context, '/reportAccount');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.green),
            child: Text(
              'CooperApp',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/perfil');
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance),
            title: const Text('Crear cuenta'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/createAccount');
            },
          ),
          ListTile(
            leading: const Icon(Icons.group_add),
            title: const Text('Unirme a una cuenta'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/joinAccount');
            },
          ),
          ListTile(
            leading: const Icon(Icons.money_off),
            title: const Text('Solicitar retiro'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/solicitarRetiro');
            },
          ),
          ListTile(
            leading: const Icon(Icons.savings),
            title: const Text('Ahorra Ya'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/aiAssistant');
            },
          ),
          ListTile(
            leading: const Icon(Icons.report_problem),
            title: const Text('Denunciar cuenta'),
            onTap: () => _navigateToReportAccount(context),
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
