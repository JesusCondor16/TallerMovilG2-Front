import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/notificacion_viewmodel.dart';


class NotificacionesScreen extends StatefulWidget {
  final String cuentaId;
  const NotificacionesScreen({Key? key, required this.cuentaId}) : super(key: key);

  @override
  State<NotificacionesScreen> createState() => _NotificacionesScreenState();
}

class _NotificacionesScreenState extends State<NotificacionesScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NotificationViewModel>(context, listen: false)
        .fetchNotificaciones(widget.cuentaId);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NotificationViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
        backgroundColor: Colors.green,
      ),
      body: viewModel.loading
          ? const Center(child: CircularProgressIndicator())
          : viewModel.notificaciones.isEmpty
          ? const Center(child: Text('No hay notificaciones.'))
          : ListView.builder(
        itemCount: viewModel.notificaciones.length,
        itemBuilder: (context, index) {
          final noti = viewModel.notificaciones[index];
          return ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(noti.titulo ?? ''),
            subtitle: Text(noti.descripcion ?? ''),
            trailing: Text(noti.fecha ?? ''),
          );
        },
      ),
    );
  }
}
