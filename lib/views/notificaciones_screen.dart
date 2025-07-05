import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
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
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    await Provider.of<NotificationViewModel>(context, listen: false)
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
          : RefreshIndicator(
        onRefresh: _loadNotifications,
        child: viewModel.notificaciones.isEmpty
            ? const Center(child: Text('No hay notificaciones.'))
            : ListView.builder(
          itemCount: viewModel.notificaciones.length,
          itemBuilder: (context, index) {
            final noti = viewModel.notificaciones[index];
            final date = _formatDate(noti.fechaCreacion);
            final icon = _getIcon(noti.tipo);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(icon, color: Colors.green),
                  title: Text(noti.tipo ?? 'Notificación'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (noti.mensaje != null)
                        Text(noti.mensaje!),
                      if (date != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            date,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Formatea fecha ISO a formato local legible
  String? _formatDate(String? isoDate) {
    if (isoDate == null) return null;
    try {
      final parsed = DateTime.parse(isoDate);
      return DateFormat('dd MMM yyyy – HH:mm').format(parsed);
    } catch (e) {
      return isoDate;
    }
  }

  /// Selecciona icono según tipo
  IconData _getIcon(String? tipo) {
    switch (tipo) {
      case 'INVITACION_ACCESO_CUENTA':
        return Icons.mail_outline; // Invitación
      case 'SOLICITUD_ACCESO_CUENTA':
        return Icons.lock_open; // Solicitud de acceso
      case 'REPORTE_CUENTA':
        return Icons.report_problem; // Reporte
      case 'DEPOSITO':
        return Icons.attach_money; // Depósito
      case 'RETIRO':
        return Icons.money_off; // Retiro
      case 'TRANSFERENCIA':
        return Icons.swap_horiz; // Transferencia
      case 'ALERTA':
        return Icons.warning; // Genérica de alerta
      case 'INFO':
      default:
        return Icons.notifications; // Genérico
    }
  }

}
